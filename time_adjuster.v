module time_adjuster (
    input wire clk,                // 时钟信号
    input wire rst,                // 复位信号
    input wire switch1,            // 拨动开关1（选择时）
    input wire switch2,            // 拨动开关2（选择分）
    input wire switch3,            // 拨动开关3（选择秒）
    input wire switch4,            // 拨动开关4（调整时间）
    inout reg [4:0] hours,        // 调整后的小时
    inout reg [5:0] minutes,      // 调整后的分钟
    inout reg [5:0] seconds,      // 调整后的秒钟
    output reg led_hours,          // LED指示小时选择
    output reg led_minutes,        // LED指示分钟选择
    output reg led_seconds         // LED指示秒钟选择
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        hours <= 0;
        minutes <= 0;
        seconds <= 0;
        led_hours <= 0;
        led_minutes <= 0;
        led_seconds <= 0;
    end else begin
        if (switch1) begin
            led_hours <= 1;
            led_minutes <= 0;
            led_seconds <= 0;
        end else if (switch2) begin
            led_hours <= 0;
            led_minutes <= 1;
            led_seconds <= 0;
        end else if (switch3) begin
            led_hours <= 0;
            led_minutes <= 0;
            led_seconds <= 1;
        end

        if (switch4) begin
            if (led_hours) begin
                hours <= hours + 1;
                if (hours == 24) hours <= 0;
            end else if (led_minutes) begin
                minutes <= minutes + 1;
                if (minutes == 60) minutes <= 0;
            end else if (led_seconds) begin
                seconds <= seconds + 1;
                if (seconds == 60) seconds <= 0;
            end
        end
    end
end

endmodule
