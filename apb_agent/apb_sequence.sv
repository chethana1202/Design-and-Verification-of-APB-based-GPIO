`include "definitions.v"

class apb_sequence_base extends uvm_sequence #(apb_trans);

`uvm_object_utils(apb_sequence_base)

function new(string name="apb_sequence_base");
    super.new(name);
endfunction:new

endclass:apb_sequence_base

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_output_sequence extends apb_sequence_base;

`uvm_object_utils(apb_output_sequence)

function new(string name="apb_output_sequence");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_OE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OE;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_AUX Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_AUX;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_OUT Register - Write
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OUT;
                                 pwdata == 32'habcd_abcd;});
    finish_item(req);

    // Configuration of RGPIO_OUT Register - Read
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b0;
                                 paddr == `GPIO_RGPIO_OUT;});
    finish_item(req);
end
endtask:body

endclass:apb_output_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_aux_output_sequence extends apb_sequence_base;

`uvm_object_utils(apb_aux_output_sequence)

function new(string name="apb_aux_output_sequence");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_OE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OE;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_AUX Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_AUX;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_OUT Register - Write
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OUT;
                                 pwdata == 32'hdefd_fedf;});

    finish_item(req);

end
endtask:body

endclass:apb_aux_output_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_input_sequence1 extends apb_sequence_base;

`uvm_object_utils(apb_input_sequence1)

function new(string name="apb_input_sequence1");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_OE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OE;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_CTRL Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_CTRL;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_INTE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTE;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);
    
    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

end
endtask:body

endclass:apb_input_sequence1

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class read_sequence extends apb_sequence_base;

`uvm_object_utils(read_sequence)

function new(string name="read_sequence");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // To read the RGPIO_IN Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b0;
                                 paddr == `GPIO_RGPIO_IN;});
    finish_item(req);
end
endtask:body

endclass:read_sequence

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_input_sequence2 extends apb_sequence_base;

`uvm_object_utils(apb_input_sequence2)

function new(string name="apb_input_sequence2");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_NEC Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_NEC;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);
	
    // Configuration of RGPIO_OE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OE;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_CTRL Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_CTRL;
                                 pwdata ==  32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_INTE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTE;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_NEC Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_NEC;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

end
endtask:body

endclass:apb_input_sequence2

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_input_sequence3 extends apb_sequence_base;

`uvm_object_utils(apb_input_sequence3)

function new(string name="apb_input_sequence3");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_NEC Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_NEC;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_OE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OE;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_CTRL Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_CTRL;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_INTE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTE;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_NEC Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_NEC;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);
end
endtask:body

endclass:apb_input_sequence3

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_interrupt_sequence1 extends apb_sequence_base;

`uvm_object_utils(apb_interrupt_sequence1)

function new(string name="apb_interrput_sequence1");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_OE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OE;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_PTRIG Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_PTRIG;
                                 pwdata == 32'h0000_ffff;});
    finish_item(req);

    // Configuration of RGPIO_INTS Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTS;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);
  
    // Configuration of RGPIO_CTRL Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_CTRL;
                                 pwdata == 32'h0000_0001;});
    finish_item(req);

    // Configuration of RGPIO_INTE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTE;
                                 pwdata == 32'h0000_ffff;});
    finish_item(req);

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

end
endtask:body

endclass:apb_interrupt_sequence1

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class reset_interrupt_sequence extends apb_sequence_base;

`uvm_object_utils(reset_interrupt_sequence)

function new(string name="reset_interrupt_sequence");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Clear Interrupts - deasserting INTE bit of RGPIO_CTRL
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
				                paddr == `GPIO_RGPIO_CTRL;
				                pwdata == 32'b10;});
    finish_item(req);
    
/*    // Clear Interrupts - deasserting INTS bit of RGPIO_CTRL
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
				                paddr == `GPIO_RGPIO_CTRL;
				                pwdata == 32'b01;});
    finish_item(req);

    // Clear Interrupts - clearing RGPIO_INTS Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
			                    paddr == `GPIO_RGPIO_INTS;
				                pwdata == 32'h0000_0000;});
    finish_item(req);*/
end
endtask:body

endclass:reset_interrupt_sequence

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_interrupt_sequence2 extends apb_sequence_base;

`uvm_object_utils(apb_interrupt_sequence2)

function new(string name="apb_interrput_sequence2");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_OE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OE;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_PTRIG Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_PTRIG;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_INTS Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTS;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);
  
    // Configuration of RGPIO_CTRL Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_CTRL;
                                 pwdata == 32'h0000_0001;});
    finish_item(req);

    // Configuration of RGPIO_INTE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTE;
                                 pwdata == 32'h0000_ffff;});
    finish_item(req);

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

end
endtask:body

endclass:apb_interrupt_sequence2

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_interrupt_sequence3 extends apb_sequence_base;

