module apb_slave_interface(pclk,presetn,psel,penable,pwrite,pready,pwdata,paddr,prdata,irq,sysclk,sysrst,gpio_we,gpio_addr,gpio_dat_i,gpio_dat_o,gpio_inta_o);

input pclk,presetn,psel,penable,pwrite,gpio_inta_o;
input [31:0] paddr;
input [31:0] pwdata;
input [31:0] gpio_dat_o;

output reg pready;
output reg [31:0] prdata;
output wire irq,sysclk,sysrst;
output reg gpio_we;
output wire [31:0] gpio_addr;
output reg [31:0] gpio_dat_i;

parameter idle=2'b00,
          setup=2'b01,
          enable=2'b10;

reg [1:0] present, next;

always@(posedge pclk or negedge presetn)
begin
    if(~presetn)
        present <= idle;
    else
        present <= next;
end

always@(*)
begin
    case(present)
    idle:
        begin
            if(psel && ~penable)
            begin
                next = setup;
            end
            else
            begin
                next = idle;
            end
        end
    setup:
        begin
            if(psel && penable)
            begin
                next = enable;
            end
            else
            begin
                next = setup;
            end
        end
    enable:
        begin
            if(~psel)
            begin
                next = idle;
            end
            else
            begin
                next = setup;
            end
        end
    default:
        begin
            next = idle;
        end
    endcase
end

always@(*)
begin
    pready=(present==enable);
end

always@(*)
begin
        if(present==enable)
        begin
            if(pwrite)
            begin
                gpio_we = 1'b1;
                gpio_dat_i = pwdata;
                prdata = 32'd0;
            end
            else
            begin
                gpio_we = 1'b0;
                gpio_dat_i = 32'd0;
                prdata = gpio_dat_o;
            end
        end
        else
        begin
            gpio_dat_i = 32'd0;
            gpio_we = 1'b0;
            prdata = 32'd0;
        end
end


assign sysclk = pclk;
assign sysrst = presetn;
assign gpio_addr = paddr;
//assign gpio_we = (present==enable && pwrite)
assign irq = gpio_inta_o;

endmodule
