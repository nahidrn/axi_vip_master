`timescale 1ns / 1ps

`ifndef AGENT
`define AGENT

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_m_Agent #(
    int WIDTH = 32,
    int SIZE = 3
) extends uvm_agent;

  `uvm_component_param_utils(axi_m_Agent#(WIDTH, SIZE))
  
  axi_m_sequencer#(WIDTH, SIZE) seq;
  axi_m_driver #(WIDTH, SIZE) drv;
  axi_m_monitor#(WIDTH,SIZE) mon;


  function new(string name = "axi_m_Agent", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    seq = axi_m_sequencer#(WIDTH, SIZE)::type_id::create("seq", this);
    drv = axi_m_driver#(WIDTH, SIZE)::type_id::create("drv", this);
    mon = axi_m_monitor#(WIDTH,SIZE)::type_id::create("mon", this);

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(seq.seq_item_export);
  endfunction : connect_phase

endclass

`endif
