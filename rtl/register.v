`include "definitions.v"

module register(sysclk,sysrst,gpio_we,gpio_addr,gpio_dat_i,gpio_dat_o,gpio_inta_o,aux_i,out_pad_o,oen_padoen_o,in_pad_i,gpio_eclk);

input sysclk,sysrst,gpio_we;
input [31:0] gpio_dat_i;
input [31:0] gpio_addr;
input [31:0] aux_i;
input [31:0] in_pad_i;
input gpio_eclk;

output reg [31:0] gpio_dat_o;
output wire gpio_inta_o;
output [31:0] out_pad_o;
output wire [31:0] oen_padoen_o;


reg [31:0] rgpio_out;
reg [31:0] rgpio_oe;
reg [31:0] rgpio_inte;
reg [31:0] rgpio_ptrig;
reg [31:0] rgpio_aux;
reg [31:0] rgpio_eclk;
reg [31:0] rgpio_nec;
reg [1:0] rgpio_ctrl;
reg [31:0] rgpio_in;
reg [31:0] rgpio_ints;

//RGPIO_OUT REGISTER

always@(posedge sysclk or negedge sysrst)
begin
    if(~sysrst)
        rgpio_out <= 32'd0;
    else if((gpio_addr==`GPIO_RGPIO_OUT) && gpio_we)
        rgpio_out <= gpio_dat_i;
    else
        rgpio_out <= rgpio_out;
end


//RGPIO_OE REGISTER

always@(posedge sysclk or negedge sysrst)
begin
   if(~sysrst)
       rgpio_oe <= 32'd0;
   else if((gpio_addr==`GPIO_RGPIO_OE) && gpio_we)
       rgpio_oe <= gpio_dat_i;
   else
       rgpio_oe <= rgpio_oe;
end


//RGPIO_INTE REGISTER

always@(posedge sysclk or negedge sysrst)
begin
   if(~sysrst)
       rgpio_inte <= 32'd0;
   else if((gpio_addr==`GPIO_RGPIO_INTE) && gpio_we)
       rgpio_inte <= gpio_dat_i;
   else
       rgpio_inte <= rgpio_inte;
end


//RGPIO_PTRIG REGISTER

always@(posedge sysclk or negedge sysrst)
begin
    if(~sysrst)
        rgpio_ptrig <= 32'd0;
    else if((gpio_addr==`GPIO_RGPIO_PTRIG) && gpio_we)
        rgpio_ptrig <= gpio_dat_i;
    else
        rgpio_ptrig <= rgpio_ptrig;
end


//RGPIO_AUX REGISTER

always@(posedge sysclk or negedge sysrst)
begin
   if(~sysrst)
       rgpio_aux <= 32'd0;
   else if((gpio_addr==`GPIO_RGPIO_AUX) && gpio_we)
       rgpio_aux <= gpio_dat_i;
   else
       rgpio_aux <= rgpio_aux;
end


//RGPIO_ECLK REGISTER

always@(posedge sysclk or negedge sysrst)
begin
   if(~sysrst)
       rgpio_eclk <= 32'd0;
   else if((gpio_addr==`GPIO_RGPIO_ECLK) && gpio_we)
       rgpio_eclk <= gpio_dat_i;
   else
       rgpio_eclk <= rgpio_eclk;
end


//RGPIO_NEC REGISTER

always@(posedge sysclk or negedge sysrst)
begin
   if(~sysrst)
       rgpio_nec <= 32'd0;
   else if((gpio_addr==`GPIO_RGPIO_NEC) && gpio_we)
       rgpio_nec <= gpio_dat_i;
   else
       rgpio_nec <= rgpio_nec;
end


//RGPIO_CTRL REGISTER

always@(posedge sysclk or negedge sysrst)
begin
   if(~sysrst)
       rgpio_ctrl <= 2'd0;
   else if((gpio_addr==`GPIO_RGPIO_CTRL) && gpio_we)
       rgpio_ctrl <= gpio_dat_i[1:0];
   else if(rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE])
           rgpio_ctrl[`GPIO_RGPIO_CTRL_INTS] <= rgpio_ctrl[`GPIO_RGPIO_CTRL_INTS] | gpio_inta_o;
       //rgpio_ctrl <= {rgpio_ctrl[`GPIO_RGPIO_CTRL_INTS] | gpio_inta_o,rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE]};
    else
           rgpio_ctrl <= rgpio_ctrl;
end


//RGPIO_IN REGISTER

reg [31:0] pextc_sampled;
reg [31:0] nextc_sampled;
reg [31:0] extc_in;
reg [31:0] in_mux;

always@(posedge gpio_eclk or negedge sysrst)
begin
   if(~sysrst)
       pextc_sampled <= 32'd0;
   else
       pextc_sampled <= in_pad_i;
end

always@(negedge gpio_eclk or negedge sysrst)
begin
    if(~sysrst)
        nextc_sampled <= 32'd0;
    else
        nextc_sampled <= in_pad_i;
end

always@(*)
begin
    if(rgpio_nec)
        extc_in = nextc_sampled;
    else
        extc_in = pextc_sampled;
end

always@(*)
begin
    if(rgpio_eclk)
        in_mux = extc_in;
    else
        in_mux = in_pad_i;
end

//rgpio_in logic

always@(posedge sysclk or negedge sysrst)
begin
    if(~sysrst)
        rgpio_in <= 32'd0;
    else
        rgpio_in <= in_mux;
end


//RGPIO_INTS REGISTER

wire [31:0] w1,w2,w3,w4,w5,w6;

assign w1 = rgpio_in ^ in_mux;
assign w2 = rgpio_ptrig ~^ in_mux;
assign w3 = w1 & w2 & rgpio_inte;
assign w4 = w3 | rgpio_ints;
assign w5 = rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE] ? w4 : rgpio_ints;
assign w6 = ((gpio_addr==`GPIO_RGPIO_INTS) && gpio_we) ? gpio_dat_i : w5;

always@(posedge sysclk or negedge sysrst)
begin
    if(~sysrst)
        rgpio_ints <= 32'd0;
    else
        rgpio_ints <= w6;
end


//out_pad_o logic

assign out_pad_o = (rgpio_out & ~rgpio_aux) | (rgpio_aux & aux_i);

//oen_padoen_o logic

assign oen_padoen_o = rgpio_oe;

//interrupt request logic

assign gpio_inta_o = rgpio_ints ? rgpio_ctrl[`GPIO_RGPIO_CTRL_INTE] : 1'b0;

//Selection of a register

reg [31:0] data_reg;

always@(*)
begin
    case(gpio_addr)
        `GPIO_RGPIO_IN      : data_reg = rgpio_in;
        `GPIO_RGPIO_OUT     : data_reg = rgpio_out;
        `GPIO_RGPIO_OE      : data_reg = rgpio_oe;
        `GPIO_RGPIO_INTE    : data_reg = rgpio_inte;
        `GPIO_RGPIO_PTRIG   : data_reg = rgpio_ptrig;
        `GPIO_RGPIO_AUX     : data_reg = rgpio_aux;
        `GPIO_RGPIO_CTRL    : data_reg = rgpio_ctrl;
        `GPIO_RGPIO_INTS    : data_reg = rgpio_ints;
        `GPIO_RGPIO_ECLK    : data_reg = rgpio_eclk;
        `GPIO_RGPIO_NEC     : data_reg = rgpio_nec;
        default             : data_reg = 32'hx;
    endcase
end


//Reading from a register

always@(posedge sysclk or negedge sysrst)
begin
    if(~sysrst)
        gpio_dat_o <= 32'h0;
    else
        gpio_dat_o <= data_reg;
end

endmodule
