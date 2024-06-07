module time_counter(
    input wire clk_1Hz,
    input wire rst,
    input wire sw0,
    input wire sw1,
    input wire sw2,
    input wire sw3,
	 input wire sw7,
    output reg led_1,
    output reg led_2,
    output reg led_3,
    output reg day_increment,
    output reg [4:0] hours,
    output reg [5:0] minutes,
    output reg [5:0] seconds
);
always @(posedge clk_1Hz) begin
        if (rst) begin
            hours <= 0;
            minutes <= 0;
            seconds <= 0;
            day_increment <= 0;
        end else if(sw0) begin
            // sw0 激活时，调节时间逻辑
				hours <= hours;
            minutes <= minutes;
            seconds <= seconds;
            if (sw1) begin
                led_1 <= 1;
                seconds <= seconds + 1;
					 if(seconds == 59) seconds <= 0;
            end else begin
                led_1 <= 0;
            end

            if (sw2) begin
                led_2 <= 1;
                minutes <= minutes + 1;
					 if(minutes == 59) minutes <= 0;
            end else begin
                led_2 <= 0;
            end

            if (sw3) begin
                led_3 <= 1;
                hours <= hours + 1;
					 if(hours==23) hours <= 0;
            end else begin
                led_3 <= 0;
            end
		  end
		  else if(sw7) begin
		    hours<=23;
			 minutes<=59;
			 seconds<=50;
		  end
		  else begin
            if (seconds == 59) begin
                seconds <= 0;
                if (minutes == 59) begin
                    minutes <= 0;
                    if (hours == 23) begin
                        hours <= 0;
                        day_increment <= 1;
                    end else begin
                        hours <= hours + 1;
                        day_increment <= 0;
                    end
                end else begin
                    minutes <= minutes + 1;
                    day_increment <= 0;
                end
            end else begin
                seconds <= seconds + 1;
                day_increment <= 0;
            end
        end
		  
    end
endmodule

