`timescale 1ns / 1ps
module ID_EX_DFFR(
		Stall,
		clk,
		MemtoReg_id,
		MemToReg_ex,
		RegWrite_id,
		RegWrite_ex,
		MemWrite_id,
		MemWrite_ex,
		MemRead_id,
		MemRead_ex,
		ALUCode_id,
		ALUCode_ex,
		ALUSrcA_id,
		ALUSrcA_ex,
		ALUSrcB_id,
		ALUSrcB_ex,
		RegDst_id,
		RegDst_ex,
		Sa_id,
		Sa_ex,
		Imm_id,
		Imm_ex,
		RdAddr_id,
		RdAddr_ex,
		RsAddr_id,
		RsAddr_ex,
		RtAddr_id,
		RtAddr_ex,
		RsData_id,
		RsData_ex,
		RtData_id,
		RtData_ex
	);
	input clk,Stall;
	input MemtoReg_id,RegWrite_id,MemWrite_id,ALUSrcB_id,ALUSrcA_id;
	input RegDst_id,MemRead_id;
	input[4:0] ALUCode_id,RdAddr_id,RsAddr_id,RtAddr_id;
	input[31:0] Sa_id,Imm_id,RsData_id,RtData_id;

	output reg MemToReg_ex,RegWrite_ex,MemWrite_ex,ALUSrcB_ex,ALUSrcA_ex;
	output reg RegDst_ex,MemRead_ex;
	output reg[4:0] ALUCode_ex,RdAddr_ex,RsAddr_ex,RtAddr_ex;
	output reg[31:0] Sa_ex,Imm_ex,RsData_ex,RtData_ex;
	always @(posedge clk)
	begin
		if(Stall)
		begin
			MemToReg_ex = 1'b0;
			RegWrite_ex = 1'b0;
			MemWrite_ex = 1'b0;
			MemRead_ex = 1'b0;
			ALUCode_ex = 5'b00000;
			ALUSrcA_ex = 1'b0;
			ALUSrcB_ex = 1'b0;
			RegDst_ex = 1'b0;
			Sa_ex = 32'h00000000;
			Imm_ex = 32'h00;
			RdAddr_ex = 5'b00000;
			RsAddr_ex = 5'b00000;
			RtAddr_ex = 5'b00000;
			RsData_ex = 32'h00000000;
			RtData_ex = 32'h00000000;
		end
		else 
		begin
			MemToReg_ex = MemtoReg_id;
			RegWrite_ex = RegWrite_id;
			MemWrite_ex = MemWrite_id;
			MemRead_ex = MemRead_id;
			ALUCode_ex = ALUCode_id;
			ALUSrcA_ex = ALUSrcA_id;
			ALUSrcB_ex = ALUSrcB_id;
			RegDst_ex = RegDst_id;
			Sa_ex = Sa_id;
			Imm_ex = Imm_id;
			RdAddr_ex = RdAddr_id;
			RsAddr_ex = RsAddr_id;
			RtAddr_ex = RtAddr_id;
			RsData_ex = RsData_id;
			RtData_ex = RtData_id;
		end
	end
endmodule