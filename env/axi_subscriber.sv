`ifndef SUBSCRIBER
`define SUBSCRIBER
import uvm_pkg::*;
`include "uvm_macros.svh"

class AXI_Subscriber#(int WIDTH=32,SIZE=3) extends uvm_subscriber#(axi_m_Sequence_Item#(WIDTH,SIZE));
  
  `uvm_component_param_utils(AXI_Subscriber#(WIDTH,SIZE))
 
  axi_m_Sequence_Item#(WIDTH,SIZE) tx;
  bit [(WIDTH/8)-1:0] wstrb;
  
  covergroup AXI_cg;
 
    rw_bit_transition : coverpoint tx.RW
                   {
                     bins trans_01 = (0 => 1);
                     bins trans_10 = (1 => 0);
                   }

    AWADDR_write   : coverpoint tx.AWADDR  
                   {
                     bins awaddr_1[10] = {[0:99]};
                     bins awaddr_2 = {[100:$]};
                   }
    ARADDR_read   : coverpoint tx.ARADDR  
                   {
                     bins araddr_1[10] = {[0:99]};
                     bins araddr_2 = {[100:$]};
                   }
    READ_WRITE : coverpoint tx.RW
                   {
                     bins wr = {0};
                     bins rd = {1};  
                   }
    AWID_write : coverpoint tx.AWID
                   {
                     bins awid[3]   = {[0:$]};
                   }
    WID_write  : coverpoint tx.WID
                   {
                     bins wid[3]   = {[0:$]};
                   }
    BID_write  : coverpoint tx.BID
                   {
                     bins bid[3]   = {[0:$]};
                   }
    ARID_read  : coverpoint tx.ARID
                   {
                     bins arid[3]   = {[0:$]};
                   }
    RID_read   : coverpoint tx.RID
                   {
                     bins rid[3]   = {[0:$]};
                   }
    AWSIZE_write : coverpoint tx.AWSIZE
                   {
                     bins awlen[3]   = {[0:$]};
                   }
    ARSIZE_read  : coverpoint tx.ARSIZE
                   {
                     bins arlen[3]   = {[0:$]};
                   }

    AWLEN_write : coverpoint tx.AWLEN;
    ARLEN_read  : coverpoint tx.ARLEN;

    AWBURST_write  : coverpoint tx.AWBURST
                   {
		     bins awburst = {[0:2]};
                     illegal_bins awburst_illegal   = {3};
                   }
    ARBURST_read   : coverpoint tx.ARBURST
                   {
		     bins arburst = {[0:2]};
                     illegal_bins arburst_illegal   = {3};
                   }

  endgroup

  covergroup AXI_WSTRB_cg;
    WSTRB_write  : coverpoint wstrb
                   {
                     bins WSTRB_val[16] = {[0:$]};
                   }
  endgroup

  function new(string name="AXI_Subscriber",uvm_component parent);
    super.new(name,parent);
    AXI_cg = new();
    AXI_WSTRB_cg=new();
  endfunction : new 

  virtual function void write(axi_m_Sequence_Item#(WIDTH,SIZE) t);
    tx = t;
    AXI_cg.sample();
    foreach(tx.WSTRB[i])
    begin
      wstrb=tx.WSTRB[i];
      AXI_WSTRB_cg.sample();
    end
  endfunction
  
endclass









`endif
