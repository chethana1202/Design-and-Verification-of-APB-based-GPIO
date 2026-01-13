module aux_interface(sysclk,sysrst,aux_in,aux_i);

input sysclk,sysrst;
input [31:0] aux_in;
output reg [31:0] aux_i;

always@(posedge sysclk or negedge sysrst)
begin
    if(~sysrst)
        aux_i <= 32'd0;
    else
        aux_i <= aux_in;
end

endmodule
