module date_counter(
    input wire rst,
	 input wire day_increment,
	 input wire sw7,
    output reg [6:0] year,
    output reg [3:0] month,
    output reg [4:0] day
);
    always @(posedge day_increment or posedge rst or posedge sw7) begin
        if (rst) begin
            year <= 0;
            month <= 1;
            day <= 1;
        end
		 else if(sw7) begin
		   year<=24;
	      month<=6;
         day<=6;
		end	
		  else begin
            if (day == 31) begin
                day <= 1;
                if (month == 12) begin
                    month <= 1;
                    year <= year + 1;
                end 
					 else begin
                    month <= month + 1;
                end
            end 
				else begin
                day <= day + 1;
            end
        end
    end
endmodule
