`ifndef SLAVE_AGENT
`define SLAVE_AGENT

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_s_Agent #(
    int WIDTH = 32,
    SIZE = 3
) extends uvm_agent;
  `uvm_component_param_utils(axi_s_Agent#(WIDTH, SIZE))
  axi_s_driver #(WIDTH, SIZE) drv;


  function new(string name = "axi_s_Agent", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv = axi_s_driver#(WIDTH, SIZE)::type_id::create("drv", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
  endfunction : connect_phase

endclass

`endif
