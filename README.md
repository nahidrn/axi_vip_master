# Project Title

Verifying a simple ram module using AXI Master/Slave UVM method. 

## Description

Our project aims to test a ram module using UVM method. Ram module is used to perform simple write/read opeartion on a particular address. Here, our ram module acts like a slave dut & we run it by using AXI Master. We generate our inputs from a sequencer. Then we drive our ram module via driver module. Monitor block reads the information of each transactions from the interface and sends them to Scoreboard module. Scoreboard module compares the result and shows us the final result if a successful operation was performed or not.

## Folder Structure

Our folder structure is given below,
```bash
├── top
│   ├── axi_test.sv 
│   └── axi_top.sv
│   └── tb_top.sv
├── rtl
│   └── axi_slave_dut.sv
├── interface
|   └── my_interface.sv
├── env
|   ├── axi_env.sv
│   └── axi_sb.sv
│   └── axi_subscriber.sv
├── agent
|   ├── axi_m_agent.sv
│   └── axi_m_drv.sv
│   └── axi_m_mon.sv
│   └── axi_m_seq.sv
│   └── my_seq_item.sv
│   └── my_sqncr.sv
│   └── axi_s_agent.sv
│   └── axi_s_mon.sv
└── README.md
```

## Getting Started


### Dependencies

To simulate this project we need Xilinx Vivado as our EDA tool. We used the student version 2020.2
 

### Installing

Below we have shown how one can install Xilinx Vivado Webpack. 

1) First one must go to this site at https://www.xilinx.com/support/download.html
2) Now you can download any version (preferably the latest one) according to their own operating system.
3) One must create an account before downloading the EDA.
4) Then by following on screen instructions one can easily install the tool on their machine.
5) For first time run, one need to install gcc,gnn compilers. 


## PREREQUISTE

Before executing the program one must configure the settings of vivado. 

1) We have to type "-L uvm" in the marked area. 

![1](https://user-images.githubusercontent.com/89468502/145795314-a5dae749-bc8d-4f48-98cf-19876e283dda.png)

2) Just like the first one, we have to type "-L uvm" in the marked area.

![2](https://user-images.githubusercontent.com/89468502/145795342-c97461f6-3c38-4ae9-a423-ae2187d64d4f.png)

3) For the last modification we have to type "-testplusarg UVM_TESTNAME=axi_Test -testplusarg UVM_VERBOSITY=UVM_LOW" in the marked area.

![3](https://user-images.githubusercontent.com/89468502/145795363-a403a57e-791c-4ede-8497-cd0cb274bcf1.png)


## Authors

1) Nahid Rahman
2) Md. Shamiul Alam Hriday

## Version History

* 0.1
    * Initial Release: This project only can simulate single fixed-burst operation mode. Currently we are working to simulate multiple incremental & wrapping           burst mode. Will update them as soon as they are functional.   

## Acknowledgments

For our ram DUT we used, https://github.com/alexforencich/verilog-axi/blob/master/rtl/axi_ram.v


