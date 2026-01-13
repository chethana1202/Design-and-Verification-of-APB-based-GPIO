class vseq_base extends uvm_sequence #(uvm_sequence_item);

virtual_sequencer vseqrh;
apb_sequencer apb_seqrh;
aux_sequencer aux_seqrh;
io_sequencer io_seqrh;

`uvm_object_utils(vseq_base)

function new(string name="vseq_base");
    super.new(name);
endfunction:new

task body();
    if(!$cast(vseqrh,m_sequencer))
    begin
        `uvm_error(get_full_name(),"virtual sequencer pointer cast failed");
    end

    apb_seqrh=vseqrh.apb_seqrh;
    aux_seqrh=vseqrh.aux_seqrh;
    io_seqrh=vseqrh.io_seqrh;

endtask:body

endclass:vseq_base

///////////////////////////////////////////////////////////////GPIO AS OUTPUT WITHOUT AUX//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class vseq1 extends vseq_base;

apb_output_sequence apb_seqh;
aux_output_sequence aux_seqh;
io_output_sequence io_seqh;

`uvm_object_utils(vseq1)

function new(string name="vseq1");
    super.new(name);
endfunction:new

task body();
    super.body();
    
    apb_seqh=apb_output_sequence::type_id::create("apb_seqh");
    aux_seqh=aux_output_sequence::type_id::create("aux_seqh");
    io_seqh=io_output_sequence::type_id::create("io_seqh");

    begin
        //repeat(2)
        io_seqh.start(io_seqrh);
        fork
            apb_seqh.start(apb_seqrh);
            aux_seqh.start(aux_seqrh);
        join
    end
endtask:body

endclass:vseq1

/////////////////////////////////////////////////////////////GPIO AS OUTPUT WITH AUX//////////////////////////////////////////////////////////////////////////////////////////////

class vseq2 extends vseq_base;

apb_aux_output_sequence apb_aux_seqh;
aux_output_sequence aux_seqh;
io_output_sequence io_seqh;

`uvm_object_utils(vseq2)

function new(string name="vseq2");
    super.new(name);
endfunction:new

task body();
    super.body();

    apb_aux_seqh=apb_aux_output_sequence::type_id::create("apb_aux_seqh");
    aux_seqh=aux_output_sequence::type_id::create("aux_seqh");
    io_seqh=io_output_sequence::type_id::create("io_seqh");

    begin
        io_seqh.start(io_seqrh);
        fork
            apb_aux_seqh.start(apb_seqrh);
            aux_seqh.start(aux_seqrh);
        join
    end
endtask:body

endclass:vseq2

/////////////////////////////////////////////////////////GPIO AS INPUT WITH SYSCLK///////////////////////////////////////////////////////////////////////////////////////////////////

class vseq3 extends vseq_base;

apb_input_sequence1 apb_ip_seq1h;
io_input_sequence io_ip_seqh;
io_reset_sequence io_rst_seqh;
read_sequence rd_seqh;

`uvm_object_utils(vseq3)

function new(string name="vseq3");
    super.new(name);
endfunction:new

task body();
    super.body();
    
    apb_ip_seq1h=apb_input_sequence1::type_id::create("apb_ip_seq1h");
    io_ip_seqh=io_input_sequence::type_id::create("io_ip_seqh");
    rd_seqh=read_sequence::type_id::create("rd_seqh");
    io_rst_seqh=io_reset_sequence::type_id::create("io_rst_seqh");
        
    begin
        io_rst_seqh.start(io_seqrh);
        apb_ip_seq1h.start(apb_seqrh);
        io_ip_seqh.start(io_seqrh);
        rd_seqh.start(apb_seqrh);
    end

endtask:body

endclass:vseq3

//////////////////////////////////////////////////////////GPIO AS INPUT WITH EXTCLK - posedge triggered//////////////////////////////////////////////////////////////////////////////////////////////////

class vseq4 extends vseq_base;

apb_input_sequence2 apb_ip_seq2h;
io_input_sequence io_ip_seqh;
read_sequence rd_seqh;
io_reset_sequence io_rst_seqh;

`uvm_object_utils(vseq4)

function new(string name="vseq4");
    super.new(name);
endfunction:new

