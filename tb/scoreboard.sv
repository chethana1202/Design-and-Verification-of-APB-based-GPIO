`include "definitions.v"

class scoreboard extends uvm_scoreboard;

uvm_tlm_analysis_fifo #(apb_trans) fifoh_apb;
uvm_tlm_analysis_fifo #(aux_trans) fifoh_aux;
uvm_tlm_analysis_fifo #(io_trans) fifoh_io;

`uvm_component_utils(scoreboard)

apb_trans apb_xtn;
aux_trans aux_xtn;
io_trans io_xtn;

reg [31:0] rgpio_in;
reg [31:0] rgpio_out;
reg [31:0] rgpio_oe;
reg [31:0] rgpio_inte;
reg [31:0] rgpio_ptrig;
reg [31:0] rgpio_aux;
reg [1:0] rgpio_ctrl;
reg [31:0] rgpio_ints;
reg [31:0] rgpio_eclk;
reg [31:0] rgpio_nec;

int out_seq_pass;
int out_seq_err;
int aux_seq_pass;
int aux_seq_err;
int in_seq_sclk_pass;
int in_seq_sclk_err;
int in_seq_eclk_pos_pass;
int in_seq_eclk_pos_err;
int in_seq_eclk_neg_pass;
int in_seq_eclk_neg_err;
int intr_seq_ptrig_pass;
int intr_seq_ptrig_err;
int intr_seq_ntrig_pass;
int intr_seq_ntrig_err;
int intr_seq_eclk_ptrig_pass1;
int intr_seq_eclk_ptrig_err1;
int intr_seq_eclk_ptrig_pass2;
int intr_seq_eclk_ptrig_err2;
int intr_seq_eclk_ntrig_pass1;
int intr_seq_eclk_ntrig_err1;
int intr_seq_eclk_ntrig_pass2;
int intr_seq_eclk_ntrig_err2;
int bidir_io_out_pass;
int bidir_io_in_pass;
int bidir_io_out_err;
int bidir_io_in_err;

env_config cfg;

logic [31:0] prev_io_pad1 = 32'h0000_0000;
logic [31:0] prev_io_pad2 = 32'hffff_ffff;

// For reference model logic
logic [31:0] extc_in;
logic [31:0] in_mux;
logic [31:0] rgpio_ints_e;
logic [31:0] in_pad_i;

