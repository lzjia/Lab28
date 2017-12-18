`timescale 1ns / 1ps
module mux2to1(y,in0,in1,sel);
	parameter N=1;
	output[N-1:0] y;
	input[N-1:0] in0,in1;
	input sel;
	reg[N-1:0] y;
	//select output by variable sel
	always @(in0 or in1 or sel)
		begin
			if (sel) y=in1;
			else y=in0;
		end
endmodule