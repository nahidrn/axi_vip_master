`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2021 12:21:48 PM
// Design Name: 
// Module Name: axi_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`ifndef TEST
`define TEST

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_Test extends uvm_test;

  `uvm_component_utils(axi_Test)

  axi_Environment #(`WIDTH, `SIZE) env;
  axi_m_wr_Sequence #(`WIDTH, `SIZE) seq_m_write;

  function new(string name = "axi_Test", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("HR:: AXI Test is Here");

    env = axi_Environment#(`WIDTH, `SIZE)::type_id::create("env", this);
    seq_m_write = axi_m_wr_Sequence#(`WIDTH, `SIZE)::type_id::create("seq_m_write", this);
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    repeat (5) seq_m_write.start(env.agent_m.seq);
    //      repeat(4) seq_m_read.start(env.agent_m.seq);
    repeat (4) seq_m_write.start(env.agent_m.seq);
    //    repeat(4) seq_m_read.start(env.agent_m.seq);
    repeat (3) seq_m_write.start(env.agent_m.seq);
    //  repeat(3) seq_m_read.start(env.agent_m.seq);
    phase.drop_objection(this);
  endtask

endclass

`endif
