module top;

import gpio_pkg::*;
import uvm_pkg::*;

bit pclk;
bit ext_clk_pad_i;

always
    #5 pclk=~pclk;

always
    #10 ext_clk_pad_i=~ext_clk_pad_i;

interface_apb in0(pclk);
interface_aux in1(pclk);
interface_io in2(pclk);

gpio_top DUT(.pclk(pclk),.presetn(in0.presetn),.psel(in0.psel),.penable(in0.penable),
             .pwrite(in0.pwrite),.paddr(in0.paddr),.pwdata(in0.pwdata),
             .aux_in(in1.aux_in),.ext_clk_pad_i(ext_clk_pad_i),
             .io_pad(in2.io_pad),.pready(in0.pready),.irq(in0.irq),.prdata(in0.prdata));

bind gpio_top assertions a1(.pclk(pclk),.presetn(in0.presetn),.psel(in0.psel),
			    .penable(in0.penable),.pready(in0.pready),.pwrite(in0.pwrite),
			    .paddr(in0.paddr),.pwdata(in0.pwdata));

initial
    begin
        uvm_config_db #(virtual interface_apb)::set(null,"*","apb_vif",in0);
        uvm_config_db #(virtual interface_aux)::set(null,"*","aux_vif",in1);
        uvm_config_db #(virtual interface_io)::set(null,"*","io_vif",in2);

	run_test();
    end

endmodule:top
