class reg_RGPIO_IN extends uvm_reg;

rand uvm_reg_field RGPIO_IN;

`uvm_object_utils(reg_RGPIO_IN)

function new(string name="reg_RGPIO_IN");
    super.new(name,32,UVM_NO_COVERAGE);
endfunction:new

virtual function void build();
    RGPIO_IN=uvm_reg_field::type_id::create("RGPIO_IN");
    RGPIO_IN.configure(this,32,0,"RO",1,32'h0,1,1,0); // configure(parent,width of reg,lsb position,permission,volatile/non_volatile,value of reg on reset,
                                                      // reset applicable/not,rand_mode enabler,bit accessibility)
endfunction:build

endclass:reg_RGPIO_IN

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class reg_RGPIO_OUT extends uvm_reg;

rand uvm_reg_field RGPIO_OUT;

`uvm_object_utils(reg_RGPIO_OUT)

function new(string name="reg_RGPIO_OUT");
    super.new(name,32,UVM_NO_COVERAGE);
endfunction:new

virtual function void build();
    RGPIO_OUT=uvm_reg_field::type_id::create("RGPIO_OUT");
    RGPIO_OUT.configure(this,32,0,"RW",1,32'h0,1,1,0);
endfunction:build

endclass:reg_RGPIO_OUT

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class reg_RGPIO_OE extends uvm_reg;

rand uvm_reg_field RGPIO_OE;

`uvm_object_utils(reg_RGPIO_OE)

function new(string name="reg_RGPIO_OE");
    super.new(name,32,UVM_NO_COVERAGE);
endfunction:new

virtual function void build();
    RGPIO_OE=uvm_reg_field::type_id::create("RGPIO_OE");
    RGPIO_OE.configure(this,32,0,"RW",1,32'h0,1,1,0);
endfunction:build

endclass:reg_RGPIO_OE

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class reg_RGPIO_INTE extends uvm_reg;

rand uvm_reg_field RGPIO_INTE;

`uvm_object_utils(reg_RGPIO_INTE)

function new(string name="reg_RGPIO_INTE");
    super.new(name,32,UVM_NO_COVERAGE);
endfunction:new

virtual function void build();
    RGPIO_INTE=uvm_reg_field::type_id::create("RGPIO_INTE");
    RGPIO_INTE.configure(this,32,0,"RW",1,32'h0,1,1,0);
endfunction:build

endclass:reg_RGPIO_INTE

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class reg_RGPIO_PTRIG extends uvm_reg;

rand uvm_reg_field RGPIO_PTRIG;

`uvm_object_utils(reg_RGPIO_PTRIG)

function new(string name="reg_RGPIO_PTRIG");
    super.new(name,32,UVM_NO_COVERAGE);
endfunction:new

virtual function void build();
    RGPIO_PTRIG=uvm_reg_field::type_id::create("RGPIO_PTRIG");
    RGPIO_PTRIG.configure(this,32,0,"RW",1,32'h0,1,1,0);
endfunction:build

endclass:reg_RGPIO_PTRIG

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class reg_RGPIO_AUX extends uvm_reg;

rand uvm_reg_field RGPIO_AUX;

`uvm_object_utils(reg_RGPIO_AUX)

function new(string name="reg_RGPIO_AUX");
    super.new(name,32,UVM_NO_COVERAGE);
endfunction:new

virtual function void build();
    RGPIO_AUX=uvm_reg_field::type_id::create("RGPIO_AUX");
    RGPIO_AUX.configure(this,32,0,"RW",1,32'h0,1,1,0);
endfunction:build

endclass:reg_RGPIO_AUX

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class reg_RGPIO_CTRL extends uvm_reg;

rand uvm_reg_field RGPIO_CTRL;

`uvm_object_utils(reg_RGPIO_CTRL)

function new(string name="reg_RGPIO_CTRL");
    super.new(name,32,UVM_NO_COVERAGE);
endfunction:new

virtual function void build();
    RGPIO_CTRL=uvm_reg_field::type_id::create("RGPIO_CTRL");
    RGPIO_CTRL.configure(this,2,0,"RW",1,2'h0,1,1,0);
endfunction:build

endclass:reg_RGPIO_CTRL

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class reg_RGPIO_INTS extends uvm_reg;

rand uvm_reg_field RGPIO_INTS;

`uvm_object_utils(reg_RGPIO_INTS)

function new(string name="reg_RGPIO_INTS");
    super.new(name,32,UVM_NO_COVERAGE);
endfunction:new

virtual function void build();
    RGPIO_INTS=uvm_reg_field::type_id::create("RGPIO_INTS");
    RGPIO_INTS.configure(this,32,0,"RW",1,32'h0,1,1,0);
endfunction:build

endclass:reg_RGPIO_INTS

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class reg_RGPIO_ECLK extends uvm_reg;

rand uvm_reg_field RGPIO_ECLK;

`uvm_object_utils(reg_RGPIO_ECLK)

function new(string name="reg_RGPIO_ECLK");
    super.new(name,32,UVM_NO_COVERAGE);
endfunction:new

virtual function void build();
    RGPIO_ECLK=uvm_reg_field::type_id::create("RGPIO_ECLK");
    RGPIO_ECLK.configure(this,32,0,"RW",1,32'h0,1,1,0);
endfunction:build

endclass:reg_RGPIO_ECLK

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class reg_RGPIO_NEC extends uvm_reg;

rand uvm_reg_field RGPIO_NEC;

`uvm_object_utils(reg_RGPIO_NEC)

function new(string name="reg_RGPIO_NEC");
    super.new(name,32,UVM_NO_COVERAGE);
endfunction:new

virtual function void build();
    RGPIO_NEC=uvm_reg_field::type_id::create("RGPIO_NEC");
    RGPIO_NEC.configure(this,32,0,"RW",1,32'h0,1,1,0);
endfunction:build

endclass:reg_RGPIO_NEC

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

