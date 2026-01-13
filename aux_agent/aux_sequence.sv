class aux_sequence_base extends uvm_sequence #(aux_trans);

`uvm_object_utils(aux_sequence_base)

function new(string name="aux_sequence_base");
    super.new(name);
endfunction:new

endclass:aux_sequence_base

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class aux_output_sequence extends aux_sequence_base;

`uvm_object_utils(aux_output_sequence)

function new(string name="aux_output_sequence");
    super.new(name);
endfunction:new

task body();
begin
    req=aux_trans::type_id::create("req");
    
    start_item(req);
    assert(req.randomize());
    finish_item(req);
end
endtask:body

endclass:aux_output_sequence 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
