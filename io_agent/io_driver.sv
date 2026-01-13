class io_driver extends uvm_driver #(io_trans);

env_config cfg;
virtual interface_io.IO_DRV io_vif;

`uvm_component_utils(io_driver)

function new(string name="io_driver",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",cfg))
        `uvm_fatal("env_config","cannot get() the configuration cfg")
    super.build_phase(phase);
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    io_vif=cfg.io_vif;
endfunction:connect_phase

task run_phase(uvm_phase phase);
    forever
        begin
            seq_item_port.get_next_item(req);
            send_to_dut(req);
            seq_item_port.item_done();
        end
endtask:run_phase

task send_to_dut(io_trans xtn);
    @(io_vif.io_drv_cb);
    io_vif.io_drv_cb.io_pad <= xtn.io_pad;
 endtask:send_to_dut

endclass:io_driver
