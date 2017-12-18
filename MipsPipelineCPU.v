`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ZJU
// Engineer: 
// 
// Create Date:    19:44:48 11/12/2009 
// Design Name: 
// Module Name:    MipsPipelineCPU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MipsPipelineCPU(clk, reset, JumpFlag, Instruction_id, ALU_A, 
                     ALU_B, ALUResult, PC, MemDout_wb,Stall
						//	,DataTest,ControlTest
							);
    input clk;
    input reset;
    output[2:0] JumpFlag;
    output [31:0] Instruction_id;
    output [31:0] ALU_A;
    output [31:0] ALU_B;
    output [31:0] ALUResult;
    output [31:0] PC;
    output [31:0] MemDout_wb;
    output Stall;
//  output[31:0] DataTest;
//  output    ControlTest;
	 
//IF  module
     wire[31:0] Instruction_id;
	 wire PC_IFWrite,J,JR,Z,IF_flush;
	 wire[31:0] JumpAddr,JrAddr,BranchAddr,NextPC_if,Instruction_if;
	 
	assign JumpFlag={JR,J,Z};
	assign IF_flush=Z || J ||JR;

	IF IF(
//input	
	 .clk(clk), 
	 .reset(reset), 
	 .Z(Z), 
	 .J(J), 
	 .JR(JR), 
	 .PC_IFWrite(PC_IFWrite), 
	 .JumpAddr(JumpAddr), 
	 .JrAddr(JrAddr), 
	 .BranchAddr(BranchAddr), 
//  output
	 .Instruction_if(Instruction_if),
	 .PC(PC),
	 .NextPC_if(NextPC_if));
	
	
//ID ARGUMENTS 
	wire[4:0] RtAddr_id,RdAddr_id,RsAddr_id;
    wire  RegWrite_wb,MemRead_ex,MemtoReg_id,RegWrite_id,MemWrite_id;
    wire  MemRead_id,ALUSrcA_id,ALUSrcB_id,RegDst_id,Stall;
    wire[4:0]  RegWriteAddr_wb,RegWriteAddr_ex,ALUCode_id;
    wire[31:0] RegWriteData_wb,Imm_id,Sa_id,RsData_id,RtData_id;

//   IF->ID Register
	wire[31:0] NextPC_id;
	dffre #(.WIDTH(32)) IF_ID_0(
			.d(NextPC_if),
			.en(PC_IFWrite),
			.r(IF_flush||reset),
			.clk(clk),
			.q(NextPC_id)
	);
//	wire[31:0] Instruction_id;
	dffre #(.WIDTH(32)) IF_ID_1(
			.d(Instruction_if),
			.en(PC_IFWrite),
			.r(IF_flush||reset),
			.clk(clk),
			.q(Instruction_id)
	);

     
//  ID Module	
   
    ID  ID (
	    .clk(clk),
		.Instruction_id(Instruction_id), 
		.NextPC_id(NextPC_id), 
		.RegWrite_wb(RegWrite_wb), 
		.RegWriteAddr_wb(RegWriteAddr_wb), 
		.RegWriteData_wb(RegWriteData_wb), 
		.MemRead_ex(MemRead_ex), 
        .RegWriteAddr_ex(RegWriteAddr_ex), 
		.MemtoReg_id(MemtoReg_id), 
		.RegWrite_id(RegWrite_id), 
		.MemWrite_id(MemWrite_id), 
		.MemRead_id(MemRead_id), 
		.ALUCode_id(ALUCode_id), 
		.ALUSrcA_id(ALUSrcA_id), 
		.ALUSrcB_id(ALUSrcB_id), 
		.RegDst_id(RegDst_id), 
		.Stall(Stall), 
		.Z(Z), 
		.J(J), 
		.JR(JR), 
		.PC_IFWrite(PC_IFWrite),  
		.BranchAddr(BranchAddr), 
		.JumpAddr(JumpAddr),
		.JrAddr(JrAddr),
		.Imm_id(Imm_id), 
		.Sa_id(Sa_id), 
		.RsData_id(RsData_id), 
		.RtData_id(RtData_id),
		.RtAddr_id(RtAddr_id),
		.RdAddr_id(RdAddr_id),
		.RsAddr_id(RsAddr_id));

//EX ARGUMENTS
	wire[31:0] ALUResult_mem,ALUResult_ex,MemWriteData_ex;
	wire[4:0] RegWriteAddr_mem;
	wire RegWrite_mem;

//   ID->EX  Register
	wire MemToReg_ex,RegWrite_ex,MemWrite_ex,ALUSrcB_ex,ALUSrcA_ex;
	wire RegDst_ex;
	wire[4:0] ALUCode_ex,RdAddr_ex,RsAddr_ex,RtAddr_ex;
	wire[31:0] Sa_ex,Imm_ex,RsData_ex,RtData_ex;
	ID_EX_DFFR ID_EX_DFFR_1(
		.Stall(Stall||reset),
		.clk(clk),
		.MemtoReg_id(MemtoReg_id),
		.MemToReg_ex(MemToReg_ex),
		.RegWrite_id(RegWrite_id),
		.RegWrite_ex(RegWrite_ex),
		.MemWrite_id(MemWrite_id),
		.MemWrite_ex(MemWrite_ex),
		.MemRead_id(MemRead_id),
		.MemRead_ex(MemRead_ex),
		.ALUCode_id(ALUCode_id),
		.ALUCode_ex(ALUCode_ex),
		.ALUSrcA_id(ALUSrcA_id),
		.ALUSrcA_ex(ALUSrcA_ex),
		.ALUSrcB_id(ALUSrcB_id),
		.ALUSrcB_ex(ALUSrcB_ex),
		.RegDst_id(RegDst_id),
		.RegDst_ex(RegDst_ex),
		.Sa_id(Sa_id),
		.Sa_ex(Sa_ex),
		.Imm_id(Imm_id),
		.Imm_ex(Imm_ex),
		.RdAddr_id(RdAddr_id),
		.RdAddr_ex(RdAddr_ex),
		.RsAddr_id(RsAddr_id),
		.RsAddr_ex(RsAddr_ex),
		.RtAddr_id(RtAddr_id),
		.RtAddr_ex(RtAddr_ex),
		.RsData_id(RsData_id),
		.RsData_ex(RsData_ex),
		.RtData_id(RtData_id),
		.RtData_ex(RtData_ex)
	);


// EX Module	 
 
 EX  EX(
 .RegDst_ex(RegDst_ex), 
 .ALUCode_ex(ALUCode_ex), 
 .ALUSrcA_ex(ALUSrcA_ex), 
 .ALUSrcB_ex(ALUSrcB_ex), 
 .Imm_ex(Imm_ex), 
 .Sa_ex(Sa_ex), 
 .RsAddr_ex(RsAddr_ex), 
 .RtAddr_ex(RtAddr_ex), 
 .RdAddr_ex(RdAddr_ex),
 .RsData_ex(RsData_ex), 
 .RtData_ex(RtData_ex), 
 .RegWriteData_wb(RegWriteData_wb), 
 .ALUResult_mem(ALUResult_mem), 
 .RegWriteAddr_wb(RegWriteAddr_wb), 
 .RegWriteAddr_mem(RegWriteAddr_mem), 
 .RegWrite_wb(RegWrite_wb), 
 .RegWrite_mem(RegWrite_mem), 
 .RegWriteAddr_ex(RegWriteAddr_ex), 
 .ALUResult_ex(ALUResult_ex), 
 .MemWriteData_ex(MemWriteData_ex), 
 .ALU_A(ALU_A), 
 .ALU_B(ALU_B));

assign ALUResult=ALUResult_ex;

//EX->MEM
	wire MemToReg_mem;
	dffr dff_memtoreg_mem(.d(MemToReg_ex),.r(reset),.clk(clk),.q(MemToReg_mem));
	//wire RegWrite_mem;
	dffr dff_regwrite_mem(.d(RegWrite_ex),.r(reset),.clk(clk),.q(RegWrite_mem));
	wire MemWrite_mem;
	dffr dff_memwrite_mem(.d(MemWrite_ex),.r(reset),.clk(clk),.q(MemWrite_mem));
	//wire[31:0] ALUResult_mem
	dffr #(.WIDTH(32)) dff_aluresult_mem(.d(ALUResult_ex),.r(reset),.clk(clk),.q(ALUResult_mem));
	wire[31:0] MemWriteData_mem;
	dffr #(.WIDTH(32)) dff_memwritedata_mem(.d(MemWriteData_ex),.r(reset),.clk(clk),.q(MemWriteData_mem));
	//wire[4:0] RegWriteAddr_mem
	dffr #(.WIDTH(5)) dff_regwriteaddr_mem(.d(RegWriteAddr_ex),.r(reset),.clk(clk),.q(RegWriteAddr_mem));



//MEM Module
	DataRAM   DataRAM(
	.addr(ALUResult_mem[7:2]),
	.clk(clk),
	.din(MemWriteData_mem),
	.dout(MemDout_wb),
	.we(MemWrite_mem));

//MEM->WB
  	//wire RegWrite_wb;
  	dffr dff_regwrite_wb(.d(RegWrite_mem),.r(reset),.clk(clk),.q(RegWrite_wb));
  	wire MemToReg_wb;
  	dffr dff_memtoreg_wb(.d(MemToReg_mem),.r(reset),.clk(clk),.q(MemToReg_wb));
  	wire[31:0] ALUResult_wb;
  	dffr #(.WIDTH(32)) dff_aluresult_wb(.d(ALUResult_mem),.r(reset),.clk(clk),.q(ALUResult_wb));
  	//dffr #(.WIDTH(32)) dff_memdout_wb(.d(),.r(reset),.clk(clk),.q(ALUResult_wb));
  	dffr #(.WIDTH(5)) dff_regwriteaddr_wb(.d(RegWriteAddr_mem),.r(reset),.clk(clk),.q(RegWriteAddr_wb));
  	

//WB
 	assign RegWriteData_wb=MemToReg_wb?MemDout_wb:ALUResult_wb;


endmodule
