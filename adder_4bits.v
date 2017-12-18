`timescale 1ns / 1ps
module adder_4bits(input[3:0] a,input[3:0] b,input ci,output[3:0] s,output co);
	wire[3:0] g;
	wire[3:0] p;
	wire[3:0] co1;
	//temporary variable
	assign g = a&b;
	assign p = a|b;
	//caculate c_output
	assign co1[0] = g[0]||(p[0]&&ci);
	assign co1[1] = g[1]||(p[1]&&co1[0]);
	assign co1[2] = g[2]||(p[2]&&co1[1]);
	assign co1[3] = g[3]||(p[3]&&co1[2]);
	//caculate sum
	assign s[0] = (p[0]&&(~g[0]))^ci;
	assign s[1] = (p[1]&&(~g[1]))^co1[0];
	assign s[2] = (p[2]&&(~g[2]))^co1[1];
	assign s[3] = (p[3]&&(~g[3]))^co1[2];
	assign co = co1[3];
endmodule