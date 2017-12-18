`timescale 1ns / 1ps
module full_adder(input a,input b,input ci,output s,output co);
	assign s = a^b^ci;//s=a XOR b XOR ci
	assign co = (a&&ci)||(b&&ci)||(a&&b);//co=aci+bci+ab
endmodule