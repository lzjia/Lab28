`timescale 1ns / 1ps
module ALU_MUX(
	ALU_CODE,
	result0,
	result_and,
	result_xor,
	result_or,
	result_nor,
	result_andi,
	result_xori,
	result_ori,
	result_sll,
	result_srl,
	result_sra,
	result_slt,
	result_sltu,
	ALU_RESULT
	);
  input[4:0] ALU_CODE;
	input[31:0] result0;
	input[31:0] result_and;
	input[31:0] result_xor;
	input[31:0] result_or;
	input[31:0] result_nor;
	input[31:0] result_andi;
	input[31:0] result_xori;
	input[31:0] result_ori;
	input[31:0] result_sll;
	input[31:0] result_srl;
	input[31:0] result_sra;
	input[31:0] result_slt;
	input[31:0] result_sltu;
	output reg[31:0] ALU_RESULT;
	parameter	 alu_add=  5'b00000;
	parameter	 alu_and=  5'b00001;
	parameter	 alu_xor=  5'b00010;
	parameter	 alu_or =  5'b00011;
	parameter	 alu_nor=  5'b00100;
	parameter	 alu_sub=  5'b00101;
	parameter	 alu_andi= 5'b00110;
	parameter	 alu_xori= 5'b00111;
	parameter	 alu_ori = 5'b01000;
	//parameter    alu_jr =  5'b01001;
	//parameter	 alu_beq=  5'b01010;
	//parameter	 alu_bne=  5'b01011;
	//parameter	 alu_bgez= 5'b01100;
	//parameter	 alu_bgtz= 5'b01101;
	//parameter	 alu_blez= 5'b01110;
	//parameter	 alu_bltz= 5'b01111;
	parameter 	 alu_sll=  5'b10000;
	parameter	 alu_srl=  5'b10001;
	parameter	 alu_sra=  5'b10010;	
	parameter	 alu_slt=  5'b10011;
	parameter	 alu_sltu= 5'b10100;
	always@(*) 
		begin
			case(ALU_CODE)
				alu_and : ALU_RESULT = result_and;
				alu_sltu: ALU_RESULT = result_sltu;
				alu_slt : ALU_RESULT = result_slt;
				alu_sra : ALU_RESULT = result_sra;
				alu_srl : ALU_RESULT = result_srl;
				alu_sll : ALU_RESULT = result_sll;
				alu_ori : ALU_RESULT = result_ori;
				alu_xori: ALU_RESULT = result_xori;
				alu_andi: ALU_RESULT = result_andi;
				alu_nor : ALU_RESULT = result_nor;
				alu_or  : ALU_RESULT = result_or;
				alu_xor : ALU_RESULT = result_xor;
				alu_add : ALU_RESULT = result0;
				alu_sub : ALU_RESULT = result0;
			endcase
		end	

endmodule