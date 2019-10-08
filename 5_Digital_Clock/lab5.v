`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/06 12:16:19
// Design Name: 
// Module Name: lab5
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module counter_N_bit (clock, reset, load, CE, Dat, Q);
parameter N = 3;
input clock, reset, load, CE;
input [N-1:0] Dat;
output [N-1:0] Q;
reg [N-1:0] Q;
always @ (posedge reset or posedge clock)
if (reset == 1'b1) Q <= 0;
else if (load == 1'b1) Q <= Dat;
else if (CE == 1'b1) Q <= Q + 1;
else Q <= Q;
endmodule



module four_bit_Ring_Counter(clock, reset, Q);
input clock, reset;
output [3:0] Q;
reg [3:0] Q;
reg [1:0] q;
always @ (posedge reset or posedge clock)
if (reset == 1'b1) q <= 0;
else q <= q + 1;
always @ (q)
case(q)
    2'b00: Q<=4'b0111;
    2'b01: Q<=4'b1011;
    2'b10: Q<=4'b1101;
    2'b11: Q<=4'b1110;
    default  Q<=4'b0111;
endcase
endmodule




module ClockDivider1Hz(clock, reset, Clk_1Hz);
input clock, reset;
output reg Clk_1Hz;
reg load; 
wire [8:0] Q;
wire [8:0] Dat;
assign Dat= 9'b000000000;
counter_N_bit #9 UUT(clock, reset, load,1, Dat, Q);
always @ (Q)
if (Q == 9'b111110011) begin
load<=1;
Clk_1Hz<=1;
end
else begin
Clk_1Hz<=0;
load<=0;
end
endmodule



module ClockDivider500Hz(clock, reset, Clk_500Hz);
input clock, reset;
output reg Clk_500Hz;
reg load; 
wire [17:0] Q;
wire [17:0] Dat;
assign  Dat= 18'b000000000000000000;
counter_N_bit #18 UUT(clock, reset, load,1, Dat, Q);
always @ (Q)
if (Q == 18'b110000110100111111) begin
load<=1;
Clk_500Hz<=1;
end
else begin
Clk_500Hz<=0;
load<=0;
end
endmodule



module Timer(Clk_1Hz, reset, Q_L, Q_R);
input Clk_1Hz, reset;
output [3:0] Q_L;
output [3:0] Q_R;
wire [3:0] Dat;
reg load, load2, CE;
assign Dat=4'b0000;
counter_N_bit #4 UUT(Clk_1Hz, reset, load,1, Dat, Q_R);
always @ (Q_R)begin
if (Q_R == 4'b1001) begin
load<=1;
CE<=1;
end
else  begin
load<=0; CE<=0;
end
end
counter_N_bit #4 UUT2 (Clk_1Hz, reset, load2, CE, Dat, Q_L);
always @ (Q_L)begin
if (Q_L == 4'b0101) begin
load2<=CE;
end
else  begin
load2<=0;
end
end
endmodule



module SSDDriver(Q, Cathodes);
input [3:0]Q;
output reg [6:0] Cathodes; 
reg a,b,c,d,e,f,g;
always @(Q) begin 
case (Q) 
0: begin a=0;b=0;c=0;d=0;e=0;f=0;g=1; end
1:  begin a=1;b=0;c=0;d=1; e=1; f=1; g=1; end
2:  begin a=0;b=0;d=0;e=0;g=0;c=1; f=1; end
3:  begin a=0;b=0;c=0;d=0;g=0;e=1; f=1; end
4:  begin a=1;b=0;c=0;g=0;e=1; d=1; f=0; end
5:  begin a=0;c=0;d=0;g=0;f=0;b=1; e=1; end
6:  begin a=0; g=0;b=1;c=0;d=0;e=0;f=0; end
7:  begin a=0;b=0;c=0; d=1; e=1; f=1; g=1; end
8:  begin a=0;b=0;c=0;d=0;e=0;f=0; g=0; end
9:  begin a=0;b=0;c=0;f=0;g=0; d=0; e=1; end
default  begin  a=0;b=0;c=0;d=0;e=0;f=0;g=0; end
endcase 
Cathodes={a,b,c,d,e,f,g};
end
endmodule



module lab5(clock, reset, A1, A2, A3, A4, a,b,c,d,e,f,g );
input clock, reset;
output A1, A2, A3, A4, a,b,c,d,e,f,g;
reg a,b,c,d,e,f,g;
wire A1, A2, A3, A4;
wire [3:0] Q_L; wire [3:0] Q_R;
wire Clk_500Hz, Clk_1Hz;
wire [6:0] Cathodes1;
wire [6:0] Cathodes2;
ClockDivider500Hz C1(clock, reset, Clk_500Hz);
ClockDivider1Hz C2(Clk_500Hz, reset, Clk_1Hz);
four_bit_Ring_Counter A(Clk_500Hz, reset, {A1, A2, A3, A4});
Timer T(Clk_1Hz, reset, Q_L, Q_R);
SSDDriver S1(Q_L, Cathodes1);
SSDDriver S2(Q_R, Cathodes2);
always @({A1, A2, A3, A4}) begin
if ({A1, A2, A3, A4}==4'b0111)
begin
{a,b,c,d,e,f,g}=7'b1111111;
end
else if ({A1, A2, A3, A4}==4'b1011)
begin
{a,b,c,d,e,f,g}=7'b1111111;
end
else if ({A1, A2, A3, A4}==4'b1101) 
begin
{a,b,c,d,e,f,g}= Cathodes1;
end
else if ({A1, A2, A3, A4}==4'b1110) 
begin
{a,b,c,d,e,f,g}= Cathodes2;
end
end
endmodule







