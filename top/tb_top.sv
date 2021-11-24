`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2021 11:29:55 AM
// Design Name: 
// Module Name: tb_top
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

import uvm_pkg::*;
`include "uvm_macros.svh"

`define WIDTH 32 
`define SIZE 3

`include "../rtl/axi_slave_dut.sv"
`include "../interface/my_interface.sv"
`include "../agent/my_seq_item.sv"
`include "../agent/my_sqncr.sv"
`include "../agent/axi_m_seq.sv"
`include "../agent/axi_m_drv.sv"
//`include "axi_s_drv.sv"
`include "../agent/axi_m_mon.sv"
`include "../agent/axi_m_agent.sv"
//`include "axi_s_agent.sv"
`include "../env/axi_sb.sv"
//`include "axi_subscriber.sv"
`include "../env/axi_env.sv"
`include "axi_test.sv"
`include "axi_top.sv"





