class apb_monitor extends uvm_monitor;

env_config cfg;
virtual interface_apb.APB_MON apb_vif;
uvm_analysis_port #(apb_trans) ap;

`uvm_component_utils(apb_monitor)

function new(string name="apb_monitor",uvm_component parent=null);
    super.new(name,parent);
    ap=new("ap",this);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",cfg))
        `uvm_fatal("env config","cannot get() the configuration cfg")
    super.build_phase(phase);
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    apb_vif=cfg.apb_vif;
endfunction:connect_phase

task run_phase(uvm_phase phase);
forever
    begin
        collect_data();
    end
endtask:run_phase

task collect_data();
    apb_trans xtn = apb_trans::type_id::create("xtn");
    
    xtn.presetn = apb_vif.apb_mon_cb.presetn; 
    @(apb_vif.apb_mon_cb);   
    xtn.psel = apb_vif.apb_mon_cb.psel;
    xtn.pwrite = apb_vif.apb_mon_cb.pwrite;
    xtn.paddr = apb_vif.apb_mon_cb.paddr;
    xtn.penable = apb_vif.apb_mon_cb.penable;
    xtn.pready = apb_vif.apb_mon_cb.pready;
    xtn.irq = apb_vif.apb_mon_cb.irq;

    while(!apb_vif.apb_mon_cb.pready)
    @(apb_vif.apb_mon_cb);

    xtn.penable = apb_vif.apb_mon_cb.penable;
    xtn.pready = apb_vif.apb_mon_cb.pready;
    xtn.irq = apb_vif.apb_mon_cb.irq;

    if(xtn.pwrite==1)
        xtn.pwdata = apb_vif.apb_mon_cb.pwdata;
    else
        xtn.prdata = apb_vif.apb_mon_cb.prdata;

    `uvm_info(get_type_name(),$sformatf("Data sampled from the APB Monitor\n:%s",xtn.sprint()),UVM_NONE)

    ap.write(xtn);
        
endtask:collect_data

endclass:apb_monitor
