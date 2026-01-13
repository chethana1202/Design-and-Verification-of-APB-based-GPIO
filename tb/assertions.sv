module assertions(pclk,presetn,psel,penable,pready,pwrite,paddr,pwdata);

input bit pclk;
input bit presetn;
input bit psel;
input bit penable;
input bit pready;
input bit pwrite;
input bit [31:0] paddr;
input bit [31:0] pwdata;

parameter idle = 2'b00,
          setup = 2'b01,
          enable = 2'b10;

bit [1:0] state;

//Ensure psel is stable until penable is asserted
property ppt1;
    @(posedge pclk) disable iff(!presetn) 
    (psel && !penable) |=> $stable(psel);
endproperty

//Ensure penable is only asserted when psel is high
property ppt2;
    @(posedge pclk) disable iff(!presetn) 
    penable |-> psel;
endproperty

//Ensure pwrite is stable during a transaction
property ppt3;
    @(posedge pclk) disable iff(!presetn) 
    pready |-> $stable(pwrite);
endproperty

//Ensure paddr is stable during a transaction
property ppt4;
    @(posedge pclk) disable iff(!presetn) 
    pready |-> $stable(paddr);
endproperty

//Ensure pwdata is stable during a transaction
property ppt5;
    @(posedge pclk) disable iff(!presetn) 
    pready |-> $stable(pwdata);
endproperty

//Ensure penable is deasserted after transfer completion
property ppt6;
    @(posedge pclk) disable iff(!presetn) 
    pready |=> !penable;
endproperty

//Ensure pready is not high in IDLE state
property ppt7;
    @(posedge pclk) 
    (!presetn) || (!psel && !penable) |-> !pready;
endproperty

//Ensure pready is not asserted before penable
property ppt8;
    @(posedge pclk) disable iff(!presetn) 
    penable |-> ~$past(pready,1);
endproperty

/*//State transitions
property idle_2_idle;
    @(posedge pclk) disable iff(!presetn) 
    (state==idle) && (!psel && !penable) |=> $stable(state);
endproperty

property idle_2_setup;
    @(posedge pclk) disable iff(!presetn) 
    (state==idle) && (psel && !penable) |=> (state==setup);
endproperty

property setup_2_setup;
    @(posedge pclk) disable iff(!presetn)
    (state==setup) && (psel && !penable) |=> $stable(state);
endproperty

property setup_2_enable;
    @(posedge pclk) disable iff(!presetn) 
    (state==setup) && (psel && penable) |=> (state==enable);
endproperty

property enable_2_setup;
    @(posedge pclk) disable iff(!presetn) 
    (state==enable) && (psel) |=> (state==setup);
endproperty

property enable_2_idle;
    @(posedge pclk) disable iff(!presetn) 
    (state==enable) && (!psel) |=> (state==idle);
endproperty*/

P1: assert property(ppt1)
        $info("Assertion check is passed for ppt1");
    else
        $error("Assertion check is failed for ppt1");

P2: assert property(ppt2)
        $info("Assertion check is passed for ppt2");
    else
        $error("Assertion check is failed for ppt2");

P3: assert property(ppt3)
        $info("Assertion check is passed for ppt3");
    else
        $error("Assertion check is failed for ppt3");

P4: assert property(ppt4)
        $info("Assertion check is passed for ppt4");
    else
        $error("Assertion check is failed for ppt4");

P5: assert property(ppt5)
        $info("Assertion check is passed for ppt5");
    else
        $error("Assertion check is failed for ppt5");

P6: assert property(ppt6)
        $info("Assertion check is passed for ppt6");
    else
        $error("Assertion check is failed for ppt6");

P7: assert property(ppt7)
        $info("Assertion check is passed for ppt7");
    else
        $error("Assertion check is failed for ppt7");

P8: assert property(ppt8)
        $info("Assertion check is passed for ppt8");
    else
        $error("Assertion check is failed for ppt8");

/*P9: assert property(idle_2_idle)
        $info("Assertion check is passed for idle_2_idle");
    else
        $error("Assertion check is failed for idle_2_idle");

P10: assert property(idle_2_setup)
        $info("Assertion check is passed for idle_2_setup");
    else
        $error("Assertion check is failed for idle_2_setup");

P11: assert property(setup_2_setup)
        $info("Assertion check is passed for setup_2_setup");
    else
        $error("Assertion check is failed for setup_2_setup");

P12: assert property(setup_2_enable)
        $info("Assertion check is passed for setup_2_enable");
    else
        $error("Assertion check is failed for setup_2_enable");

P13: assert property(enable_2_setup)
        $info("Assertion check is passed for enable_2_setup");
    else
        $error("Assertion check is failed for enable_2_setup");

P14: assert property(enable_2_idle)
        $info("Assertion check is passed for enable_2_idle");
    else
        $error("Assertion check is failed for enable_2_idle");
*/

A1: cover property (ppt1);
A2: cover property (ppt2);
A3: cover property (ppt3);
A4: cover property (ppt4);
A5: cover property (ppt5);
A6: cover property (ppt6);
A7: cover property (ppt7);
A8: cover property (ppt8);
/*A9: cover property (idle_2_idle);
A10: cover property (idle_2_setup);
A11: cover property (setup_2_setup);
A12: cover property (setup_2_enable);
A13: cover property (enable_2_setup);
A14: cover property (enable_2_idle);
*/
endmodule
