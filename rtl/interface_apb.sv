interface interface_apb(input bit pclk);

bit presetn;
bit psel;
bit penable;
bit pwrite;
bit pready;
bit irq;
bit [31:0] pwdata;
bit [31:0] paddr;
bit [31:0] prdata;

clocking apb_drv_cb@(posedge pclk);
default input #1 output #0;
output presetn;
output psel;
output penable;
output pwrite;
output pwdata;
output paddr;
input pready;
endclocking:apb_drv_cb

clocking apb_mon_cb@(posedge pclk);
default input #1 output #0;
input presetn;
input psel;
input penable;
input pwrite;
input pwdata;
input paddr;
input prdata;
input pready;
input irq;
endclocking:apb_mon_cb

modport APB_DRV(clocking apb_drv_cb);
modport APB_MON(clocking apb_mon_cb);

endinterface:interface_apb
