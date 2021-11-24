`timescale 1ns / 1ps

`ifndef SEQUENCE_ITEM
`define SEQUENCE_ITEM

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_m_Sequence_Item #(
    int WIDTH = 32,
    int SIZE = 3
) extends uvm_sequence_item;

  bit RW = 1;
  logic AWREADY;
  logic AWVALID;
  rand logic [SIZE-2:0] AWBURST;
  rand logic [SIZE-1:0] AWSIZE;
  rand logic [(WIDTH/8)-1:0] AWLEN;
  rand logic [WIDTH-1:0] AWADDR;
  rand logic [(WIDTH/8)-1:0] AWID;

  // DATA WRITE CHANNEL
  logic WREADY;
  logic WVALID;
  logic WLAST;
  rand logic [(WIDTH/8)-1:0] WSTRB;
  rand logic [7:0] WDATA;
  //rand logic	[(WIDTH/8)-1:0]  WID;

  // WRITE RESPONSE CHANNEL
  logic [(WIDTH/8)-1:0] BID;
  logic [SIZE-2:0] BRESP;
  logic BVALID;
  logic BREADY;

  // READ ADDRESS CHANNEL
  logic ARREADY;
  logic ARVALID;
  rand logic [(WIDTH/8)-1:0] ARID;
  rand logic [WIDTH-1:0] ARADDR;
  rand logic [(WIDTH/8)-1:0] ARLEN;
  rand logic [SIZE-1:0] ARSIZE;
  rand logic [SIZE-2:0] ARBURST;

  // READ DATA CHANNEL
  rand logic [(WIDTH/8)-1:0] RID;
  rand logic [7:0] RDATA;
  logic [SIZE-2:0] RRESP;
  logic RLAST;
  logic RVALID;
  logic RREADY;

  `uvm_object_param_utils_begin(axi_m_Sequence_Item#(WIDTH, SIZE))
    `uvm_field_int(AWREADY, UVM_ALL_ON | UVM_NOPRINT | UVM_NOCOMPARE)
    `uvm_field_int(AWVALID, UVM_ALL_ON | UVM_NOPRINT | UVM_NOCOMPARE)
    `uvm_field_int(AWBURST, UVM_ALL_ON)
    `uvm_field_int(AWSIZE, UVM_ALL_ON)
    `uvm_field_int(AWLEN, UVM_ALL_ON)
    `uvm_field_int(AWADDR, UVM_ALL_ON)
    `uvm_field_int(AWID, UVM_ALL_ON)
    `uvm_field_int(RW, UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_field_int(WREADY, UVM_ALL_ON | UVM_NOPRINT | UVM_NOCOMPARE)
    `uvm_field_int(WVALID, UVM_ALL_ON | UVM_NOPRINT | UVM_NOCOMPARE)
    `uvm_field_int(WLAST, UVM_ALL_ON | UVM_NOPRINT | UVM_NOCOMPARE)
    `uvm_field_int(WSTRB, UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_field_int(WDATA, UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_field_int(BID, UVM_ALL_ON)
    `uvm_field_int(BRESP, UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_field_int(BVALID, UVM_ALL_ON | UVM_NOPRINT | UVM_NOCOMPARE)
    `uvm_field_int(BREADY, UVM_ALL_ON | UVM_NOPRINT | UVM_NOCOMPARE)
    `uvm_field_int(ARREADY, UVM_ALL_ON | UVM_NOPRINT | UVM_NOCOMPARE)
    `uvm_field_int(ARVALID, UVM_ALL_ON | UVM_NOPRINT | UVM_NOCOMPARE)
    `uvm_field_int(ARBURST, UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_field_int(ARSIZE, UVM_ALL_ON)
    `uvm_field_int(ARLEN, UVM_ALL_ON)
    `uvm_field_int(ARADDR, UVM_ALL_ON)
    `uvm_field_int(ARID, UVM_ALL_ON)
    `uvm_field_int(RREADY, UVM_ALL_ON | UVM_NOPRINT | UVM_NOCOMPARE)
    `uvm_field_int(RVALID, UVM_ALL_ON | UVM_NOPRINT | UVM_NOCOMPARE)
    `uvm_field_int(RLAST, UVM_ALL_ON | UVM_NOPRINT | UVM_NOCOMPARE)
    `uvm_field_int(RRESP, UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_field_int(RDATA, UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_field_int(RID, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "axi_m_Sequence_Item");
    super.new(name);
  endfunction

endclass

`endif

