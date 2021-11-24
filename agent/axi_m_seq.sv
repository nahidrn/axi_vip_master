`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

`ifndef SEQUENCE
`define SEQUENCE

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_m_wr_Sequence #(
    int WIDTH = 32,
    SIZE = 3
) extends uvm_sequence#(axi_m_Sequence_Item#(WIDTH, SIZE));

  `uvm_object_param_utils(axi_m_wr_Sequence#(WIDTH, SIZE))

  function new(string name = "axi_m_wr_Sequence");
    super.new(name);
    $display("m wr seq");
  endfunction

  virtual task body();

    `uvm_create(req)

    //req.AWVALID = 1'b1;
    req.AWBURST.rand_mode(1);  // = 2'b11;
    req.AWSIZE.rand_mode(1);  // = 3'b100;
    req.AWLEN.rand_mode(1);  // = 4'b0101;
    req.AWADDR.rand_mode(1);
    req.AWID.rand_mode(1);  // = 4'b1001;
    req.WSTRB.rand_mode(1);
    req.WDATA.rand_mode(1);


    $display("seq_item class defn");
    req.print();


    $display("m wr seq created with awvalid =%d, awaddr = %d", req.AWVALID, req.AWADDR);
    `uvm_rand_send_with(req, {req.RW==0; })  //Read sequence 
    // previously it was RW=1
    $display("m wr seq sent");

  endtask

endclass

class axi_m_rd_Sequence #(
    int WIDTH = 32,
    SIZE = 3
) extends uvm_sequence#(axi_m_Sequence_Item#(WIDTH, SIZE));

  `uvm_object_param_utils(axi_m_rd_Sequence#(WIDTH, SIZE))

  function new(string name = "axi_m_rd_Sequence");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_create(req)
    req.ARADDR.rand_mode(1);
    req.ARID.rand_mode(1);
    req.ARLEN.rand_mode(1);
    req.ARBURST.rand_mode(1);
    req.ARSIZE.rand_mode(1);
    req.RID.rand_mode(1);
    req.RDATA.rand_mode(1);
    `uvm_rand_send_with(req, {req.RW==1; })  //Read sequence 
    // previously it was RW=0
  endtask
endclass

`endif




