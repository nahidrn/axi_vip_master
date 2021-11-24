`ifndef ENVIRONMENT
`define ENVIRONMENT

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_Environment #(
    int WIDTH = 32,
    SIZE = 3
) extends uvm_env;
  `uvm_component_param_utils(axi_Environment#(WIDTH, SIZE))

  axi_m_Agent #(WIDTH, SIZE) agent_m;
  //axi_s_Agent#(WIDTH,SIZE) agent_s;
  axi_scoreboard #(WIDTH, SIZE) scoreboard;


  function new(string name = "axi_Environment", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent_m = axi_m_Agent#(WIDTH, SIZE)::type_id::create("agent_m", this);
    scoreboard = axi_scoreboard#(WIDTH, SIZE)::type_id::create("scoreboard", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    $display("Inside env connect phaser");

    agent_m.mon.mon2sb_port.connect(scoreboard.mon2sb_export_mon);
    agent_m.drv.drv2sb_port.connect(scoreboard.drv2sb_export_drv);

  endfunction : connect_phase
endclass

`endif

