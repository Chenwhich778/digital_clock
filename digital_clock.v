module digital_clock(
    clk_50MHz, // 50MHz时钟输入
    rst, // 复位信号
	 sw0,
	 sw1,
    sw2,
    sw3,
    sw7,	 
	 led_1,
    led_2,
    led_3,
    Digitron_Out, // 数码管段选信号
    DigitronCS_Out, // 数码管片选信号
	 buzzer
	 
);
    input wire clk_50MHz; // 50MHz时钟输入
    input wire rst;     // 复位信号
	 input wire sw0;
    input wire sw1;
    input wire sw2;
    input wire sw3;
	 input wire sw7;
	 output wire buzzer;
	 output wire led_1;
    output wire led_2;
    output wire led_3;
    output wire [7:0] Digitron_Out; // 数码管段选信号
    output wire [5:0] DigitronCS_Out; // 数码管片选信号
	 
    wire clk_1kHz;
    wire clk_1Hz;
    wire [4:0] hours;
    wire [5:0] minutes;
    wire [5:0] seconds;
    wire [6:0] year;
    wire [3:0] month;
    wire [4:0] day;
	 wire day_increment;

clock_divider U1
(
	.clk_50MHz(clk_50MHz) ,	// input  clk_50MHz_sig
//	.rst(rst) ,	// input  rst_sig
	.clk_1kHz(clk_1kHz) ,	// output  clk_1kHz_sig
	.clk_1Hz(clk_1Hz) 	// output  clk_1Hz_sig
);
date_counter U2
(
	.rst(rst) ,	// input  rst_sig
	.sw7(sw7) ,
	.day_increment(day_increment) ,	// input  day_increment_sig
	.year(year) ,	// output [6:0] year_sig
	.month(month) ,	// output [3:0] month_sig
	.day(day) 	// output [4:0] day_sig
);
time_counter U3
(
	.clk_1Hz(clk_1Hz) ,	// input  clk_1Hz_sig
	.rst(rst) ,	// input  rst_sig
	.sw0(sw0) ,	// input  sw0_sig
	.sw1(sw1) ,	// input  sw1_sig
	.sw2(sw2) ,	// input  sw2_sig
	.sw3(sw3) ,	// input  sw3_sig
	.sw7(sw7) ,
	.led_1(led_1) ,	// output  led_1_sig
	.led_2(led_2) ,	// output  led_2_sig
	.led_3(led_3) ,	// output  led_3_sig
	.day_increment(day_increment) ,	// output  day_increment_sig
	.hours(hours) ,	// output [4:0] hours_sig
	.minutes(minutes) ,	// output [5:0] minutes_sig
	.seconds(seconds) 	// output [5:0] seconds_sig
);

display_controller U4
(
	.clk_1kHz(clk_1kHz) ,	// input  clk_1kHz_sig
	.clk_1Hz(clk_1Hz) ,	// input  clk_1Hz_sig
	.rst(rst) ,	// input  rst_sig
	.hours(hours) ,	// input [4:0] hours_sig
	.minutes(minutes) ,	// input [5:0] minutes_sig
	.seconds(seconds) ,	// input [5:0] seconds_sig
	.year(year) ,	// input [6:0] year_sig
	.month(month) ,	// input [3:0] month_sig
	.day(day) ,	// input [4:0] day_sig
	.Digitron_Out(Digitron_Out) ,	// output [7:0] Digitron_Out_sig
	.DigitronCS_Out(DigitronCS_Out) 	// output [5:0] DigitronCS_Out_sig
);

alarm_clock U5
(
	.clk_1kHz(clk_1kHz) ,	// input  clk_1kHz_sig
	.seconds(seconds) ,	// input [5:0] seconds_sig
	.minutes(minutes) ,	// input [5:0] minutes_sig
	.buzzer(buzzer) ,	// output  buzzer_sig
	.rst(rst) 	// input  rst_sig
);

endmodule
