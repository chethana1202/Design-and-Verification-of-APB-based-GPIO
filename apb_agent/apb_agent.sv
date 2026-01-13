class apb_agent extends uvm_agent;

env_config cfg;
apb_sequencer apb_seqrh;
apb_driver apb_drvh;
apb_monitor apb_monh;

`uvm_component_utils(apb_agent)

function new(string name="apb_agent",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",cfg))
        `uvm_fatal("env_config","cannot get() the configuration cfg")
    
    if(cfg.is_active==UVM_ACTIVE)
    begin
        apb_seqrh = apb_sequencer::type_id::create("apb_seqrh",this);
        apb_drvh = apb_driver::type_id::create("apb_drvh",this);
    end

    apb_monh = apb_monitor::type_id::create("apb_monh",this);

    super.build_phase(phase);
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    if(cfg.is_active==UVM_ACTIVE)
    apb_drvh.seq_item_port.connect(apb_seqrh.seq_item_export);
endfunction:connect_phase

endclass:apb_agent
