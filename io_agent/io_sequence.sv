class io_sequence_base extends uvm_sequence #(io_trans);

`uvm_object_utils(io_sequence_base)

function new(string name="io_sequence_base");
    super.new(name);
endfunction:new

endclass:io_sequence_base

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class io_output_sequence extends io_sequence_base;

`uvm_object_utils(io_output_sequence)

function new(string name="io_output_sequence");
    super.new(name);
endfunction:new

task body();
begin
    req=io_trans::type_id::create("req");

    start_item(req);
    assert(req.randomize() with {io_flag == 2'b01;});
    finish_item(req);
end
endtask:body

endclass:io_output_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class io_input_sequence extends io_sequence_base;

`uvm_object_utils(io_input_sequence)

function new(string name="io_input_sequence");
    super.new(name);
endfunction:new

task body();
begin
    req=io_trans::type_id::create("req");

    start_item(req);
    assert(req.randomize() with {io_flag == 2'b00;});
    finish_item(req);
end
endtask:body

endclass:io_input_sequence

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class io_interrupt_sequence1 extends io_sequence_base;

`uvm_object_utils(io_interrupt_sequence1)

function new(string name="io_interrupt_sequence1");
    super.new(name);
endfunction:new

task body();
begin
    req=io_trans::type_id::create("req");

    start_item(req);
    assert(req.randomize() with {io_flag == 2'b00;
                                 io_pad == 32'h0000_0000;});
    finish_item(req);

end
endtask:body

endclass:io_interrupt_sequence1

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class io_interrupt_sequence2 extends io_sequence_base;

`uvm_object_utils(io_interrupt_sequence2)

function new(string name="io_interrupt_sequence2");
    super.new(name);
endfunction:new

task body();
begin
    req=io_trans::type_id::create("req");

    start_item(req);
    assert(req.randomize() with {io_flag == 2'b00;
                                 io_pad == 32'h0000_ffff;});
    finish_item(req);
end
endtask:body

endclass:io_interrupt_sequence2

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class io_bidir_sequence1 extends io_sequence_base;

`uvm_object_utils(io_bidir_sequence1)

function new(string name="io_bidir_sequence1");
    super.new(name);
endfunction:new

task body();
begin
    req=io_trans::type_id::create("req");

    start_item(req);
    assert(req.randomize() with {io_flag == 2'b10;});
    finish_item(req);

end
endtask:body

endclass:io_bidir_sequence1

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class io_bidir_intr_sequence extends io_sequence_base;

`uvm_object_utils(io_bidir_intr_sequence)

function new(string name="io_bidir_intr_sequence");
    super.new(name);
endfunction:new

task body();
begin
    req=io_trans::type_id::create("req");

    start_item(req);
    assert(req.randomize() with {io_flag == 2'b11;});
    finish_item(req);

end
endtask:body

endclass:io_bidir_intr_sequence

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class io_reset_sequence extends io_sequence_base;

`uvm_object_utils(io_reset_sequence)

function new(string name="io_reset_sequence");
    super.new(name);
endfunction:new

task body();
begin
    req=io_trans::type_id::create("req");

    start_item(req);
    assert(req.randomize() with {io_flag == 2'b00;
                                 io_pad == 32'h0000_0000;});
    finish_item(req);

end
endtask:body

endclass:io_reset_sequence

