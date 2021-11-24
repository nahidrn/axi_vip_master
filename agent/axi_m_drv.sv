`timescale 1ns / 1ps

`ifndef DRIVER
`define DRIVER

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_m_driver #(
    int WIDTH = 32,
    SIZE = 3
) extends uvm_driver#(axi_m_Sequence_Item#(WIDTH, SIZE));

  `uvm_component_utils_begin(axi_m_driver#(WIDTH, SIZE))
  `uvm_component_utils_end

  virtual interface axi_intf #(WIDTH, SIZE) intf;

  uvm_analysis_port #(axi_m_Sequence_Item #(WIDTH, SIZE)) drv2sb_port;

  // new
  int RW;
  //

  axi_m_Sequence_Item #(WIDTH, SIZE) tx;

  function new(string name = "axi_m_driver", uvm_component parent);
    super.new(name, parent);
    $display("inside m driver construct");
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv2sb_port = new("drv2sb_port", this);
    $display("inside m driver build phase");
  endfunction : build_phase


  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (!uvm_config_db#(virtual interface axi_intf #(WIDTH, SIZE))::get(this, "", "intf", intf))
      `uvm_error("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".intf"})
    $display("inside master driver connect phase");

  endfunction : connect_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    `uvm_info(get_type_name(), "in run phase", UVM_DEBUG)
    $display("inside m driver run phase");
    seq_item_port.get_next_item(req);
    $display("inside m driver run %d", req.AWADDR);

    @(posedge intf.clk) req.RDATA = req.WDATA;
    req.ARADDR = req.AWADDR;
    req.ARLEN = req.AWLEN;
    req.ARSIZE = req.AWSIZE;
    req.ARBURST = req.AWBURST;

    drv2sb_port.write(req);
    seq_item_port.item_done();
    seq_item_port.put(req);


    $display("scoreboard package of driver start");
    req.print();
    $display("scoreboard package of driver print ended");

    fork
      sent_trx_to_seq();
      sent_addr_write_trx();
      sent_data_write_trx();
      received_resp_write();
      sent_addr_read_trx();
    join_any
    $display("inside master driver run end");


  endtask : run_phase

  task sent_trx_to_seq();
    begin
      case (RW)
        0: drv2sb_port.write(req);
        1: `uvm_error("NOTYPE", {"type not support in sent_trx_to_seq Loop"})
      endcase
    end
  endtask

  task sent_addr_write_trx();
    @(!intf.reset) intf.AWVALID <= 1'b0;
    @(posedge intf.clk) begin

      begin

        intf.AWVALID <= 1'b1;
        intf.AWADDR <= req.AWADDR;
        intf.AWBURST <= '0;
        intf.AWSIZE <= req.AWSIZE;
        intf.AWLEN <= 1'b0;
        intf.AWID <= req.AWID;
        while (!intf.AWREADY) @(posedge intf.clk);
        intf.AWVALID <= 1'b0;
        intf.AWBURST <= '0;
        intf.AWSIZE <= '0;
        intf.AWLEN <= '0;
        intf.AWID <= '0;

        sent_data_write_trx();
      end
    end
  endtask

  task sent_data_write_trx();
    @(!intf.reset) intf.WVALID <= 1'bz;
    @(posedge intf.clk) begin
      intf.WVALID <= 1'b1;
      intf.WSTRB <= req.WSTRB;
      intf.WDATA <= req.WDATA;
      intf.WLAST <= 1'b1;
      received_resp_write();

      while (!intf.WREADY) @(posedge intf.clk);
      intf.WVALID <= 1'b0;
      intf.WSTRB <= 1'b0;
      intf.WDATA <= 1'b0;
      intf.WLAST <= 1'b0;
    end
    sent_addr_read_trx();
  endtask

  task received_resp_write();

    @(!intf.reset) begin
      intf.BREADY = 1'b0;

      @(posedge intf.clk) begin

        if (intf.WVALID && intf.WREADY && intf.WLAST) intf.BREADY = 1'b1;

        while (!intf.BVALID)
          @(posedge intf.clk) begin
            intf.BREADY <= 1'b1;
          end
      end
    end
  endtask

  task sent_addr_read_trx();
    @(!intf.reset) intf.ARVALID <= 1'b0;
    //#55
    @(posedge intf.clk) begin
      while (!intf.BVALID) @(posedge intf.clk) intf.ARVALID <= 1'b1;
      intf.ARADDR <= req.AWADDR;
      intf.ARLEN <= 1'b0;
      intf.ARBURST <= 1'b0;
      intf.ARSIZE <= req.AWSIZE;
      intf.ARID <= req.AWID;
      intf.RREADY <= 1'b1;

      while (!intf.ARREADY) @(posedge intf.clk) intf.ARVALID <= 1'b0;
      intf.ARADDR <= 1'b0;
      intf.ARLEN <= 1'b0;
      intf.ARBURST <= 1'b0;
      intf.ARSIZE <= 1'b0;
      intf.ARID <= 1'b0;
    end
  endtask

endclass

`endif



