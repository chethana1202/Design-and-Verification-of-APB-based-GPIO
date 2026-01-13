class io_agent extends uvm_agent;

env_config cfg;
io_sequencer io_seqrh;
io_driver io_drvh;
io_monitor io_monh;

`uvm_component_utils(io_agent)

function new(string name="io_agent",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",cfg))
        `uvm_fatal("env_config","cannot get() the configuration cfg")

    if(cfg.is_active==UVM_ACTIVE)
    begin
        io_seqrh=io_sequencer::type_id::create("io_seqrh",this);
        io_drvh=io_driver::type_id::create("io_drvh",this);
    end

    io_monh=io_monitor::type_id::create("io_monh",this);

    super.build_phase(phase);
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    if(cfg.is_active==UVM_ACTIVE)
    io_drvh.seq_item_port.connect(io_seqrh.seq_item_export);
endfunction:connect_phase

endclass:io_agent
