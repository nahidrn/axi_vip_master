`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2021 05:09:47 PM
// Design Name: 
// Module Name: axi_sb
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


`timescale 1ns / 1ps

`ifndef SCOREBOARDS
`define SCOREBOARDS

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_scoreboard #(
    int WIDTH = 32,
    SIZE = 3
) extends uvm_scoreboard;

  `uvm_component_param_utils(axi_scoreboard#(WIDTH, SIZE))

  uvm_analysis_export #(axi_m_Sequence_Item #(WIDTH, SIZE)) drv2sb_export_drv;  //expected
  uvm_analysis_export #(axi_m_Sequence_Item #(WIDTH, SIZE)) mon2sb_export_mon;  //actual

  uvm_tlm_analysis_fifo #(axi_m_Sequence_Item #(WIDTH, SIZE)) expfifo;
  uvm_tlm_analysis_fifo #(axi_m_Sequence_Item #(WIDTH, SIZE)) actualfifo;

  virtual axi_intf #(WIDTH, SIZE) intf;

  axi_m_Sequence_Item #(WIDTH, SIZE) mon_tx, drv_tx;


  function new(string name = "axi_scoreboard", uvm_component parent);
    super.new(name, parent);
    $display("In Scoreboard Constructor");
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv2sb_export_drv = new("drv2sb_export_drv", this);
    mon2sb_export_mon = new("mon2sb_export_mon", this);
    expfifo = new("expfifo", this);
    actualfifo = new("actualfifo", this);
    mon_tx = new("mon_tx");
    drv_tx = new("drv_tx");
    $display("In Scoreboard build phase");
  endfunction

  function void connect_phase(uvm_phase phase);

    drv2sb_export_drv.connect(expfifo.analysis_export);
    mon2sb_export_mon.connect(actualfifo.analysis_export);
    $display("In Scoreboard Connect phase");
  endfunction

  virtual task run_phase(uvm_phase phase);
    expfifo.get(drv_tx);
    actualfifo.get(mon_tx);
    compare();
    $display("In Scoreboard Run phase");
  endtask

  virtual function void compare();
    $display("In Scoreboard: %d", mon_tx.RDATA);
    if (mon_tx.RDATA === drv_tx.WDATA) begin
      `uvm_info("compare", {"Test: OK!"}, UVM_LOW);
      $display("-------------------------------------------------");
      $display("------ INFO : TEST CASE DATA PASSED ------------------");
      $display("-------------------------------------------------");
    end else begin
      `uvm_info("compare", {"Test: Fail!"}, UVM_LOW);
      $display("---------------------------------------------------");
      $display("------ ERROR : TEST CASE DATA FAILED ------------------");
      $display("---------------------------------------------------");
    end
    $display("In Scoreboard Compare");

    if (mon_tx.AWADDR === drv_tx.ARADDR) begin
      `uvm_info("compare", {"Test: OK!"}, UVM_LOW);
      $display("---------------------------------------------------------");
      $display("------ INFO : TEST CASE ADDRESS PASSED ------------------");
      $display("---------------------------------------------------------");
    end else begin
      `uvm_info("compare", {"Test: Fail!"}, UVM_LOW);
      $display("----------------------------------------------------------");
      $display("------ ERROR : TEST CASE ADDRESS FAILED ------------------");
      $display("----------------------------------------------------------");
    end
    $display("In Scoreboard: %d", mon_tx.ARADDR);
  endfunction

endclass

`endif
