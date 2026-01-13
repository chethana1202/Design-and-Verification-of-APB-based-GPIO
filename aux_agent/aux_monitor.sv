class aux_monitor extends uvm_monitor;

env_config cfg;
virtual interface_aux.AUX_MON aux_vif;
uvm_analysis_port #(aux_trans) ap;

`uvm_component_utils(aux_monitor)

function new(string name="aux_monitor",uvm_component parent=null);
    super.new(name,parent);
    ap=new("ap",this);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",cfg))
        `uvm_fatal("env_config","cannot get() the configuration cfg")
    super.build_phase(phase);
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    aux_vif=cfg.aux_vif;
endfunction:connect_phase

task run_phase(uvm_phase phase);
forever
    begin
        collect_data();
    end
endtask:run_phase

task collect_data();
    aux_trans xtn = aux_trans::type_id::create("xtn");

    @(aux_vif.aux_mon_cb);
    xtn.aux_in =  aux_vif.aux_mon_cb.aux_in;
    
    `uvm_info(get_type_name(),$sformatf("Data sampled from the AUX monitor\n:%s",xtn.sprint()),UVM_NONE)

    ap.write(xtn);

endtask:collect_data

endclass:aux_monitor
