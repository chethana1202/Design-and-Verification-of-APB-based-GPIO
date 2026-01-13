class aux_sequencer extends uvm_sequencer #(aux_trans);

`uvm_component_utils(aux_sequencer)

function new(string name="aux_sequencer",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

endclass:aux_sequencer