reg_map reg_block_h;
uvm_reg_data_t data1,data2,data3,data4,data5,data6,data7,data8,data9,data10; //64 bit by default
uvm_status_e status; // from RAL

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",cfg))
    `uvm_fatal(get_type_name(),"cannot get() the config cfg")
    
    fifoh_apb=new("fifoh_apb",this);
    fifoh_aux=new("fifoh_aux",this);
    fifoh_io=new("fifoh_io",this);

    reg_block_h=cfg.reg_block_h;
    
    super.build_phase(phase);
endfunction:build_phase


covergroup apb_cg;
    PRESETN: coverpoint apb_xtn.presetn{
              bins presetn_0 = {1'b0};
              bins presetn_1 = {1'b1};}
    
    PADDR:  coverpoint apb_xtn.paddr{
             bins addr_0 = {`GPIO_RGPIO_IN};
             bins addr_4 = {`GPIO_RGPIO_OUT};
             bins addr_8 = {`GPIO_RGPIO_OE};
             bins addr_c = {`GPIO_RGPIO_INTE};
             bins addr_10 = {`GPIO_RGPIO_PTRIG};
             bins addr_14 = {`GPIO_RGPIO_AUX};
             bins addr_18 = {`GPIO_RGPIO_CTRL};
             bins addr_1c = {`GPIO_RGPIO_INTS};
             bins addr_20 = {`GPIO_RGPIO_ECLK};
             bins addr_24 = {`GPIO_RGPIO_NEC};}

    PWRITE: coverpoint apb_xtn.pwrite{
             bins write = {1'b1};
             bins read = {1'b0};}

    WRITE_ONLY_ENABLE: coverpoint apb_xtn.pwrite{
                        bins write = {1'b1};}

    WRITE_ONLY_REG: coverpoint apb_xtn.paddr{
                      bins addr_4 = {`GPIO_RGPIO_OUT};
                      bins addr_8 = {`GPIO_RGPIO_OE};
                      bins addr_c = {`GPIO_RGPIO_INTE};
                      bins addr_10 = {`GPIO_RGPIO_PTRIG};
                      bins addr_14 = {`GPIO_RGPIO_AUX};
                      bins addr_18 = {`GPIO_RGPIO_CTRL};
                      bins addr_1c = {`GPIO_RGPIO_INTS};
                      bins addr_20 = {`GPIO_RGPIO_ECLK};
                      bins addr_24 = {`GPIO_RGPIO_NEC};}

    READ_ONLY_ENABLE: coverpoint apb_xtn.pwrite{
                       bins read = {1'b0};}

    READ_ONLY_REG: coverpoint apb_xtn.paddr{
                     bins addr_0 = {`GPIO_RGPIO_IN};}

    PWRITE_X_PADDR_WRITE: cross WRITE_ONLY_ENABLE,WRITE_ONLY_REG;

    PWRITE_X_PADDR_READ: cross READ_ONLY_ENABLE,READ_ONLY_REG;
    
    PSEL: coverpoint apb_xtn.psel{
           bins psel_0 = {1'b0};
           bins psel_1 = {1'b1};}

    PENABLE: coverpoint apb_xtn.penable{
              bins penable_bin = {1'b0,1'b1};}

    PWDATA: coverpoint apb_xtn.pwdata{
             bins pwdata_low_range = {[32'h0000_0000:32'h7fff_ffff]};
             bins pwdata_high_range = {[32'h8000_0000:32'hffff_ffff]};}

    PRDATA: coverpoint apb_xtn.prdata{
             bins prdata_range = {[32'h0000_0000:32'hffff_ffff]};}

    IRQ: coverpoint apb_xtn.irq{
          bins irq_0 = {1'b0};
          bins irq_1 = {1'b1};}

    PREADY: coverpoint apb_xtn.pready{
             bins pready_bin = {1'b0,1'b1};}
endgroup:apb_cg

covergroup aux_cg;
    AUX_IN: coverpoint aux_xtn.aux_in{
             bins aux_range = {[32'h0000_0000:32'hffff_ffff]};}
endgroup:aux_cg

covergroup io_cg;
    IO_PAD: coverpoint io_xtn.io_pad{
             bins io_low_range = {[32'h0000_0000:32'h7fff_ffff]};
             bins io_high_range = {[32'h8000_0000:32'hffff_ffff]};}
endgroup:io_cg

function new(string name="scoreboard",uvm_component parent=null);
    super.new(name,parent);
    apb_cg=new();
    aux_cg=new();
    io_cg=new();
endfunction:new

task run_phase(uvm_phase phase);
forever
    begin
        fork
            begin
                fifoh_apb.get(apb_xtn);
                `uvm_info("APB-SB",$sformatf("\nAPB Data sampled from scoreboard\n:%s",apb_xtn.sprint()),UVM_NONE)
                apb_cg.sample();
            end
            begin
                fifoh_aux.get(aux_xtn);
                `uvm_info("APB-AUX",$sformatf("AUX Data sampled from scoreboard\n:%s",aux_xtn.sprint()),UVM_NONE)
                aux_cg.sample();
            end
            begin
                fifoh_io.get(io_xtn);
                `uvm_info("APB-IO",$sformatf("IO Data sampled from scoreboard\n:%s",io_xtn.sprint()),UVM_NONE)
                io_cg.sample();
            end
        join
            compare(apb_xtn,aux_xtn,io_xtn);
            reg_report();
    end
endtask:run_phase


task read_reg();
    this.reg_block_h.RGPIO_IN_H.read(status,data1,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
    rgpio_in=data1[31:0];

    this.reg_block_h.RGPIO_OUT_H.read(status,data2,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
    rgpio_out=data2[31:0];

    this.reg_block_h.RGPIO_OE_H.read(status,data3,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
    rgpio_oe=data3[31:0];

    this.reg_block_h.RGPIO_AUX_H.read(status,data4,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
    rgpio_aux=data4[31:0];

    this.reg_block_h.RGPIO_INTE_H.read(status,data5,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
    rgpio_inte=data5[31:0];

    this.reg_block_h.RGPIO_PTRIG_H.read(status,data6,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
    rgpio_ptrig=data6[31:0];

    this.reg_block_h.RGPIO_CTRL_H.read(status,data7,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
    rgpio_ctrl=data7[1:0];

    this.reg_block_h.RGPIO_INTS_H.read(status,data8,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
    rgpio_ints=data8[31:0];

    this.reg_block_h.RGPIO_ECLK_H.read(status,data9,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
    rgpio_eclk=data9[31:0];

    this.reg_block_h.RGPIO_NEC_H.read(status,data10,.path(UVM_BACKDOOR),.map(reg_block_h.GPIO_REG_MAP));
    rgpio_nec=data10[31:0];

    //`uvm_info("rpgio_in",$sformatf("rgpio_in=%0h",rgpio_in),UVM_NONE)

endtask:read_reg


task ints_ref_model();

    read_reg();
    rgpio_ints_e = rgpio_ints;
 
    in_pad_i=io_xtn.io_pad;

    extc_in = (~rgpio_nec & in_pad_i) | (rgpio_nec & in_pad_i);
    in_mux = (rgpio_eclk & extc_in) | (~rgpio_eclk & in_pad_i);
    rgpio_ints_e = (rgpio_ints_e) | (((in_mux ^ rgpio_in) & ~(in_mux ^ rgpio_ptrig)) & (rgpio_inte));

    `uvm_info("SB - ints_ref_model_logic",$sformatf("extc_in=%0h,in_mux=%0h,rgpio_ints_e=%0h",extc_in,in_mux,rgpio_ints_e),UVM_NONE)

endtask:ints_ref_model


task compare(apb_trans apb_xtn,aux_trans aux_xtn,io_trans io_xtn);

    read_reg();


    $display("\n=============================================== VERIFYING REGISTERS =================================================================\n");
    
    // Verifying RGPIO_OUT Register

    `uvm_info("TEST1 - Verifying RGPIO_OUT",$sformatf("\nrgpio_oe=%0h,rgpio_aux=%0h,rgpio_out=%0h,io_pad=%0h\n",rgpio_oe,rgpio_aux,rgpio_out,io_xtn.io_pad),UVM_NONE)
    if(rgpio_oe != 32'h0 && rgpio_aux == 32'h0)
    begin
        for(int i=0;i<32;i++)
        begin
            if(rgpio_oe[i])
            begin
                if(io_xtn.io_pad[i] == rgpio_out[i])
                    out_seq_pass++;
                else
                    out_seq_err++;
            end
        end
    end

    // Verifying RGPIO_AUX Register

    `uvm_info("TEST2 - Verifying RGPIO_AUX",$sformatf("\nrgpio_oe=%0h,rgpio_aux=%0h,aux_in=%0h,io_pad=%0h\n",rgpio_oe,rgpio_aux,aux_xtn.aux_in,io_xtn.io_pad),UVM_NONE)
    if(rgpio_oe != 32'h0 && rgpio_aux == 32'hffff_ffff)
    begin
        for(int i=0;i<32;i++)
        begin
            if(rgpio_oe[i])
            begin
                if(aux_xtn.aux_in[i] == io_xtn.io_pad[i])
                    aux_seq_pass++;
                else
                    aux_seq_err++;
            end
        end
    end

    // Verifying RGPIO_IN Register - with sysclk

    `uvm_info("TEST3 - Verifying RGPIO_IN with Sysclk",$sformatf("\nrgpio_oe=%0h,rgpio_eclk=%0h,rgpio_in=%0h,io_pad=%0h\n",rgpio_oe,rgpio_eclk,rgpio_in,io_xtn.io_pad),UVM_NONE)

    if(rgpio_oe != 32'hffff_ffff && rgpio_aux == 32'h0)
    begin
        for(int i=0;i<32;i++)
        begin
            if(!rgpio_oe[i])
            begin
                if(!rgpio_eclk[i])
                begin
                    if(io_xtn.io_pad[i] == rgpio_in[i])
                        in_seq_sclk_pass++;
                    else
                        in_seq_sclk_err++;
                end
            end
        end
    end

    // Verifying RGPIO_IN Register - with extclk posedge triggered

    `uvm_info("TEST4 - Verifying RGPIO_IN with Extclk(postrig - inmux at posedge)",$sformatf("\nrgpio_oe=%0h,rgpio_eclk=%0h,rgpio_nec=%0h,rgpio_in=%0h,io_pad=%0h\n",rgpio_oe,rgpio_eclk,rgpio_nec,rgpio_in,io_xtn.io_pad),UVM_NONE)
    if(rgpio_oe == 32'h0000_0000 && rgpio_aux == 32'h0 /*&& rgpio_nec == 32'hffff_ffff*/)
    begin
        for(int i=0;i<32;i++)
        begin
            if(!rgpio_oe[i])
            begin
                if(!rgpio_nec[i])
                begin
                    if(rgpio_eclk[i])
                    begin
                        if(io_xtn.io_pad[i] == rgpio_in[i])
                            in_seq_eclk_pos_pass++;
                        else
                            in_seq_eclk_pos_err++;
                    end
                end
            end
        end
    end

    // Verifying RGPIO_IN Register - with extclk negedge triggered

    `uvm_info("TEST5 - Verifying RGPIO_IN with Extclk(negtrig - inmux at negedge)",$sformatf("\nrgpio_oe=%0h,rgpio_eclk=%0h,rgpio_nec=%0h,rgpio_in=%0h,io_pad=%0h\n",rgpio_oe,rgpio_eclk,rgpio_nec,rgpio_in,io_xtn.io_pad),UVM_NONE)
    if(rgpio_oe == 32'h0000_0000 && rgpio_aux == 32'h0)
    begin
        for(int i=0;i<32;i++)
        begin
            if(!rgpio_oe[i])
            begin
                if(rgpio_nec[i] && rgpio_eclk[i])
                begin
                    if(io_xtn.io_pad[i] == rgpio_in[i])
                        in_seq_eclk_neg_pass++;
                    else
                        in_seq_eclk_neg_err++;
                end
            end
        end
    end

    // Verifying RGPIO_INTS Register -  posedge triggered interrupts with sysclk

    ints_ref_model();

    `uvm_info("TEST6 - Verifying RGPIO_INTS - posedge triggered interrupts with sysclk",$sformatf("\nrgpio_oe=%0h,rgpio_eclk=%0h,rgpio_ptrig=%0h,rgpio_inte=%0h,rgpio_ctrl=%0h,rgpio_in=%0h,rgpio_ints=%0h,prev_io_pad=%0h,io_pad=%0h\n",rgpio_oe,rgpio_eclk,rgpio_ptrig,rgpio_inte,rgpio_ctrl,rgpio_in,rgpio_ints,prev_io_pad1,io_xtn.io_pad),UVM_NONE)

    if(rgpio_oe == 32'h0000_0000 && rgpio_aux == 32'h0)
    begin
        for(int i=0;i<32;i++)
        begin
            if(!rgpio_oe[i])
            begin
                if(!rgpio_eclk[i])
                begin
                    if(rgpio_ptrig[i] && rgpio_inte[i])
                    begin
                        if((prev_io_pad1[i]==0) && (rgpio_in[i]==1))
                        begin
                            if(rgpio_ints_e[i]==rgpio_ints[i])
                                intr_seq_ptrig_pass++;
                            else
                                intr_seq_ptrig_err++;
                        end
                    end
                end
            end
        end
    end
    
    // Verifying RGPIO_INTS Register -  negedge triggered interrupts with sysclk

    ints_ref_model();

    `uvm_info("TEST7 - Verifying RGPIO_INTS - negedge triggered interrupts with sysclk",$sformatf("\nrgpio_oe=%0h,rgpio_eclk=%0h,rgpio_ptrig=%0h,rgpio_inte=%0h,rgpio_ctrl=%0h,rgpio_in=%0h,rgpio_ints=%0h,prev_io_pad=%0h,io_pad=%0h\n",rgpio_oe,rgpio_eclk,rgpio_ptrig,rgpio_inte,rgpio_ctrl,rgpio_in,rgpio_ints,prev_io_pad2,io_xtn.io_pad),UVM_NONE)

    if(rgpio_oe == 32'h0000_0000 && rgpio_aux == 32'h0)
    begin
        for(int i=0;i<32;i++)
        begin
            if(!rgpio_oe[i])
            begin
                if(!rgpio_eclk[i])
                begin
                    if(!rgpio_ptrig[i] && rgpio_inte[i])
                    begin
                        if((prev_io_pad2[i]==1) && (rgpio_in[i]==0))
                        begin
                            if(rgpio_ints_e[i]==rgpio_ints[i])
                                intr_seq_ntrig_pass++;
                            else
                                intr_seq_ntrig_err++;
                        end
                    end
                end
            end
        end
    end

    // Verifying RGPIO_INTS Register - posedge triggered interrupts with eclk(inmux at posedge)

    ints_ref_model();

    `uvm_info("TEST8 - Verifying RGPIO_INTS - posedge triggered interrupts with eclk(inmux at posedge)",$sformatf("\nrgpio_oe=%0h,rgpio_eclk=%0h,rgpio_nec=%0h,rgpio_ptrig=%0h,rgpio_inte=%0h,rgpio_ctrl=%0h,rgpio_in=%0h,rgpio_ints=%0h,prev_io_pad=%0h,io_pad=%0h\n",rgpio_oe,rgpio_eclk,rgpio_nec,rgpio_ptrig,rgpio_inte,rgpio_ctrl,rgpio_in,rgpio_ints,prev_io_pad1,io_xtn.io_pad),UVM_NONE)

    if(rgpio_oe == 32'h0000_0000 && rgpio_aux == 32'h0)
    begin
        for(int i=0;i<32;i++)
        begin
            if(!rgpio_oe[i])
            begin
                if(rgpio_eclk[i] && !rgpio_nec[i])
                begin
                    if(rgpio_ptrig[i] && rgpio_inte[i])
                    begin
                        if((prev_io_pad1[i]==0) && (rgpio_in[i]==1))
                        begin
                            if(rgpio_ints_e[i]==rgpio_ints[i])
                                intr_seq_eclk_ptrig_pass1++;
                            else
                                intr_seq_eclk_ptrig_err1++;
                        end
                    end
                end
            end
        end
    end

    // Verifying RGPIO_INTS Register - posedge triggered interrupts with eclk(inmux at negedge)

    ints_ref_model();

    `uvm_info("TEST9 - Verifying RGPIO_INTS - posedge triggered interrupts with eclk(inmux at negedge)",$sformatf("\nrgpio_oe=%0h,rgpio_eclk=%0h,rgpio_nec=%0h,rgpio_ptrig=%0h,rgpio_inte=%0h,rgpio_ctrl=%0h,rgpio_in=%0h,rgpio_ints=%0h,prev_io_pad=%0h,io_pad=%0h\n",rgpio_oe,rgpio_eclk,rgpio_nec,rgpio_ptrig,rgpio_inte,rgpio_ctrl,rgpio_in,rgpio_ints,prev_io_pad1,io_xtn.io_pad),UVM_NONE)

    if(rgpio_oe == 32'h0000_0000 && rgpio_aux == 32'h0)
    begin
        for(int i=0;i<32;i++)
        begin
            if(!rgpio_oe[i])
            begin
                if(rgpio_eclk[i] && rgpio_nec[i])
                begin
                    if(rgpio_ptrig[i] && rgpio_inte[i])
                    begin
                        if((prev_io_pad1[i]==0) && (rgpio_in[i]==1))
                        begin
                            if(rgpio_ints_e[i]==rgpio_ints[i])
                                intr_seq_eclk_ptrig_pass2++;
                            else
                                intr_seq_eclk_ptrig_err2++;
                        end
                    end
                end
            end
        end
    end

    // Verifying RGPIO_INTS Register - negedge triggered interrupts with eclk(inmux at posedge)

    ints_ref_model();

    `uvm_info("TEST12 - Verifying RGPIO_INTS - negedge triggered interrupts with eclk(inmux at posedge)",$sformatf("\nrgpio_oe=%0h,rgpio_eclk=%0h,rgpio_nec=%0h,rgpio_ptrig=%0h,rgpio_inte=%0h,rgpio_ctrl=%0h,rgpio_in=%0h,rgpio_ints=%0h,prev_io_pad=%0h,io_pad=%0h\n",rgpio_oe,rgpio_eclk,rgpio_nec,rgpio_ptrig,rgpio_inte,rgpio_ctrl,rgpio_in,rgpio_ints,prev_io_pad2,io_xtn.io_pad),UVM_NONE)

    if(rgpio_oe == 32'h0000_0000 && rgpio_aux == 32'h0 && rgpio_eclk == 32'hffff_ffff)
    begin
        for(int i=0;i<32;i++)
        begin
            if(!rgpio_oe[i])
            begin
                if(rgpio_eclk[i])
                begin
                    if(!rgpio_nec[i])
                    begin
                        if(!rgpio_ptrig[i] && rgpio_inte[i])
                        begin
                            if((prev_io_pad2[i]==1) && (rgpio_in[i]==0))
                            begin
                                if(rgpio_ints_e[i]==rgpio_ints[i])
                                    intr_seq_eclk_ntrig_pass1++;
                                else
                                    intr_seq_eclk_ntrig_err1++;
                            end
                        end
                    end
                end
            end
        end
    end

    // Verifying RGPIO_INTS Register - negedge triggered interrupts with eclk(inmux at posedge)

    ints_ref_model();

    `uvm_info("TEST13 - Verifying RGPIO_INTS - negedge triggered interrupts with eclk(inmux at negedge)",$sformatf("\nrgpio_oe=%0h,rgpio_eclk=%0h,rgpio_nec=%0h,rgpio_ptrig=%0h,rgpio_inte=%0h,rgpio_ctrl=%0h,rgpio_in=%0h,rgpio_ints=%0h,prev_io_pad=%0h,io_pad=%0h\n",rgpio_oe,rgpio_eclk,rgpio_nec,rgpio_ptrig,rgpio_inte,rgpio_ctrl,rgpio_in,rgpio_ints,prev_io_pad2,io_xtn.io_pad),UVM_NONE)

    if(rgpio_oe == 32'h0000_0000 && rgpio_aux == 32'h0 && rgpio_eclk == 32'hffff_ffff)
    begin
        for(int i=0;i<32;i++)
        begin
            if(!rgpio_oe[i])
            begin
                if(rgpio_eclk[i])
                begin
                    if(rgpio_nec[i])
                    begin
                        if(!rgpio_ptrig[i] && rgpio_inte[i])
                        begin
                            if((prev_io_pad2[i]==1) && (rgpio_in[i]==0))
                            begin
                                if(rgpio_ints_e[i]==rgpio_ints[i])
                                    intr_seq_eclk_ntrig_pass2++;
                                else
                                    intr_seq_eclk_ntrig_err2++;
                            end
                        end
                    end
                end
            end
        end
    end

    // Verifying Registers with Bidirectional I/O
    
    `uvm_info("TEST10 - Verifying Registers with Bidirectional I/O",$sformatf("\nrgpio_oe=%0h,rgpio_out=%0h,rgpio_in=%0h,io_pad=%0h\n",rgpio_oe,rgpio_out,rgpio_in,io_xtn.io_pad),UVM_NONE)
    
    `uvm_info("BIDIR SB - out",$sformatf("RGPIO_OUT=%0h=io_pad[15:0]",io_xtn.io_pad[15:0]),UVM_NONE)
    `uvm_info("BIDIR SB - in",$sformatf("RGPIO_IN=%0h=io_pad[31:16]",io_xtn.io_pad[31:16]),UVM_NONE)
    if(rgpio_aux == 32'h0)
    begin
        for(int i=0;i<32;i++)
        begin
            if(rgpio_oe[i])
            begin
                if(rgpio_out[i] == io_xtn.io_pad[i])
                    bidir_io_out_pass++;
                else
                    bidir_io_out_err++;
            end
            else if(!rgpio_oe[i])
            begin
                if(!rgpio_eclk[i])
                begin
                    if(io_xtn.io_pad[i] == rgpio_in[i])
                        bidir_io_in_pass++;
                    else
                        bidir_io_in_err++;
                end
            end
        end
    end
    

    //$display("\n====================================================================================================================================\n");

endtask:compare


task reg_report();

    $display("\n=============================================== SCOREBOARD REPORT =================================================================\n");

    if(out_seq_pass > 0)
    begin
        `uvm_info(get_type_name(),"\nTEST1 - RGPIO_OUT Register is verified",UVM_NONE)
        `uvm_info(get_type_name(),$sformatf("\nout_seq_pass=%0d,out_seq_err=%0d\n\n",out_seq_pass,out_seq_err),UVM_NONE)
    end
    else
    begin
        `uvm_error(get_type_name(),"\nTEST1 - RGPIO_OUT Register is not verified");
        `uvm_info(get_type_name(),$sformatf("\nout_seq_pass=%0d,out_seq_err=%0d\n\n",out_seq_pass,out_seq_err),UVM_NONE)
    end

    if(aux_seq_pass > 0)
    begin
        `uvm_info(get_type_name(),"\nTEST2 - RGPIO_AUX Register is verified",UVM_NONE)
        `uvm_info(get_type_name(),$sformatf("\naux_seq_pass=%0d,aux_seq_err=%0d\n\n",aux_seq_pass,aux_seq_err),UVM_NONE)
    end
    else
    begin
        `uvm_error(get_type_name(),"\nTEST2 - RGPIO_AUX Register is not verified");
        `uvm_info(get_type_name(),$sformatf("\naux_seq_pass=%0d,aux_seq_err=%0d\n\n",aux_seq_pass,aux_seq_err),UVM_NONE)
    end


    if(in_seq_sclk_pass > 0)
    begin
        `uvm_info(get_type_name(),"\nTEST3 - RGPIO_IN Register with Sysclk is verified",UVM_NONE)
        `uvm_info(get_type_name(),$sformatf("\nin_seq_sclk_pass=%0d,in_seq_sclk_err=%0d\n\n",in_seq_sclk_pass,in_seq_sclk_err),UVM_NONE)
    end
    else
    begin
        `uvm_error(get_type_name(),"\nTEST3 - RGPIO_IN Register with Sysclk is not verified")
        `uvm_info(get_type_name(),$sformatf("\nin_seq_sclk_pass=%0d,in_seq_sclk_err=%0d\n\n",in_seq_sclk_pass,in_seq_sclk_err),UVM_NONE)
    end

    if(in_seq_eclk_pos_pass > 0)
    begin
        `uvm_info(get_type_name(),"\nTEST4 - RGPIO_IN Register with Extclk(postrig) is verified",UVM_NONE)
        `uvm_info(get_type_name(),$sformatf("\nin_seq_eclk_pos_pass=%0d,in_seq_eclk_pos_err=%0d\n\n",in_seq_eclk_pos_pass,in_seq_eclk_pos_err),UVM_NONE)
    end
    else
    begin
        `uvm_error(get_type_name(),"\nTEST4 - RGPIO_IN Register with Extclk(postrig) is not verified")
        `uvm_info(get_type_name(),$sformatf("\nin_seq_eclk_pos_pass=%0d,in_seq_eclk_pos_err=%0d\n\n",in_seq_eclk_pos_pass,in_seq_eclk_pos_err),UVM_NONE)
    end
    
    if(in_seq_eclk_neg_pass > 0)
    begin
        `uvm_info(get_type_name(),"\nTEST5 - RGPIO_IN Register with Extclk(negtrig) is verified",UVM_NONE)
        `uvm_info(get_type_name(),$sformatf("\nin_seq_eclk_neg_pass=%0d,in_seq_eclk_neg_err=%0d\n\n",in_seq_eclk_neg_pass,in_seq_eclk_neg_err),UVM_NONE)
    end
    else
    begin
        `uvm_error(get_type_name(),"\nTEST5 - RGPIO_IN Register with Extclk(negtrig) is not verified")
        `uvm_info(get_type_name(),$sformatf("\nin_seq_eclk_neg_pass=%0d,in_seq_eclk_neg_err=%0d\n\n",in_seq_eclk_neg_pass,in_seq_eclk_neg_err),UVM_NONE)
    end

    if(intr_seq_ptrig_pass > 0)
    begin
        `uvm_info(get_type_name(),"\nTEST6 - RGPIO_INTS Register - postrig interrupts with sysclk is verified",UVM_NONE)
        `uvm_info(get_type_name(),$sformatf("\nintr_seq_ptrig_pass=%0d,intr_seq_ptrig_err=%0d\n\n",intr_seq_ptrig_pass,intr_seq_ptrig_err),UVM_NONE)
    end
    else
    begin
        `uvm_error(get_type_name(),"\nTEST6 - RGPIO_INTS Register - postrig interrupts with sysclk is not verified")
        `uvm_info(get_type_name(),$sformatf("\nintr_seq_ptrig_pass=%0d,intr_seq_ptrig_err=%0d\n\n",intr_seq_ptrig_pass,intr_seq_ptrig_err),UVM_NONE)
    end

    if(intr_seq_ntrig_pass > 0)
    begin
        `uvm_info(get_type_name(),"\nTEST7 - RGPIO_INTS Register - negtrig interrupts with sysclk is verified",UVM_NONE)
        `uvm_info(get_type_name(),$sformatf("\nintr_seq_ntrig_pass=%0d,intr_seq_ntrig_err=%0d\n\n",intr_seq_ntrig_pass,intr_seq_ntrig_err),UVM_NONE)
    end
    else
    begin
        `uvm_error(get_type_name(),"\nTEST7 - RGPIO_INTS Register - negtrig interrupts with sysclk is not verified")
        `uvm_info(get_type_name(),$sformatf("\nintr_seq_ntrig_pass=%0d,intr_seq_ntrig_err=%0d\n\n",intr_seq_ntrig_pass,intr_seq_ntrig_err),UVM_NONE)
    end

    if(intr_seq_eclk_ptrig_pass1 > 0)
    begin
        `uvm_info(get_type_name(),"\nTEST8 - RGPIO_INTS Register - postrig interrupts with eclk(inmux at posedge) is verified",UVM_NONE)
        `uvm_info(get_type_name(),$sformatf("\nintr_seq_eclk_ptrig_pass1=%0d,intr_seq_eclk_ptrig_err1=%0d\n\n",intr_seq_eclk_ptrig_pass1,intr_seq_eclk_ptrig_err1),UVM_NONE)
    end
    else
    begin
        `uvm_error(get_type_name(),"\nTEST8 - RGPIO_INTS Register - postrig interrupts with eclk(inmux at posedge) is not verified")
        `uvm_info(get_type_name(),$sformatf("\nintr_seq_eclk_ptrig_pass1=%0d,intr_seq_eclk_ptrig_err1=%0d\n\n",intr_seq_eclk_ptrig_pass1,intr_seq_eclk_ptrig_err1),UVM_NONE)
    end

    if(intr_seq_eclk_ptrig_pass2 > 0)
    begin
        `uvm_info(get_type_name(),"\nTEST9 - RGPIO_INTS Register - postrig interrupts with eclk(inmux at negedge) is verified",UVM_NONE)
        `uvm_info(get_type_name(),$sformatf("\nintr_seq_eclk_ptrig_pass2=%0d,intr_seq_eclk_ptrig_err2=%0d\n\n",intr_seq_eclk_ptrig_pass2,intr_seq_eclk_ptrig_err2),UVM_NONE)
    end
    else
    begin
        `uvm_error(get_type_name(),"\nTEST9 - RGPIO_INTS Register - postrig interrupts with eclk(inmux at negedge) is not verified")
        `uvm_info(get_type_name(),$sformatf("\nintr_seq_eclk_ptrig_pass2=%0d,intr_seq_eclk_ptrig_err2=%0d\n\n",intr_seq_eclk_ptrig_pass2,intr_seq_eclk_ptrig_err2),UVM_NONE)
    end

    if(intr_seq_eclk_ntrig_pass1 > 0)
    begin
        `uvm_info(get_type_name(),"\nTEST12 - RGPIO_INTS Register - negtrig interrupts with eclk(inmux at posedge) is verified",UVM_NONE)
        `uvm_info(get_type_name(),$sformatf("\nintr_seq_eclk_ntrig_pass1=%0d,intr_seq_eclk_ntrig_err1=%0d\n\n",intr_seq_eclk_ntrig_pass1,intr_seq_eclk_ntrig_err1),UVM_NONE)
    end
    else
    begin
        `uvm_error(get_type_name(),"\nTEST12 - RGPIO_INTS Register - negtrig interrupts with eclk(inmux at posedge) is not verified")
        `uvm_info(get_type_name(),$sformatf("\nintr_seq_eclk_ntrig_pass1=%0d,intr_seq_eclk_ntrig_err1=%0d\n\n",intr_seq_eclk_ntrig_pass1,intr_seq_eclk_ntrig_err1),UVM_NONE)
    end

    if(intr_seq_eclk_ntrig_pass2 > 0)
    begin
        `uvm_info(get_type_name(),"\nTEST13 - RGPIO_INTS Register - negtrig interrupts with eclk(inmux at negedge) is verified",UVM_NONE)
        `uvm_info(get_type_name(),$sformatf("\nintr_seq_eclk_ntrig_pass2=%0d,intr_seq_eclk_ntrig_err2=%0d\n\n",intr_seq_eclk_ntrig_pass2,intr_seq_eclk_ntrig_err2),UVM_NONE)
    end
    else
    begin
        `uvm_error(get_type_name(),"\nTEST13 - RGPIO_INTS Register - negtrig interrupts with eclk(inmux at negedge) is not verified")
        `uvm_info(get_type_name(),$sformatf("\nintr_seq_eclk_ntrig_pass2=%0d,intr_seq_eclk_ntrig_err2=%0d\n\n",intr_seq_eclk_ntrig_pass2,intr_seq_eclk_ntrig_err2),UVM_NONE)
    end

    if((bidir_io_out_pass > 0) && (bidir_io_in_pass > 0))
    begin
        `uvm_info(get_type_name(),"\nTEST10 - Registers with Bidirectional I/O verified",UVM_NONE)
        `uvm_info(get_type_name(),$sformatf("\nbidir_io_out_pass=%0d,bidir_io_in_pass=%0d,bidir_io_out_err=%0d,bidir_io_in_err=%0d\n\n",bidir_io_out_pass,bidir_io_in_pass,bidir_io_out_err,bidir_io_in_err),UVM_NONE)
    end
    else
    begin
        `uvm_error(get_type_name(),"\nTEST10 - Registers with Bidirectional I/O not verified")
        `uvm_info(get_type_name(),$sformatf("\nbidir_io_out_pass=%0d,bidir_io_in_pass=%0d,bidir_io_out_err=%0d,bidir_io_in_err=%0d\n\n",bidir_io_out_pass,bidir_io_in_pass,bidir_io_out_err,bidir_io_in_err),UVM_NONE)
    end

    $display("====================================================================================================================================\n");
    

endtask:reg_report            

      

endclass:scoreboard
