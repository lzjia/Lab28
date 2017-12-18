`timescale 1ns / 1ps
module Hazard_detectior(
		MemRead_ex,
		RegWriteAddr_ex,
		RsAddr_id,
		RtAddr_id,
		Stall,
		PC_IFWrite
	);
	input MemRead_ex;
	input[4:0] RegWriteAddr_ex,RsAddr_id,RtAddr_id;
	output reg Stall,PC_IFWrite;
	always @(*)
	begin
		if((MemRead_ex==1)&&((RegWriteAddr_ex==RsAddr_id)||(RegWriteAddr_ex==RtAddr_id)))
		begin
			Stall = MemRead_ex&&((RegWriteAddr_ex==RsAddr_id)||(RegWriteAddr_ex==RtAddr_id));
			PC_IFWrite = ~Stall;
		end
	end
endmodule