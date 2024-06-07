module alarm_clock
(
clk_1kHz,seconds,minutes,buzzer,rst
);

input clk_1kHz;
input [5:0]seconds;
input [5:0]minutes;
input rst;
output reg buzzer;

reg b_tf;
reg [30:0]C_b;
reg [2:0]min;
reg [2:0]max;
reg pause;
always@(posedge clk_1kHz)
begin
	if(seconds==0 && minutes==0 && ~rst && b_tf==0)
	begin
		b_tf<=1;
		C_b<=1;
		min<=0;
		max<=0;
		pause<=0;
	end
	else if(b_tf)
	begin
		C_b<=C_b+1'b1;
		if(min<3)
		begin
			if(~pause)
			begin
				buzzer<=~buzzer;
				if(C_b==31'd300)
				begin
					C_b<=1;
					pause<=1;
				end
			end
			else
				if(C_b==31'd200)
				begin
					C_b<=1;
					min<=min+1;
					pause<=0;
				end
		end
		else if(C_b==31'd1000)
		begin
			if(max<3)
				max<=max+1;
			else
				b_tf<=0;
			C_b<=1;
			min<=0;
		end
	end
	
end
endmodule