task body();
    super.body();

    apb_ip_seq2h=apb_input_sequence2::type_id::create("apb_ip_seq2h");
    io_ip_seqh=io_input_sequence::type_id::create("io_ip_seqh");
    rd_seqh=read_sequence::type_id::create("rd_seqh");
    io_rst_seqh=io_reset_sequence::type_id::create("io_rst_seqh");

    begin
        io_rst_seqh.start(io_seqrh);
        apb_ip_seq2h.start(apb_seqrh);
        io_ip_seqh.start(io_seqrh);
        rd_seqh.start(apb_seqrh);
    end

endtask:body

endclass:vseq4

////////////////////////////////////////////////////////////GPIO AS INPUT WITH EXTCLK - negedge triggered//////////////////////////////////////////////////////////////////////////////////////////////////////////

class vseq5 extends vseq_base;

apb_input_sequence3 apb_ip_seq3h;
io_input_sequence io_ip_seqh;
read_sequence rd_seqh;
io_reset_sequence io_rst_seqh;

`uvm_object_utils(vseq5)

function new(string name="vseq5");
    super.new(name);
endfunction:new

task body();
    super.body();

    apb_ip_seq3h=apb_input_sequence3::type_id::create("apb_ip_seq3h");
    io_ip_seqh=io_input_sequence::type_id::create("io_ip_seqh");
    rd_seqh=read_sequence::type_id::create("rd_seqh");
    io_rst_seqh=io_reset_sequence::type_id::create("io_rst_seqh");

    begin
        io_rst_seqh.start(io_seqrh);
        apb_ip_seq3h.start(apb_seqrh);
        io_ip_seqh.start(io_seqrh);
        rd_seqh.start(apb_seqrh);
    end

endtask:body

endclass:vseq5

////////////////////////////////////////////////////////////GPIO AS INPUT IN INTERRUPT MODE - posedge triggered interrupts(sysclk)//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class vseq6 extends vseq_base;

apb_interrupt_sequence1 apb_intr_seq1h;
io_interrupt_sequence1 io_intr_seq1h;
io_interrupt_sequence2 io_intr_seq2h;
reset_interrupt_sequence rst_intr_seqh;

`uvm_object_utils(vseq6)

function new(string name="vseq6");
    super.new(name);
endfunction:new

task body();
    super.body();

    apb_intr_seq1h=apb_interrupt_sequence1::type_id::create("apb_intr_seq1h");
    io_intr_seq1h=io_interrupt_sequence1::type_id::create("io_intr_seq1h");
    io_intr_seq2h=io_interrupt_sequence2::type_id::create("io_intr_seq2h");
    rst_intr_seqh=reset_interrupt_sequence::type_id::create("rst_intr_seqh");

    begin
        io_intr_seq1h.start(io_seqrh);
        apb_intr_seq1h.start(apb_seqrh);
        io_intr_seq2h.start(io_seqrh);
        rst_intr_seqh.start(apb_seqrh);
    end

endtask:body

endclass:vseq6

////////////////////////////////////////////////////////GPIO AS INPUT IN INTERRUPT MODE - negedge triggered interrupts(sysclk)////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
class vseq7 extends vseq_base;

apb_interrupt_sequence2 apb_intr_seq2h;
io_interrupt_sequence1 io_intr_seq1h;
io_interrupt_sequence2 io_intr_seq2h;
reset_interrupt_sequence rst_intr_seqh;

`uvm_object_utils(vseq7)

function new(string name="vseq7");
    super.new(name);
endfunction:new

task body();
    super.body();

    apb_intr_seq2h=apb_interrupt_sequence2::type_id::create("apb_intr_seq2h");
    io_intr_seq1h=io_interrupt_sequence1::type_id::create("io_intr_seq1h");
    io_intr_seq2h=io_interrupt_sequence2::type_id::create("io_intr_seq2h");
    rst_intr_seqh=reset_interrupt_sequence::type_id::create("rst_intr_seqh");

    begin
        io_intr_seq2h.start(io_seqrh);
        apb_intr_seq2h.start(apb_seqrh);
        io_intr_seq1h.start(io_seqrh);
        rst_intr_seqh.start(apb_seqrh);
    end

endtask:body

endclass:vseq7

/////////////////////////////////////////////////////////GPIO AS INPUT IN INTERRUPT MODE - posedge triggered interrupts(ext clk - input at posedge)///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
class vseq8 extends vseq_base;

apb_interrupt_sequence3 apb_intr_seq3h;
io_interrupt_sequence1 io_intr_seq1h;
io_interrupt_sequence2 io_intr_seq2h;
reset_interrupt_sequence rst_intr_seqh;

`uvm_object_utils(vseq8)

