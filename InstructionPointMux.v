`timescale 1ns / 1ps
module InstructionPointMux(
    		JRJZ,
    		JumpAddr,
    		BranchAddr,
    		NextPC_if,
    		JrAddr,
    		PC_in
    	);

input[2:0] JRJZ;
input[31:0] JumpAddr;
input[31:0] JrAddr;
input[31:0] NextPC_if;
input[31:0] BranchAddr;
output reg [31:0] PC_in;
always @(*)
	begin
		case(JRJZ)
			3'b000: PC_in = NextPC_if;
			3'b001: PC_in = BranchAddr;
			3'b010: PC_in = JumpAddr;
			3'b100: PC_in = JrAddr;
			default: PC_in = 32'h00000000;
	 endcase
	end

endmodule