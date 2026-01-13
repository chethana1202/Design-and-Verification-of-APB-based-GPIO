class apb_driver extends uvm_driver #(apb_trans);

env_config cfg;
virtual interface_apb.APB_DRV apb_vif;

`uvm_component_utils(apb_driver)

function new(string name="apb_driver",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",cfg))
        `uvm_fatal("env_config","cannot get() the configuration cfg")
    super.build_phase(phase);
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    apb_vif=cfg.apb_vif;
endfunction:connect_phase

task run_phase(uvm_phase phase);
    @(apb_vif.apb_drv_cb);
    apb_vif.apb_drv_cb.presetn <= 1'b0;
    apb_vif.apb_drv_cb.psel <= 1'b0;
    apb_vif.apb_drv_cb.penable <= 1'b0;
    @(apb_vif.apb_drv_cb);
    apb_vif.apb_drv_cb.presetn <= 1'b1;

    forever
        begin
            seq_item_port.get_next_item(req);
            send_to_dut(req);
            seq_item_port.item_done();
        end
endtask:run_phase

task send_to_dut(apb_trans xtn);
    //setup state
    @(apb_vif.apb_drv_cb);
    apb_vif.apb_drv_cb.psel <= 1'b1;
    apb_vif.apb_drv_cb.pwrite <= xtn.pwrite;
    apb_vif.apb_drv_cb.paddr <= xtn.paddr;
    apb_vif.apb_drv_cb.pwdata <= xtn.pwdata;
    apb_vif.apb_drv_cb.penable <= 1'b0;
    @(apb_vif.apb_drv_cb);

    //enable state
    apb_vif.apb_drv_cb.psel <= 1'b1;
    apb_vif.apb_drv_cb.pwrite <= xtn.pwrite;
    apb_vif.apb_drv_cb.paddr <= xtn.paddr;
    apb_vif.apb_drv_cb.pwdata <= xtn.pwdata;
    apb_vif.apb_drv_cb.penable <= 1'b1;
 
    while(!apb_vif.apb_drv_cb.pready)   // indicates dedicated write/read operation from DUT is completed
    @(apb_vif.apb_drv_cb);

    //deassert penable
    apb_vif.apb_drv_cb.penable <= 1'b0;
endtask:send_to_dut

endclass:apb_driver
