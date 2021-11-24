`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

`ifndef SLAVE_DRIVER
`define SLAVE_DRIVER

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_s_driver#(int WIDTH=32,SIZE=3) extends uvm_driver#(axi_m_Sequence_Item#(WIDTH,SIZE));

  virtual interface axi_intf#(WIDTH,SIZE)   intf;
 `uvm_component_param_utils(axi_s_driver#(WIDTH,SIZE))

   
  byte unsigned   m_mem[1024];   //4294967296

  axi_m_Sequence_Item#(WIDTH,SIZE) tx;
  

  function new(string name="axi_s_driver",uvm_component parent);
    super.new(name,parent);
    $display("Inside Driver Cons");
    tx=new;    
  endfunction : new 

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase 

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (!uvm_config_db#(virtual interface axi_intf#(WIDTH,SIZE))::get(this, "", "intf", intf))
     `uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".intf"})
  endfunction : connect_phase

  task run_phase(uvm_phase phase);
  phase.raise_objection (phase);
    //fork
      //reset_signals();
      sent_addr_write_trx();
      
    //join_any
  phase.drop_objection(phase);
  endtask : run_phase


task sent_addr_write_trx();
   @(posedge intf.clk);

     intf.AWREADY <= 1'b0;
     
     intf.AWREADY <= 1'b1;
     @(posedge intf.clk);
     
     intf.AWVALID <= 1'b1;

endtask


  
endclass

`endif
