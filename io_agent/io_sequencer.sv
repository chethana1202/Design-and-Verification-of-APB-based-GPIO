class io_sequencer extends uvm_sequencer #(io_trans);

`uvm_component_utils(io_sequencer)

function new(string name="io_sequencer",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

endclass:io_sequencer
