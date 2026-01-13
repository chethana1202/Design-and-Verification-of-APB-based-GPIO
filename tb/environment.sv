class environment extends uvm_env;

env_config cfg;
apb_agent apb_agnth;
aux_agent aux_agnth;
io_agent io_agnth;
scoreboard sbh;
virtual_sequencer vseqrh;

`uvm_component_utils(environment)

function new(string name="env",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",cfg))
        `uvm_fatal("env_config","cannot get() the configuration cfg")

    apb_agnth=apb_agent::type_id::create("apb_agnth",this);
    aux_agnth=aux_agent::type_id::create("aux_agnth",this);
    io_agnth=io_agent::type_id::create("io_agnth",this);

    if(cfg.has_scoreboard)
    sbh=scoreboard::type_id::create("sbh",this);

    if(cfg.has_virtual_sequencer)
    vseqrh=virtual_sequencer::type_id::create("vseqrh",this);

    super.build_phase(phase);
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    if(cfg.has_virtual_sequencer)
    begin
        vseqrh.apb_seqrh=apb_agnth.apb_seqrh;
        vseqrh.aux_seqrh=aux_agnth.aux_seqrh;
        vseqrh.io_seqrh=io_agnth.io_seqrh;
    end

    apb_agnth.apb_monh.ap.connect(sbh.fifoh_apb.analysis_export);
    aux_agnth.aux_monh.ap.connect(sbh.fifoh_aux.analysis_export);
    io_agnth.io_monh.ap.connect(sbh.fifoh_io.analysis_export);

endfunction:connect_phase

endclass:environment