`uvm_object_utils(apb_interrupt_sequence3)

function new(string name="apb_interrput_sequence3");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_OE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OE;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_PTRIG Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_PTRIG;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_INTS Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTS;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);
  
    // Configuration of RGPIO_CTRL Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_CTRL;
                                 pwdata == 32'h0000_0001;});
    finish_item(req);

    // Configuration of RGPIO_INTE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTE;
                                 pwdata == 32'h0000_00ff;});
    finish_item(req);

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_NEC Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_NEC;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

end
endtask:body

endclass:apb_interrupt_sequence3

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_interrupt_sequence4 extends apb_sequence_base;

`uvm_object_utils(apb_interrupt_sequence4)

function new(string name="apb_interrput_sequence4");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_OE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OE;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_PTRIG Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_PTRIG;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_INTS Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTS;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);
  
    // Configuration of RGPIO_CTRL Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_CTRL;
                                 pwdata == 32'h0000_0001;});
    finish_item(req);

    // Configuration of RGPIO_INTE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTE;
                                 pwdata == 32'h0000_00ff;});
    finish_item(req);

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_NEC Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_NEC;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

end
endtask:body

endclass:apb_interrupt_sequence4

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_bidir_sequence1 extends apb_sequence_base;

`uvm_object_utils(apb_bidir_sequence1)

function new(string name="apb_bidir_sequence1");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_OE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OE;
                                 pwdata == 32'h0000_ffff;});
    finish_item(req);
    
    // Configuration of RGPIO_AUX Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_AUX;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_OUT Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OUT;
                                 pwdata == 32'h0000_deed;});
    finish_item(req);

    // Configuration of RGPIO_CTRL Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_CTRL;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_INTE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTE;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_OE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OE;
                                 pwdata == 32'h0000_ffff;});
    finish_item(req);
    
end
endtask:body

endclass:apb_bidir_sequence1

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_bidir_intr_sequence1 extends apb_sequence_base;

`uvm_object_utils(apb_bidir_intr_sequence1)

function new(string name="apb_bidir_intr_sequence1");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_OE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OE;
                                 pwdata == 32'hffff_0000;});
    finish_item(req);
    
    // Configuration of RGPIO_AUX Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_AUX;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_OUT Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OUT;
                                 pwdata == 32'hcafd_0000;});
    finish_item(req);

    // Configuration of RGPIO_CTRL Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_CTRL;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_INTE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTE;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);
end
endtask:body

endclass:apb_bidir_intr_sequence1

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_bidir_intr_sequence2 extends apb_sequence_base;

`uvm_object_utils(apb_bidir_intr_sequence2)

function new(string name="apb_bidir_intr_sequence2");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_PTRIG Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_PTRIG;
                                 pwdata == 32'h0000_000f;});
    finish_item(req);

    // Configuration of RGPIO_INTS Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTS;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_CTRL Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_CTRL;
                                 pwdata == 32'h0000_0001;});
    finish_item(req);

    // Configuration of RGPIO_INTE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTE;
                                 pwdata == 32'h0000_000f;});
    finish_item(req);

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);
end
endtask:body

endclass:apb_bidir_intr_sequence2

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_interrupt_sequence5 extends apb_sequence_base;

`uvm_object_utils(apb_interrupt_sequence5)

function new(string name="apb_interrput_sequence5");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_NEC Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_NEC;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_OE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OE;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_PTRIG Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_PTRIG;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_INTS Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTS;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);
  
    // Configuration of RGPIO_CTRL Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_CTRL;
                                 pwdata == 32'h0000_0001;});
    finish_item(req);

    // Configuration of RGPIO_INTE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTE;
                                 pwdata == 32'h0000_00ff;});
    finish_item(req);

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_NEC Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_NEC;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

end
endtask:body

endclass:apb_interrupt_sequence5

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_interrupt_sequence6 extends apb_sequence_base;

`uvm_object_utils(apb_interrupt_sequence6)

function new(string name="apb_interrput_sequence6");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_NEC Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_NEC;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_OE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_OE;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_PTRIG Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_PTRIG;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);

    // Configuration of RGPIO_INTS Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTS;
                                 pwdata == 32'h0000_0000;});
    finish_item(req);
  
    // Configuration of RGPIO_CTRL Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_CTRL;
                                 pwdata == 32'h0000_0001;});
    finish_item(req);

    // Configuration of RGPIO_INTE Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_INTE;
                                 pwdata == 32'h0000_00ff;});
    finish_item(req);

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

    // Configuration of RGPIO_NEC Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_NEC;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);

end
endtask:body

endclass:apb_interrupt_sequence6

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class eclk_sequence extends apb_sequence_base;

`uvm_object_utils(eclk_sequence)

function new(string name="eclk_sequence");
    super.new(name);
endfunction:new

task body();
begin
    req=apb_trans::type_id::create("req");

    // Configuration of RGPIO_ECLK Register
    start_item(req);
    assert(req.randomize() with {pwrite == 1'b1;
                                 paddr == `GPIO_RGPIO_ECLK;
                                 pwdata == 32'hffff_ffff;});
    finish_item(req);
end
endtask:body

endclass:eclk_sequence
