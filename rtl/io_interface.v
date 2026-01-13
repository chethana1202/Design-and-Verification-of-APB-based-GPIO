module io_interface(out_pad_o,oen_padoen_o,in_pad_i,io_pad,ext_clk_pad_i,gpio_eclk);

input [31:0] out_pad_o;
input [31:0] oen_padoen_o;
inout [31:0] io_pad;
output wire [31:0] in_pad_i;

input ext_clk_pad_i;
output wire gpio_eclk;

    assign io_pad[0] = (oen_padoen_o[0]==1'b1) ? out_pad_o[0] : 1'bz;
    assign io_pad[1] = (oen_padoen_o[1]==1'b1) ? out_pad_o[1] : 1'bz;
    assign io_pad[2] = (oen_padoen_o[2]==1'b1) ? out_pad_o[2] : 1'bz;
    assign io_pad[3] = (oen_padoen_o[3]==1'b1) ? out_pad_o[3] : 1'bz;
    assign io_pad[4] = (oen_padoen_o[4]==1'b1) ? out_pad_o[4] : 1'bz;
    assign io_pad[5] = (oen_padoen_o[5]==1'b1) ? out_pad_o[5] : 1'bz;
    assign io_pad[6] = (oen_padoen_o[6]==1'b1) ? out_pad_o[6] : 1'bz;
    assign io_pad[7] = (oen_padoen_o[7]==1'b1) ? out_pad_o[7] : 1'bz;
    assign io_pad[8] = (oen_padoen_o[8]==1'b1) ? out_pad_o[8] : 1'bz;
    assign io_pad[9] = (oen_padoen_o[9]==1'b1) ? out_pad_o[9] : 1'bz;
    assign io_pad[10] = (oen_padoen_o[10]==1'b1) ? out_pad_o[10] : 1'bz;
    assign io_pad[11] = (oen_padoen_o[11]==1'b1) ? out_pad_o[11] : 1'bz;
    assign io_pad[12] = (oen_padoen_o[12]==1'b1) ? out_pad_o[12] : 1'bz;
    assign io_pad[13] = (oen_padoen_o[13]==1'b1) ? out_pad_o[13] : 1'bz;
    assign io_pad[14] = (oen_padoen_o[14]==1'b1) ? out_pad_o[14] : 1'bz;
    assign io_pad[15] = (oen_padoen_o[15]==1'b1) ? out_pad_o[15] : 1'bz;
    assign io_pad[16] = (oen_padoen_o[16]==1'b1) ? out_pad_o[16] : 1'bz;
    assign io_pad[17] = (oen_padoen_o[17]==1'b1) ? out_pad_o[17] : 1'bz;
    assign io_pad[18] = (oen_padoen_o[18]==1'b1) ? out_pad_o[18] : 1'bz;
    assign io_pad[19] = (oen_padoen_o[19]==1'b1) ? out_pad_o[19] : 1'bz;
    assign io_pad[20] = (oen_padoen_o[20]==1'b1) ? out_pad_o[20] : 1'bz;
    assign io_pad[21] = (oen_padoen_o[21]==1'b1) ? out_pad_o[21] : 1'bz;
    assign io_pad[22] = (oen_padoen_o[22]==1'b1) ? out_pad_o[22] : 1'bz;
    assign io_pad[23] = (oen_padoen_o[23]==1'b1) ? out_pad_o[23] : 1'bz;
    assign io_pad[24] = (oen_padoen_o[24]==1'b1) ? out_pad_o[24] : 1'bz;
    assign io_pad[25] = (oen_padoen_o[25]==1'b1) ? out_pad_o[25] : 1'bz;
    assign io_pad[26] = (oen_padoen_o[26]==1'b1) ? out_pad_o[26] : 1'bz;
    assign io_pad[27] = (oen_padoen_o[27]==1'b1) ? out_pad_o[27] : 1'bz;
    assign io_pad[28] = (oen_padoen_o[28]==1'b1) ? out_pad_o[28] : 1'bz;
    assign io_pad[29] = (oen_padoen_o[29]==1'b1) ? out_pad_o[29] : 1'bz;
    assign io_pad[30] = (oen_padoen_o[30]==1'b1) ? out_pad_o[30] : 1'bz;
    assign io_pad[31] = (oen_padoen_o[31]==1'b1) ? out_pad_o[31] : 1'bz;

    assign in_pad_i[0] = (oen_padoen_o[0]==1'b0) ? io_pad[0] : 1'bz;
    assign in_pad_i[1] = (oen_padoen_o[1]==1'b0) ? io_pad[1] : 1'bz;
    assign in_pad_i[2] = (oen_padoen_o[2]==1'b0) ? io_pad[2] : 1'bz;
    assign in_pad_i[3] = (oen_padoen_o[3]==1'b0) ? io_pad[3] : 1'bz;
    assign in_pad_i[4] = (oen_padoen_o[4]==1'b0) ? io_pad[4] : 1'bz;
    assign in_pad_i[5] = (oen_padoen_o[5]==1'b0) ? io_pad[5] : 1'bz;
    assign in_pad_i[6] = (oen_padoen_o[6]==1'b0) ? io_pad[6] : 1'bz;
    assign in_pad_i[7] = (oen_padoen_o[7]==1'b0) ? io_pad[7] : 1'bz;
    assign in_pad_i[8] = (oen_padoen_o[8]==1'b0) ? io_pad[8] : 1'bz;
    assign in_pad_i[9] = (oen_padoen_o[9]==1'b0) ? io_pad[9] : 1'bz;
    assign in_pad_i[10] = (oen_padoen_o[10]==1'b0) ? io_pad[10] : 1'bz;
    assign in_pad_i[11] = (oen_padoen_o[11]==1'b0) ? io_pad[11] : 1'bz;
    assign in_pad_i[12] = (oen_padoen_o[12]==1'b0) ? io_pad[12] : 1'bz;
    assign in_pad_i[13] = (oen_padoen_o[13]==1'b0) ? io_pad[13] : 1'bz;
    assign in_pad_i[14] = (oen_padoen_o[14]==1'b0) ? io_pad[14] : 1'bz;
    assign in_pad_i[15] = (oen_padoen_o[15]==1'b0) ? io_pad[15] : 1'bz;
    assign in_pad_i[16] = (oen_padoen_o[16]==1'b0) ? io_pad[16] : 1'bz;
    assign in_pad_i[17] = (oen_padoen_o[17]==1'b0) ? io_pad[17] : 1'bz;
    assign in_pad_i[18] = (oen_padoen_o[18]==1'b0) ? io_pad[18] : 1'bz;
    assign in_pad_i[19] = (oen_padoen_o[19]==1'b0) ? io_pad[19] : 1'bz;
    assign in_pad_i[20] = (oen_padoen_o[20]==1'b0) ? io_pad[20] : 1'bz;
    assign in_pad_i[21] = (oen_padoen_o[21]==1'b0) ? io_pad[21] : 1'bz;
    assign in_pad_i[22] = (oen_padoen_o[22]==1'b0) ? io_pad[22] : 1'bz;
    assign in_pad_i[23] = (oen_padoen_o[23]==1'b0) ? io_pad[23] : 1'bz;
    assign in_pad_i[24] = (oen_padoen_o[24]==1'b0) ? io_pad[24] : 1'bz;
    assign in_pad_i[25] = (oen_padoen_o[25]==1'b0) ? io_pad[25] : 1'bz;
    assign in_pad_i[26] = (oen_padoen_o[26]==1'b0) ? io_pad[26] : 1'bz;
    assign in_pad_i[27] = (oen_padoen_o[27]==1'b0) ? io_pad[27] : 1'bz;
    assign in_pad_i[28] = (oen_padoen_o[28]==1'b0) ? io_pad[28] : 1'bz;
    assign in_pad_i[29] = (oen_padoen_o[29]==1'b0) ? io_pad[29] : 1'bz;
    assign in_pad_i[30] = (oen_padoen_o[30]==1'b0) ? io_pad[30] : 1'bz;
    assign in_pad_i[31] = (oen_padoen_o[31]==1'b0) ? io_pad[31] : 1'bz;

    assign gpio_eclk=ext_clk_pad_i;

endmodule
