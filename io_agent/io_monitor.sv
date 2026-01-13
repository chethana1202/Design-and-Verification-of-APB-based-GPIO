class io_monitor extends uvm_monitor;

env_config cfg;
virtual interface_io.APB_MON io_vif;
uvm_analysis_port #(io_trans) ap;

`uvm_component_utils(io_monitor)

function new(string name="io_monitor",uvm_component parent=null);
    super.new(name,parent);
    ap=new("ap",this);
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
        collect_data();
    end
endtask:run_phase

task collect_data();
    io_trans xtn = io_trans::type_id::create("xtn");
    
    @(io_vif.io_mon_cb);
    xtn.io_pad = io_vif.io_mon_cb.io_pad;

    if(xtn.io_pad!=32'h0)
    begin
    `uvm_info(get_type_name(),$sformatf("Data sampled from IO Monitor\n:%s",xtn.sprint()),UVM_NONE)

    ap.write(xtn);
    end

endtask:collect_data

endclass:io_monitor
