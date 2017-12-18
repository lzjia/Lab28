`timescale 1ns / 1ps
module adder_32bits(input [31:0] a,
	input [31:0] b,
	input ci,
	output[31:0] s,
	output co
	);
	//sum_output 0~3
	wire c3;
	adder_4bits adder_4bits_1(.a(a[3:0]),.b(b[3:0]),.ci(ci),.s(s[3:0]),.co(c3));
	//sum_output 4~7
	wire c71,c70;
	wire[3:0] sum71,sum70;
	adder_4bits adder_4bits_2(.a(a[7:4]),.b(b[7:4]),.ci(1'b1),.s(sum71),.co(c71));
	adder_4bits adder_4bits_3(.a(a[7:4]),.b(b[7:4]),.ci(1'b0),.s(sum70),.co(c70));
	mux2to1 #(.N(4)) mux2to1_1(.y(s[7:4]),.in0(sum70),.in1(sum71),.sel(c3));
	wire c7=(c71&&c3)||(c70);
	//sum_output 8~11
	wire c111,c110;
	wire[3:0] sum111,sum110;
	adder_4bits adder_4bits_111(.a(a[11:8]),.b(b[11:8]),.ci(1'b1),.s(sum111),.co(c111));
	adder_4bits adder_4bits_110(.a(a[11:8]),.b(b[11:8]),.ci(1'b0),.s(sum110),.co(c110));
	mux2to1 #(.N(4)) mux2to1_2(.y(s[11:8]),.in0(sum110),.in1(sum111),.sel(c7));
	wire c11=(c111&&c7)||(c110);
	//sum_output 12~15
	wire c151,c150;
	wire[3:0] sum151,sum150;
	adder_4bits adder_4bits_151(.a(a[15:12]),.b(b[15:12]),.ci(1'b1),.s(sum151),.co(c151));
	adder_4bits adder_4bits_150(.a(a[15:12]),.b(b[15:12]),.ci(1'b0),.s(sum150),.co(c150));
	mux2to1 #(.N(4)) mux2to1_3(.y(s[15:12]),.in0(sum150),.in1(sum151),.sel(c11));
	wire c15=(c151&&c11)||(c150);
	//sum_output 16~19
	wire c191,c190;
	wire[3:0] sum191,sum190;
	adder_4bits adder_4bits_191(.a(a[19:16]),.b(b[19:16]),.ci(1'b1),.s(sum191),.co(c191));
	adder_4bits adder_4bits_190(.a(a[19:16]),.b(b[19:16]),.ci(1'b0),.s(sum190),.co(c190));
	mux2to1 #(.N(4)) mux2to1_4(.y(s[19:16]),.in0(sum190),.in1(sum191),.sel(c15));
	wire c19=(c191&&c15)||(c190);
	//sum_output 20~23
	wire c231,c230;
	wire[3:0] sum231,sum230;
	adder_4bits adder_4bits_231(.a(a[23:20]),.b(b[23:20]),.ci(1'b1),.s(sum231),.co(c231));
	adder_4bits adder_4bits_230(.a(a[23:20]),.b(b[23:20]),.ci(1'b0),.s(sum230),.co(c230));
	mux2to1 #(.N(4)) mux2to1_5(.y(s[23:20]),.in0(sum230),.in1(sum231),.sel(c19));
	wire c23=(c231&&c19)||(c230);
	//sum_output 24~27
	wire c271,c270;
	wire[3:0] sum271,sum270;
	adder_4bits adder_4bits_271(.a(a[27:24]),.b(b[27:24]),.ci(1'b1),.s(sum271),.co(c271));
	adder_4bits adder_4bits_270(.a(a[27:24]),.b(b[27:24]),.ci(1'b0),.s(sum270),.co(c270));
	mux2to1 #(.N(4)) mux2to1_6(.y(s[27:24]),.in0(sum270),.in1(sum271),.sel(c23));
	wire c27=(c271&&c23)||(c270);
	//final output 
	wire c311,c310;
	wire[3:0] sum311,sum310;
	adder_4bits adder_4bits_311(.a(a[31:28]),.b(b[31:28]),.ci(1'b1),.s(sum311),.co(c311));
	adder_4bits adder_4bits_310(.a(a[31:28]),.b(b[31:28]),.ci(1'b0),.s(sum310),.co(c310));
	mux2to1 #(.N(4)) mux2to1_7(.y(s[31:28]),.in0(sum310),.in1(sum311),.sel(c27));
	wire c31=(c311&&c27)||(c310);
	assign co=c31;
endmodule