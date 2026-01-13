module gpio_top(pclk,presetn,psel,penable,pwrite,pready,paddr,pwdata,prdata,irq,aux_in,io_pad,ext_clk_pad_i);

input pclk,presetn,psel,penable,pwrite;
input [31:0] paddr,pwdata,aux_in;
input ext_clk_pad_i;

inout [31:0] io_pad;

output pready,irq;
output [31:0] prdata;

wire sysclk,sysrst,gpio_we,gpio_inta_o;
wire [31:0] gpio_addr,gpio_dat_i,gpio_dat_o,aux_i;
wire [31:0] out_pad_o,oen_padoen_o,in_pad_i;
wire gpio_eclk;

apb_slave_interface apb(.pclk(pclk),.presetn(presetn),.psel(psel),.penable(penable),.pwrite(pwrite),
                   .pready(pready),.paddr(paddr),.pwdata(pwdata),.prdata(prdata),.irq(irq),
                   .sysclk(sysclk),.sysrst(sysrst),.gpio_we(gpio_we),.gpio_addr(gpio_addr),
                   .gpio_dat_i(gpio_dat_i),.gpio_dat_o(gpio_dat_o),.gpio_inta_o(gpio_inta_o));

register regi(.sysclk(sysclk),.sysrst(sysrst),.gpio_we(gpio_we),.gpio_addr(gpio_addr),
              .gpio_dat_i(gpio_dat_i),.gpio_dat_o(gpio_dat_o),.gpio_inta_o(gpio_inta_o),
              .aux_i(aux_i),.out_pad_o(out_pad_o),.oen_padoen_o(oen_padoen_o),.in_pad_i(in_pad_i),
              .gpio_eclk(gpio_eclk));

aux_interface ai(.sysclk(sysclk),.sysrst(sysrst),.aux_in(aux_in),.aux_i(aux_i));

io_interface io(.out_pad_o(out_pad_o),.oen_padoen_o(oen_padoen_o),.in_pad_i(in_pad_i),
                .gpio_eclk(gpio_eclk),.io_pad(io_pad),.ext_clk_pad_i(ext_clk_pad_i)); 

endmodule
