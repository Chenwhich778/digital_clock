module clock_divider(
    input wire clk_50MHz,
//    input wire rst,
    output reg clk_1kHz,
    output reg clk_1Hz
);
    reg [15:0] counter_1kHz = 0;
    reg [24:0] counter_1Hz = 0;

    always @(posedge clk_50MHz) begin
//        if (rst) begin
//            counter_1kHz <= 0;
//            clk_1kHz <= 0;
//        end else begin
            if (counter_1kHz == 24_999) begin
                counter_1kHz <= 0;
                clk_1kHz <= ~clk_1kHz;
            end else begin
                counter_1kHz <= counter_1kHz + 1;
            end
//        end
    end

    always @(posedge clk_50MHz) begin
//        if (rst) begin
//            counter_1Hz <= 0;
//            clk_1Hz <= 0;
//        end else begin
            if (counter_1Hz == 24_999_999) begin
                counter_1Hz <= 0;
                clk_1Hz <= ~clk_1Hz;
            end else begin
                counter_1Hz <= counter_1Hz + 1;
            end
//        end
    end
endmodule
