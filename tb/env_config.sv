class env_config extends uvm_object;

`uvm_object_utils(env_config)

function new(string name="env_config");
    super.new(name);
endfunction:new

uvm_active_passive_enum is_active;
virtual interface_apb apb_vif;
virtual interface_aux aux_vif;
virtual interface_io io_vif;

bit has_scoreboard;
bit has_virtual_sequencer;
reg_map reg_block_h;

bit t1;
bit t2;

endclass:env_config