function new(string name="vseq8");
    super.new(name);
endfunction:new

task body();
    super.body();

    apb_intr_seq3h=apb_interrupt_sequence3::type_id::create("apb_intr_seq3h");
    io_intr_seq1h=io_interrupt_sequence1::type_id::create("io_intr_seq1h");
    io_intr_seq2h=io_interrupt_sequence2::type_id::create("io_intr_seq2h");
    rst_intr_seqh=reset_interrupt_sequence::type_id::create("rst_intr_seqh");

    begin
        io_intr_seq1h.start(io_seqrh);
        apb_intr_seq3h.start(apb_seqrh);
        io_intr_seq2h.start(io_seqrh);
        rst_intr_seqh.start(apb_seqrh);
    end

endtask:body

endclass:vseq8

///////////////////////////////////////////////////////////////GPIO AS INPUT IN INTERRUPT MODE - posedge triggered interrupts(ext clk - input at nedgedge)/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
class vseq9 extends vseq_base;

apb_interrupt_sequence4 apb_intr_seq4h;
io_interrupt_sequence1 io_intr_seq1h;
io_interrupt_sequence2 io_intr_seq2h;
reset_interrupt_sequence rst_intr_seqh;

`uvm_object_utils(vseq9)

function new(string name="vseq9");
    super.new(name);
endfunction:new

task body();
    super.body();

    apb_intr_seq4h=apb_interrupt_sequence4::type_id::create("apb_intr_seq4h");
    io_intr_seq1h=io_interrupt_sequence1::type_id::create("io_intr_seq1h");
    io_intr_seq2h=io_interrupt_sequence2::type_id::create("io_intr_seq2h");
    rst_intr_seqh=reset_interrupt_sequence::type_id::create("rst_intr_seqh");

    begin
        io_intr_seq1h.start(io_seqrh);
        apb_intr_seq4h.start(apb_seqrh);
        io_intr_seq2h.start(io_seqrh);
        rst_intr_seqh.start(apb_seqrh);
    end

endtask:body

endclass:vseq9

////////////////////////////////////////////////////////////////// GPIO AS BIDIRECTIONAL I/O //////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class vseq10 extends vseq_base;

apb_bidir_sequence1 apb_bidir_seq1h;
io_bidir_sequence1 io_bidir_seq1h;
io_reset_sequence io_rst_seqh;
read_sequence rd_seqh;

`uvm_object_utils(vseq10)

function new(string name="vseq10");
    super.new(name);
endfunction:new

task body();
    super.body();

    apb_bidir_seq1h=apb_bidir_sequence1::type_id::create("apb_bidir_seq1h");
    io_bidir_seq1h=io_bidir_sequence1::type_id::create("io_bidir_seq1h");
    rd_seqh=read_sequence::type_id::create("rd_seqh");
    io_rst_seqh=io_reset_sequence::type_id::create("io_rst_seqh");

/*    fork
        io_rst_seqh.start(io_seqrh);
        io_bidir_seq1h.start(io_seqrh);
        apb_bidir_seq1h.start(apb_seqrh);
    join

    begin
        apb_bidir_seq1h.start(apb_seqrh);
        io_bidir_seq1h.start(io_seqrh);
    end*/
    
    begin
        io_rst_seqh.start(io_seqrh);
        io_bidir_seq1h.start(io_seqrh);
        apb_bidir_seq1h.start(apb_seqrh);
        apb_bidir_seq1h.start(apb_seqrh);
        io_bidir_seq1h.start(io_seqrh);
    end
        

endtask:body

endclass:vseq10

////////////////////////////////////////////////////////////////// GPIO AS BIDIRECTIONAL I/O WITH INTERRUPTS//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class vseq11 extends vseq_base;

