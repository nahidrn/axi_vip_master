`timescale 1ns / 1ps
`ifndef AXI_INTERFACE
`define AXI_INTERFACE
import uvm_pkg::*;
`include "uvm_macros.svh"


interface axi_intf #(
    int WIDTH = 32,
    SIZE = 3
) (
    input bit clk,
    reset
);


  logic AWREADY;
  logic AWVALID;
  logic [SIZE-2:0] AWBURST;
  logic [SIZE-1:0] AWSIZE;
  logic [(WIDTH/8)-1:0] AWLEN;
  logic [WIDTH-1:0] AWADDR;
  logic [(WIDTH/8)-1:0] AWID;

  int que_WLEN[$];

  // DATA WRITE CHANNEL
  logic WREADY;
  logic WVALID;
  logic WLAST;
  logic [(WIDTH/8)-1:0] WSTRB;
  logic [WIDTH-1:0] WDATA;
  //logic	[(WIDTH/8)-1:0]	WID;

  // WRITE RESPONSE CHANNEL
  logic [(WIDTH/8)-1:0] BID;
  logic [SIZE-2:0] BRESP;
  logic BVALID;
  logic BREADY;

  // READ ADDRESS CHANNEL
  logic ARVALID;
  logic ARREADY;
  logic [(WIDTH/8)-1:0] ARID;
  logic [WIDTH-1:0] ARADDR;
  logic [(WIDTH/8)-1:0] ARLEN;
  logic [SIZE-1:0] ARSIZE;
  logic [SIZE-2:0] ARBURST;

  // READ DATA CHANNEL
  logic [(WIDTH/8)-1:0] RID;
  logic [WIDTH-1:0] RDATA;
  logic [SIZE-2:0] RRESP;
  logic RLAST;
  logic RVALID;
  logic RREADY;

endinterface

`endif
