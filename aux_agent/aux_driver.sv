class aux_driver extends uvm_driver #(aux_trans);

env_config cfg;
virtual interface_aux.AUX_DRV aux_vif;

`uvm_component_utils(aux_driver)

function new(string name="aux_driver",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",cfg)) 
        `uvm_fatal("env_config","cannot get() the configuration cfg")
endfunction:build_phase

function void connect_phase(uvm_phase phase);
   aux_vif=cfg.aux_vif;
endfunction:connect_phase

task run_phase(uvm_phase phase);
    forever
        begin
            seq_item_port.get_next_item(req);
            send_to_dut(req);
            seq_item_port.item_done();
        end
endtask:run_phase

task send_to_dut(aux_trans xtn);
    @(aux_vif.aux_drv_cb);
    aux_vif.aux_drv_cb.aux_in <= xtn.aux_in;
endtask:send_to_dut

endclass:aux_driver