apb_bidir_intr_sequence1 apb_bidir_intr_seq1h;
apb_bidir_intr_sequence2 apb_bidir_intr_seq2h;
io_interrupt_sequence1 io_intr_seq1h;
io_output_sequence io_out_seqh;
io_bidir_intr_sequence io_bidir_intr_seqh;
reset_interrupt_sequence rst_intr_seqh;

`uvm_object_utils(vseq11)

function new(string name="vseq11");
    super.new(name);
endfunction:new

task body();
    super.body();

    apb_bidir_intr_seq1h=apb_bidir_intr_sequence1::type_id::create("apb_bidir_intr_seq1h");
    apb_bidir_intr_seq2h=apb_bidir_intr_sequence2::type_id::create("apb_bidir_intr_seq2h");
    io_intr_seq1h=io_interrupt_sequence1::type_id::create("io_intr_seq1h");
    io_bidir_intr_seqh=io_bidir_intr_sequence::type_id::create("io_bidir_intr_seqh");
    io_out_seqh=io_output_sequence::type_id::create("io_out_seqh");
    rst_intr_seqh=reset_interrupt_sequence::type_id::create("rst_intr_seqh");

    begin
        io_out_seqh.start(io_seqrh);
        apb_bidir_intr_seq1h.start(apb_seqrh);
        io_bidir_intr_seqh.start(io_seqrh);
        #50;
        io_intr_seq1h.start(io_seqrh);
        apb_bidir_intr_seq2h.start(apb_seqrh);
        io_bidir_intr_seqh.start(io_seqrh);
        rst_intr_seqh.start(apb_seqrh);
    end

endtask:body

endclass:vseq11

///////////////////////////////////////////////////////////////GPIO AS INPUT IN INTERRUPT MODE - negedge triggered interrupts(ext clk - input at posedge)/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
class vseq12 extends vseq_base;

apb_interrupt_sequence5 apb_intr_seq5h;
io_interrupt_sequence1 io_intr_seq1h;
io_interrupt_sequence2 io_intr_seq2h;
reset_interrupt_sequence rst_intr_seqh;

`uvm_object_utils(vseq12)

function new(string name="vseq12");
    super.new(name);
endfunction:new

task body();
    super.body();

    apb_intr_seq5h=apb_interrupt_sequence5::type_id::create("apb_intr_seq5h");
    io_intr_seq1h=io_interrupt_sequence1::type_id::create("io_intr_seq1h");
    io_intr_seq2h=io_interrupt_sequence2::type_id::create("io_intr_seq2h");
    rst_intr_seqh=reset_interrupt_sequence::type_id::create("rst_intr_seqh");

    begin
        io_intr_seq2h.start(io_seqrh);
        apb_intr_seq5h.start(apb_seqrh);
        io_intr_seq1h.start(io_seqrh);
        rst_intr_seqh.start(apb_seqrh);
    end

endtask:body

endclass:vseq12

///////////////////////////////////////////////////////////////GPIO AS INPUT IN INTERRUPT MODE - negedge triggered interrupts(ext clk - input at negedge)/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
class vseq13 extends vseq_base;

apb_interrupt_sequence6 apb_intr_seq6h;
io_interrupt_sequence1 io_intr_seq1h;
io_interrupt_sequence2 io_intr_seq2h;
reset_interrupt_sequence rst_intr_seqh;

`uvm_object_utils(vseq13)

function new(string name="vseq13");
    super.new(name);
endfunction:new

task body();
    super.body();

    apb_intr_seq6h=apb_interrupt_sequence6::type_id::create("apb_intr_seq6h");
    io_intr_seq1h=io_interrupt_sequence1::type_id::create("io_intr_seq1h");
    io_intr_seq2h=io_interrupt_sequence2::type_id::create("io_intr_seq2h");
    rst_intr_seqh=reset_interrupt_sequence::type_id::create("rst_intr_seqh");

    begin
        io_intr_seq2h.start(io_seqrh);
        apb_intr_seq6h.start(apb_seqrh);
        io_intr_seq1h.start(io_seqrh);
        rst_intr_seqh.start(apb_seqrh);
    end

endtask:body

endclass:vseq13

