class aux_agent extends uvm_agent;

env_config cfg;
aux_sequencer aux_seqrh;
aux_driver aux_drvh;
aux_monitor aux_monh;

`uvm_component_utils(aux_agent)

function new(string name="aux_agent",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",cfg))
        `uvm_fatal("env_config","cannot get() the configuration cfg")

    if(cfg.is_active==UVM_ACTIVE)
    begin
        aux_seqrh = aux_sequencer::type_id::create("aux_seqrh",this);
        aux_drvh = aux_driver::type_id::create("aux_drvh",this);
    end

    aux_monh = aux_monitor::type_id::create("aux_monh",this);

    super.build_phase(phase);
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    if(cfg.is_active==UVM_ACTIVE)
    aux_drvh.seq_item_port.connect(aux_seqrh.seq_item_export);
endfunction:connect_phase

endclass:aux_agent
