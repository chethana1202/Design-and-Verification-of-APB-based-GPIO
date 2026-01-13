class io_trans extends uvm_sequence_item;

rand logic [31:0] io_pad;
rand bit [1:0] io_flag;

`uvm_object_utils(io_trans)

function new(string name="io_trans");
    super.new(name);
endfunction:new

function void post_randomize();
    case(io_flag)
        2'b00:io_pad=io_pad;    // io_pad as input
        2'b01:io_pad=32'hz;     // io_pad as output
	    2'b10:io_pad=32'h7654_zzzz; // bidirectional io
        2'b11:io_pad=32'hzzzz_12ff; // bidirectional io with interrupts
    endcase
endfunction:post_randomize

function void do_print(uvm_printer printer);
    printer.print_field("io_pad",this.io_pad,32,UVM_HEX);
endfunction:do_print

endclass:io_trans
