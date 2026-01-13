interface interface_aux(input bit pclk);

bit [31:0] aux_in;

clocking aux_drv_cb@(posedge pclk);
default input #1 output #0;
output aux_in;
endclocking:aux_drv_cb

clocking aux_mon_cb@(posedge pclk);
default input #1 output #0;
input aux_in;
endclocking:aux_mon_cb

modport AUX_DRV(clocking aux_drv_cb);
modport AUX_MON(clocking aux_mon_cb);

endinterface:interface_aux
