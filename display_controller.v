module display_controller (
    input wire clk_1kHz,          // 1kHz 时钟信号
    input wire clk_1Hz,           // 1Hz 时钟信号
    input wire rst,               // 复位信号
    input wire [4:0] hours,
    input wire [5:0] minutes,
    input wire [5:0] seconds,
    input wire [6:0] year,
    input wire [3:0] month,
    input wire [4:0] day,         
    output reg [7:0] Digitron_Out, // 数码管段选信号
    output reg [5:0] DigitronCS_Out // 数码管片选信号
);

reg [3:0] current_digit;
reg [2:0] display_state; // 当前显示的状态
reg display_mode; // 显示模式，0表示时间，1表示日期
reg [4:0] half_minute_counter;

// 数码管的段选信号定义
parameter _0 = 8'b0011_1111, _1 = 8'b0000_0110, _2 = 8'b0101_1011,
          _3 = 8'b0100_1111, _4 = 8'b0110_0110, _5 = 8'b0110_1101,
          _6 = 8'b0111_1101, _7 = 8'b0000_0111, _8 = 8'b0111_1111,
          _9 = 8'b0110_1111;

// 每秒切换显示模式
always @(posedge clk_1Hz or posedge rst) begin
    if (rst) begin
        half_minute_counter <= 0;
        display_mode <= 0;
    end else begin
        if (half_minute_counter == 29) begin
            half_minute_counter <= 0;
            display_mode <= ~display_mode;
        end else begin
            half_minute_counter <= half_minute_counter + 1;
        end
    end
end
// 切换数码管片选信号，逐个显示各位数字
always @(posedge clk_1kHz or posedge rst) begin
    if (rst) begin
        DigitronCS_Out <= 6'b111111; // 关闭所有数码管
        display_state <= 0;
    end else begin
        case (display_state)
            0: DigitronCS_Out <= 6'b111110; // 数码管 0
            1: DigitronCS_Out <= 6'b111101; // 数码管 1
            2: DigitronCS_Out <= 6'b111011; // 数码管 2
            3: DigitronCS_Out <= 6'b110111; // 数码管 3
            4: DigitronCS_Out <= 6'b101111; // 数码管 4
            5: DigitronCS_Out <= 6'b011111; // 数码管 5
        endcase
        display_state <= display_state + 1;
        if (display_state == 5) begin
            display_state <= 0;
        end
    end
end

// 更新当前显示的数字
always @(*) begin
    if (display_mode == 0) begin
        case (display_state)
            0: current_digit <= seconds % 10;
            1: current_digit <= seconds / 10;
            2: current_digit <= minutes % 10;
            3: current_digit <= minutes / 10;
            4: current_digit <= hours % 10;
            5: current_digit <= hours / 10;
        endcase
    end else begin
        case (display_state)
            0: current_digit <= day % 10;
            1: current_digit <= day / 10;
            2: current_digit <= month % 10;
            3: current_digit <= month / 10;
            4: current_digit <= year % 10;
            5: current_digit <= year / 10;
        endcase
    end
end

// 将数字转换为段选信号
always @(*) begin
    case (current_digit)
        0: Digitron_Out <=(display_state == 2 || display_state == 4)?( _0 | 8'b1000_0000): _0;
        1: Digitron_Out <=(display_state == 2 || display_state == 4)?( _1 | 8'b1000_0000): _1;
        2: Digitron_Out <=(display_state == 2 || display_state == 4)?( _2 | 8'b1000_0000): _2;
        3: Digitron_Out <=(display_state == 2 || display_state == 4)?( _3 | 8'b1000_0000): _3;
        4: Digitron_Out <=(display_state == 2 || display_state == 4)?( _4 | 8'b1000_0000): _4;
        5: Digitron_Out <=(display_state == 2 || display_state == 4)?( _5 | 8'b1000_0000): _5;
        6: Digitron_Out <=(display_state == 2 || display_state == 4)?( _6 | 8'b1000_0000): _6;
        7: Digitron_Out <=(display_state == 2 || display_state == 4)?( _7 | 8'b1000_0000): _7;
        8: Digitron_Out <=(display_state == 2 || display_state == 4)?( _8 | 8'b1000_0000): _8;
        9: Digitron_Out <=(display_state == 2 || display_state == 4)?( _9 | 8'b1000_0000): _9;
        default: Digitron_Out <= 8'b1111_1111; // 默认关闭
    endcase
	 
//  if (display_state == 2 || display_state == 4) begin
//       Digitron_Out <= Digitron_Out | 8'b1000_0000; // 将最高位置1，添加小数点
//    end
end
endmodule

