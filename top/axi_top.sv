`timescale 1ns / 1ps

module top;

  bit clk, reset;
  always #5 clk = ~clk;
  axi_intf #(32, 3) intf (
      clk,
      reset
  );

  axi_ram #(
      .DATA_WIDTH(32),
      .ADDR_WIDTH(10),
      .STRB_WIDTH(4),
      .ID_WIDTH(4),
      .PIPELINE_OUTPUT(0)
  ) dut_inst (
      .s_axi_awready(intf.AWREADY),
      .s_axi_awvalid(intf.AWVALID),
      .s_axi_awburst(intf.AWBURST),
      .s_axi_awsize (intf.AWSIZE),
      .s_axi_awlen  (intf.AWLEN),
      .s_axi_awaddr (intf.AWADDR),
      .s_axi_awid   (intf.AWID),
      .rst          (intf.reset),
      .clk          (intf.clk),
      .s_axi_wdata  (intf.WDATA),
      .s_axi_wstrb  (intf.WSTRB),
      .s_axi_wvalid (intf.WVALID),
      .s_axi_wready (intf.WREADY),
      .s_axi_bid    (intf.BID),
      .s_axi_bresp  (intf.BRESP),
      .s_axi_bvalid (intf.BVALID),
      .s_axi_bready (intf.BREADY),
      .s_axi_arid   (intf.ARID),
      .s_axi_araddr (intf.ARADDR),
      .s_axi_arlen  (intf.ARLEN),
      .s_axi_arsize (intf.ARSIZE),
      .s_axi_arburst(intf.ARBURST),
      .s_axi_arvalid(intf.ARVALID),
      .s_axi_arready(intf.ARREADY),
      .s_axi_rid    (intf.RID),
      .s_axi_rdata  (intf.RDATA),
      .s_axi_rresp  (intf.RRESP),
      .s_axi_rlast  (intf.RLAST),
      .s_axi_rvalid (intf.RVALID),
      .s_axi_rready (intf.RREADY),
      .s_axi_wlast  (intf.WLAST)
  );

  initial begin
    clk = 0;
    reset = 1;
    #20 reset = 0;
  end


  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    $display("HR:: In Top Registering Interface");
    uvm_config_db#(virtual axi_intf #(32, 3))::set(uvm_root::get(), "*", "intf", intf);
    $display("HR:: In top Running test");
    run_test("axi_Test");
  end

endmodule
