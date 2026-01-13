package gpio_pkg;

import uvm_pkg::*;

typedef enum{UVM_ACTIVE,UVM_PASSIVE} uvm_active_passive_enum;

`include "uvm_macros.svh"
`include "ral_reg.sv"
`include "reg_map.sv"
`include "env_config.sv"
`include "apb_trans.sv"
`include "aux_trans.sv"
`include "io_trans.sv"
`include "apb_sequencer.sv"
`include "apb_sequence.sv"
`include "aux_sequencer.sv"
`include "aux_sequence.sv"
`include "io_sequencer.sv"
`include "io_sequence.sv"
`include "apb_driver.sv"
`include "aux_driver.sv"
`include "io_driver.sv"
`include "apb_monitor.sv"
`include "aux_monitor.sv"
`include "io_monitor.sv"
`include "apb_agent.sv"
`include "aux_agent.sv"
`include "io_agent.sv"
`include "scoreboard.sv"
`include "virtual_sequencer.sv"
`include "virtual_sequence.sv"
`include "environment.sv"
`include "test.sv"

endpackage
