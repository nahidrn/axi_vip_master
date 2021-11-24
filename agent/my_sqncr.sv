`timescale 1ns / 1ps

`ifndef SEQUENCER
`define SEQUENCER

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_m_sequencer #(
    int WIDTH = 32,
    int SIZE = 3
) extends uvm_sequencer#(axi_m_Sequence_Item#(WIDTH, SIZE));
  `uvm_component_param_utils(axi_m_sequencer#(WIDTH, SIZE))

  function new(string name = "axi_m_sequencer", uvm_component parent);
    super.new(name, parent);
    $display("inside axi m seqncr");
  endfunction : new
endclass

`endif

