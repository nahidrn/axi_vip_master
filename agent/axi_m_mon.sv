`timescale 1ns / 1ps

`ifndef MASTER_MONITOR
`define MASTER_MONITOR

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_m_monitor#(int WIDTH=32,SIZE=3) extends uvm_monitor;//#(axi_m_Sequence_Item#(WIDTH,SIZE));

    `uvm_component_param_utils(axi_m_monitor#(WIDTH,SIZE))
    virtual axi_intf#(WIDTH,SIZE) intf;
    uvm_analysis_port#(axi_m_Sequence_Item#(WIDTH,SIZE)) mon2sb_port;
    axi_m_Sequence_Item#(WIDTH,SIZE) w_tx;
      
    function new(string name, uvm_component parent);
        super.new(name, parent);
        w_tx = new(); 
        mon2sb_port = new("mon2sb_port",this);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual axi_intf#(WIDTH,SIZE))::get(this, "", "intf", intf))
        `uvm_fatal("NO_VIF","virtual interface not found");
    endfunction
    
    
    virtual task run_phase(uvm_phase phase);
        forever begin
        collect_trans();
        mon2sb_port.write(w_tx);
        end    
    endtask
    
    task collect_trans();
    @(!intf.reset);
    
    @(posedge intf.clk)
    //forever 
    begin
        $display("In forever");
        while (!intf.AWVALID || !intf.AWREADY || !intf.AWID)
            @(posedge intf.clk);
        w_tx.AWADDR = intf.AWADDR;
        w_tx.AWLEN = intf.AWLEN;
        w_tx.AWSIZE = intf. AWSIZE;
        w_tx.AWBURST = intf.AWBURST;
        
        while (!intf.WVALID || !intf.WREADY)
            @(posedge intf.clk);
        w_tx.WDATA = intf.WDATA;
        w_tx.WSTRB = intf.WSTRB;
        w_tx.WLAST = intf.WLAST;
        
        $display("w_tx.ARID =%d",w_tx.ARID);
        while (!intf.ARREADY || !intf.ARVALID || !intf.RREADY || !intf.RVALID)
            @(posedge intf.clk);
        $display("w_tx.ARID =%d",w_tx.ARID);
        w_tx.ARADDR = intf.ARADDR;
        $display("w_tx.ARADDR =%d",w_tx.ARADDR);
        w_tx.ARID = intf.ARID;
        w_tx.ARLEN = intf.ARLEN;
        w_tx.ARSIZE = intf.ARSIZE;
        w_tx.ARBURST = intf.ARBURST;
            
        @(posedge intf.clk)
        while (!intf.RREADY || !intf.RVALID)
            @(posedge intf.clk);
        w_tx.RID = intf.RID;
        w_tx.RDATA = intf.RDATA;
        w_tx.RRESP = intf.RRESP;
        w_tx.RLAST = intf.RLAST;
        
             
    end //forever begin
        $display("FLAG");
        w_tx.print();  
        $display("mon2sb_port's package write complete");
        
    endtask
           
endclass


`endif
