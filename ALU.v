//******************************************************************************
// MIPS verilog model
//
// ALU.v
//
// The ALU performs all the arithmetic/logical integer operations 
// specified by the ALUsel from the decoder. 
// 
// verilog written QMJ
// modified by 
// modified by 
//
//******************************************************************************
`timescale 1ns / 1ps
module ALU (
	// Outputs
	Result,overflow,
	// Inputs
	ALUCode, A, B
);

	input [4:0]	ALUCode;				// Operation select
	input [31:0]	A, B;

	output [31:0]	Result;
	output overflow;

//******************************************************************************
// Shift operation: ">>>" will perform an arithmetic shift, but the operand
// must be reg signed
//******************************************************************************
	reg signed [31:0] B_reg;
	
	always @(B) begin
		B_reg = B;
	end

	
// Decoded ALU operation select (ALUsel) signals
	parameter	 alu_add=  5'b00000;
	parameter	 alu_and=  5'b00001;
	parameter	 alu_xor=  5'b00010;
	parameter	 alu_or =  5'b00011;
	parameter	 alu_nor=  5'b00100;
	parameter	 alu_sub=  5'b00101;
	parameter	 alu_andi= 5'b00110;
	parameter	 alu_xori= 5'b00111;
	parameter	 alu_ori = 5'b01000;
	parameter    alu_jr =  5'b01001;
	parameter	 alu_beq=  5'b01010;
	parameter	 alu_bne=  5'b01011;
	parameter	 alu_bgez= 5'b01100;
	parameter	 alu_bgtz= 5'b01101;
	parameter	 alu_blez= 5'b01110;
	parameter	 alu_bltz= 5'b01111;
	parameter 	 alu_sll=  5'b10000;
	parameter	 alu_srl=  5'b10001;
	parameter	 alu_sra=  5'b10010;	
	parameter	 alu_slt=  5'b10011;
	parameter	 alu_sltu= 5'b10100;
//******************************************************************************
// ALU Result datapath
//******************************************************************************
	//add or sub
	wire Binvert;
	assign Binvert=~(ALUCode==alu_add);
	wire[31:0] Result0;
	wire overflow0;
	adder_32bits adder_32bits_0(.a(A[31:0]),.b(B[31:0]^{32{Binvert}}),.ci(Binvert),.s(Result0),.co(overflow0));

	//and
	wire[31:0] Result_and;
	assign Result_and = A&B;

	//xor
	wire[31:0] Result_xor;
	assign Result_xor = A^B;

	//or
	wire[31:0] Result_or;
	assign Result_or = A|B;

	//nor
	wire[31:0] Result_nor;
	assign Result_nor = ~(A|B);

	//andi
	wire[31:0] Result_andi;
	assign Result_andi = A&{16'd0,B[15:0]};

	//xori
	wire[31:0] Result_xori;
	assign Result_xori = A^{16'd0,B[15:0]};

	//ori
	wire[31:0] Result_ori;
	assign Result_ori = A|{16'd0,B[15:0]};

	//sll
	wire[31:0] Result_sll;
	assign Result_sll = B<<A;

	//srl
	wire[31:0] Result_srl;
	assign Result_srl = B>>A;

	//sra
	wire[31:0] Result_sra;
	assign Result_sra = B_reg>>>A;

	//STL
	wire[31:0] Result_stl;
	wire[31:0] sum_sub;
	assign sum_sub = A+(~B)+1;
	assign Result_stl = (A[31]&&(~B[31]))||((A[31]~^B[31])&&sum_sub[31]);

	//STLU
	wire[31:0] Result_stlu;
	assign Result_stlu=A<B?1:0;

	//mux
	ALU_MUX ALU_MUX_1(
			.ALU_CODE(ALUCode),
			.result0(Result0),
			.result_and(Result_and),
			.result_xor(Result_xor),
			.result_or(Result_or),
			.result_nor(Result_nor),
			.result_andi(Result_andi),
			.result_xori(Result_xori),
			.result_ori(Result_ori),
			.result_sll(Result_sll),
			.result_srl(Result_srl),
			.result_sra(Result_sra),
			.result_slt(Result_stl),
			.result_sltu(Result_stlu),
			.ALU_RESULT(Result)
	);
	assign overflow = overflow0;
endmodule