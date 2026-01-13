class base_test extends uvm_test;

env_config cfg;
environment envh;
vseq_base vseq_base_h;

bit has_scoreboard=1;
bit has_virtual_sequencer=1;
reg_map reg_block_h;

`uvm_component_utils(base_test)

function new(string name="base_test",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    cfg=env_config::type_id::create("cfg");
    
    if(!uvm_config_db #(virtual interface_apb)::get(this,"","apb_vif",cfg.apb_vif))
    `uvm_fatal("apb_vif config","cannot get() the interface apb_vif from env_config")

    if(!uvm_config_db #(virtual interface_aux)::get(this,"","aux_vif",cfg.aux_vif))
    `uvm_fatal("aux_vif config","cannot get() the interface aux_vif from env_config")

    if(!uvm_config_db #(virtual interface_io)::get(this,"","io_vif",cfg.io_vif))
    `uvm_fatal("io_if config","cannot get() the interface io_if from env_config")

    cfg.is_active = UVM_ACTIVE;
    cfg.has_scoreboard = has_scoreboard;
    cfg.has_virtual_sequencer = has_virtual_sequencer;

    uvm_config_db #(env_config)::set(this,"*","env_config",cfg);

    envh=environment::type_id::create("envh",this);
    reg_block_h=reg_map::type_id::create("reg_block_h",this);
    reg_block_h.build();
    cfg.reg_block_h=reg_block_h;

endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
   uvm_top.print_topology();
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    vseq_base_h=vseq_base::type_id::create("vseq_base_h");

    phase.raise_objection(this);
    vseq_base_h.start(envh.vseqrh);
    #10;
    phase.drop_objection(this);
endtask:run_phase

endclass:base_test

///////////////////////////////////////////////////////////////////////////////GPIO AS OUTPUT WITHOUT AUX/////////////////////////////////////////////////////////////////////////////////////////////////////

class test1 extends base_test;

vseq1 vseq1h;

`uvm_component_utils(test1)

function new(string name="test1",uvm_component parent=null);
	super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
	vseq1h=vseq1::type_id::create("vseq1h");

	phase.raise_objection(this);
	vseq1h.start(envh.vseqrh);
	#10;
	phase.drop_objection(this);
endtask:run_phase

endclass:test1	

//////////////////////////////////////////////////////////////////////////////////GPIO AS OUTPUT WITH AUX/////////////////////////////////////////////////////////////////////////////////////////////////////

class test2 extends base_test;

vseq2 vseq2h;

`uvm_component_utils(test2)

function new(string name="test2",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    vseq2h=vseq2::type_id::create("vseq2h");
    
    phase.raise_objection(this);
    vseq2h.start(envh.vseqrh);
    #10;
    phase.drop_objection(this);
endtask:run_phase

endclass:test2

/////////////////////////////////////////////////////////////////////////////////GPIO AS INPUT WITH SYSCLK////////////////////////////////////////////////////////////////////////////////////////////////////////

class test3 extends base_test;

vseq3 vseq3h;
read_sequence rd_seqh;

`uvm_component_utils(test3)

function new(string name="test3",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    vseq3h=vseq3::type_id::create("vseq3h");

    phase.raise_objection(this);
    vseq3h.start(envh.vseqrh);
    #20;
    phase.drop_objection(this);
endtask:run_phase

endclass:test3

/////////////////////////////////////////////////////////////////////////////GPIO AS INPUT WITH EXTCLK - posedge triggered////////////////////////////////////////////////////////////////////////////////////////////////////////

class test4 extends base_test;

vseq4 vseq4h;

`uvm_component_utils(test4)

function new(string name="test4",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    vseq4h=vseq4::type_id::create("vseq4h");

    phase.raise_objection(this);
    vseq4h.start(envh.vseqrh);
    #20;
    phase.drop_objection(this);
endtask:run_phase

endclass:test4

//////////////////////////////////////////////////////////////////////////////GPIO AS INPUT WITH EXTCLK - negedge triggered///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class test5 extends base_test;

vseq5 vseq5h;

`uvm_component_utils(test5)

function new(string name="test5",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    vseq5h=vseq5::type_id::create("vseq5h");

    phase.raise_objection(this);
    vseq5h.start(envh.vseqrh);
    #20;
    phase.drop_objection(this);
endtask:run_phase

endclass:test5

////////////////////////////////////////////////////////////////////////GPIO AS INPUT IN INTERRUPT MODE - posedge triggered interrupts(sysclk)//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class test6 extends base_test;

vseq6 vseq6h;

`uvm_component_utils(test6)

function new(string name="test5",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    vseq6h=vseq6::type_id::create("vseq6h");

    phase.raise_objection(this);
    vseq6h.start(envh.vseqrh);
    #20;
    phase.drop_objection(this);
endtask:run_phase

endclass:test6

////////////////////////////////////////////////////////////////////////GPIO AS INPUT IN INTERRUPT MODE - negedge triggered interrupts(sysclk)/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class test7 extends base_test;

vseq7 vseq7h;

`uvm_component_utils(test7)

function new(string name="test7",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    vseq7h=vseq7::type_id::create("vseq7h");

    phase.raise_objection(this);
    vseq7h.start(envh.vseqrh);
    #100;
    phase.drop_objection(this);
endtask:run_phase

endclass:test7

//////////////////////////////////////////////////////////////////////GPIO AS INPUT IN INTERRUPT MODE - posedge triggered interrupts(ext clk - input at posedge)///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class test8 extends base_test;

vseq8 vseq8h;

`uvm_component_utils(test8)

function new(string name="test8",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    vseq8h=vseq8::type_id::create("vseq8h");

    phase.raise_objection(this);
    vseq8h.start(envh.vseqrh);
    #20;
    phase.drop_objection(this);
endtask:run_phase

endclass:test8

//////////////////////////////////////////////////////////////////GPIO AS INPUT IN INTERRUPT MODE - posedge triggered interrupts(ext clk - input at negedge)////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class test9 extends base_test;

vseq9 vseq9h;

`uvm_component_utils(test9)

function new(string name="test9",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    vseq9h=vseq9::type_id::create("vseq9h");

    phase.raise_objection(this);
    vseq9h.start(envh.vseqrh);
    #20;
    phase.drop_objection(this);
endtask:run_phase

endclass:test9

///////////////////////////////////////////////////////////////////////////////////GPIO AS BIDIRECTIONAL I/O//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class test10 extends base_test;

vseq10 vseq10h;

`uvm_component_utils(test10)

function new(string name="test10",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    vseq10h=vseq10::type_id::create("vseq10h");

    phase.raise_objection(this);
    vseq10h.start(envh.vseqrh);
    #100;
    phase.drop_objection(this);
endtask:run_phase

endclass:test10

//////////////////////////////////////////////////////////////////////////////GPIO AS BIDIRECTIONAL IO WITH INTERRUPTS////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class test11 extends base_test;

vseq11 vseq11h;

`uvm_component_utils(test11)

function new(string name="test11",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    vseq11h=vseq11::type_id::create("vseq11h");

    phase.raise_objection(this);
    vseq11h.start(envh.vseqrh);
    #100;
    phase.drop_objection(this);
endtask:run_phase

endclass:test11

///////////////////////////////////////////////////////////////GPIO AS INPUT IN INTERRUPT MODE - negedge triggered interrupts(ext clk - input at posedge)//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class test12 extends base_test;

vseq12 vseq12h;

`uvm_component_utils(test12)

function new(string name="test12",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    vseq12h=vseq12::type_id::create("vseq12h");

    phase.raise_objection(this);
    vseq12h.start(envh.vseqrh);
    #100;
    phase.drop_objection(this);
endtask:run_phase

endclass:test12

/////////////////////////////////////////////////////////////GPIO AS INPUT IN INTERRUPT MODE - negedge triggered interrupts(ext clk - input at negedge)////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class test13 extends base_test;

vseq13 vseq13h;

`uvm_component_utils(test13)

function new(string name="test13",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    vseq13h=vseq13::type_id::create("vseq13h");

    phase.raise_objection(this);
    vseq13h.start(envh.vseqrh);
    #100;
    phase.drop_objection(this);
endtask:run_phase

endclass:test13
