`include "definitions.v"

class reg_map extends uvm_reg_block;

`uvm_object_utils(reg_map)

reg_RGPIO_IN RGPIO_IN_H;
reg_RGPIO_OUT RGPIO_OUT_H;
reg_RGPIO_OE RGPIO_OE_H;
reg_RGPIO_INTE RGPIO_INTE_H;
reg_RGPIO_PTRIG RGPIO_PTRIG_H;
reg_RGPIO_AUX RGPIO_AUX_H;
reg_RGPIO_CTRL RGPIO_CTRL_H;
reg_RGPIO_INTS RGPIO_INTS_H;
reg_RGPIO_ECLK RGPIO_ECLK_H;
reg_RGPIO_NEC RGPIO_NEC_H;

uvm_reg_map GPIO_REG_MAP;

function new(string name="reg_map");
	super.new(name,UVM_NO_COVERAGE);
endfunction:new

virtual function void build();
	RGPIO_IN_H=reg_RGPIO_IN::type_id::create("RGPIO_IN_H");
	RGPIO_IN_H.configure(this,null,"");
	RGPIO_IN_H.build();
	RGPIO_IN_H.add_hdl_path_slice("rgpio_in",0,32); // add_hdl_path_slice(string name of reg,lsb position,width of reg)

	RGPIO_OUT_H=reg_RGPIO_OUT::type_id::create("RGPIO_OUT_H");
	RGPIO_OUT_H.configure(this,null,"");
	RGPIO_OUT_H.build();
	RGPIO_OUT_H.add_hdl_path_slice("rgpio_out",0,32);

	RGPIO_OE_H=reg_RGPIO_OE::type_id::create("RGPIO_OE_H");
	RGPIO_OE_H.configure(this,null,"");
	RGPIO_OE_H.build();
	RGPIO_OE_H.add_hdl_path_slice("rgpio_oe",0,32);

	RGPIO_INTE_H=reg_RGPIO_INTE::type_id::create("RGPIO_INTE_H");
	RGPIO_INTE_H.configure(this,null,"");
	RGPIO_INTE_H.build();
	RGPIO_INTE_H.add_hdl_path_slice("rgpio_inte",0,32);

	RGPIO_PTRIG_H=reg_RGPIO_PTRIG::type_id::create("RGPIO_PTRIG_H");
	RGPIO_PTRIG_H.configure(this,null,"");
	RGPIO_PTRIG_H.build();
	RGPIO_PTRIG_H.add_hdl_path_slice("rgpio_ptrig",0,32);

	RGPIO_AUX_H=reg_RGPIO_AUX::type_id::create("RGPIO_AUX_H");
	RGPIO_AUX_H.configure(this,null,"");
	RGPIO_AUX_H.build();
	RGPIO_AUX_H.add_hdl_path_slice("rgpio_aux",0,32);

	RGPIO_CTRL_H=reg_RGPIO_CTRL::type_id::create("RGPIO_CTRL_H");
	RGPIO_CTRL_H.configure(this,null,"");
	RGPIO_CTRL_H.build();
	RGPIO_CTRL_H.add_hdl_path_slice("rgpio_ctrl",0,2);

	RGPIO_INTS_H=reg_RGPIO_INTS::type_id::create("RGPIO_INTS_H");
	RGPIO_INTS_H.configure(this,null,"");
	RGPIO_INTS_H.build();
	RGPIO_INTS_H.add_hdl_path_slice("rgpio_ints",0,32);

	RGPIO_ECLK_H=reg_RGPIO_ECLK::type_id::create("RGPIO_ECLK_H");
	RGPIO_ECLK_H.configure(this,null,"");
	RGPIO_ECLK_H.build();
	RGPIO_ECLK_H.add_hdl_path_slice("rgpio_eclk",0,32);

	RGPIO_NEC_H=reg_RGPIO_NEC::type_id::create("RGPIO_NEC_H");
	RGPIO_NEC_H.configure(this,null,"");
	RGPIO_NEC_H.build();
	RGPIO_NEC_H.add_hdl_path_slice("rgpio_nec",0,32);

	GPIO_REG_MAP=create_map("GPIO_REG_MAP",'h0,4,UVM_LITTLE_ENDIAN,1); // create_map(string repn of reg_map handle,lsb position,no of bytes of reg,
                                                                       //            endianness,byte addressable/not)
	default_map=GPIO_REG_MAP;

	GPIO_REG_MAP.add_reg(RGPIO_IN_H,`GPIO_RGPIO_IN,"RO"); //add_reg(handle of reg,addr of reg,type of access)
	GPIO_REG_MAP.add_reg(RGPIO_OUT_H,`GPIO_RGPIO_OUT,"RW");
	GPIO_REG_MAP.add_reg(RGPIO_OE_H,`GPIO_RGPIO_OE,"RW");
	GPIO_REG_MAP.add_reg(RGPIO_INTE_H,`GPIO_RGPIO_INTE,"RW");
	GPIO_REG_MAP.add_reg(RGPIO_PTRIG_H,`GPIO_RGPIO_PTRIG,"RW");
	GPIO_REG_MAP.add_reg(RGPIO_AUX_H,`GPIO_RGPIO_AUX,"RW");
	GPIO_REG_MAP.add_reg(RGPIO_CTRL_H,`GPIO_RGPIO_CTRL,"RW");
	GPIO_REG_MAP.add_reg(RGPIO_INTS_H,`GPIO_RGPIO_INTS,"RW");
	GPIO_REG_MAP.add_reg(RGPIO_ECLK_H,`GPIO_RGPIO_ECLK,"RW");
	GPIO_REG_MAP.add_reg(RGPIO_NEC_H,`GPIO_RGPIO_NEC,"RW");

	add_hdl_path("top.DUT.regi","RTL"); // add_hdl_path(string path of the register from DUT,Makefile directory name for register dut)
    lock_model();
endfunction:build

endclass:reg_map
