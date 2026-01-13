interface interface_io(input bit pclk);

wire [31:0] io_pad;

clocking io_drv_cb@(posedge pclk);
default input #1 output #0;
inout io_pad;
endclocking:io_drv_cb

clocking io_mon_cb@(posedge pclk);
default input #1 output #0;
inout io_pad;
endclocking:io_mon_cb

modport IO_DRV(clocking io_drv_cb);
modport IO_MON(clocking io_mon_cb);

endinterface:interface_io
