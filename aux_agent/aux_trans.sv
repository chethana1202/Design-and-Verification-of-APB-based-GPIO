class aux_trans extends uvm_sequence_item;

rand bit [31:0] aux_in;

`uvm_object_utils(aux_trans)

function new(string name="aux_trans");
    super.new(name);
endfunction:new

function void do_print(uvm_printer printer); 
    printer.print_field("aux_in",this.aux_in,32,UVM_HEX);
endfunction:do_print

endclass:aux_trans
