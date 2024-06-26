// Copyright (C) 2017  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.


// Generated by Quartus Prime Version 17.1 (Build Build 590 10/25/2017)
// Created on Fri Jun 07 16:22:24 2024

alarm_clock alarm_clock_inst
(
	.clk_1kHz(clk_1kHz_sig) ,	// input  clk_1kHz_sig
	.seconds(seconds_sig) ,	// input [5:0] seconds_sig
	.minutes(minutes_sig) ,	// input [5:0] minutes_sig
	.buzzer(buzzer_sig) ,	// output  buzzer_sig
	.rst(rst_sig) 	// input  rst_sig
);

