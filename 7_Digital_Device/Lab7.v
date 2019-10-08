`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/04 11:35:29
// Design Name: 
// Module Name: Lab7
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
module Clock_divider_1(clk_500,clk_1);
reg [8:0]counter;
input clk_500;
output clk_1;
reg clk_1;

initial begin
counter<=9'b0;
end

always@(posedge clk_500) begin
if (counter==9'd500)
    begin
        counter<=9'b0;
        clk_1=1;
    end
else
    begin
        counter<=counter+1;
        clk_1=0;
    end
end

endmodule

module Clock_divider_500(clk_100M,clk_500);
reg [17:0]counter;
input clk_100M;
output clk_500;
reg clk_500;

initial begin
counter<=18'b0;
end

always@(posedge clk_100M) begin
if (counter==18'd200000)
    begin
        counter<=18'b0;
        clk_500=1;
    end
else
    begin
        counter<=counter+1;
        clk_500=0;
    end
end

endmodule

module four_bit_Ring_Counter(clock, Q);
input clock;
output [3:0] Q;
reg [3:0] Q;
reg [1:0] q;

initial begin
q<=0;
end

always @ (posedge clock)
 q <= q + 1;

always @ (q)
begin
case(q)
    2'b00: Q<=4'b0111;
    2'b01: Q<=4'b1011;
    2'b10: Q<=4'b1101;
    2'b11: Q<=4'b1110;
    default:  Q<=4'b0111;
endcase
end
endmodule

module SSDDriver(Q, Cathodes);
input [3:0]Q;
output reg [6:0] Cathodes; 
reg a,b,c,d,e,f,g;
always @(Q) begin 
case (Q) 
0:  begin a=0;b=0;c=0;d=0;e=0;f=0;g=1; end
1:  begin a=1;b=0;c=0;d=1; e=1; f=1; g=1; end
2:  begin a=0;b=0;d=0;e=0;g=0;c=1; f=1; end
3:  begin a=0;b=0;c=0;d=0;g=0;e=1; f=1; end
4:  begin a=1;b=0;c=0;g=0;e=1; d=1; f=0; end
5:  begin a=0;c=0;d=0;g=0;f=0;b=1; e=1; end
6:  begin a=0;g=0;b=1;c=0;d=0;e=0;f=0; end
7:  begin a=0;b=0;c=0; d=1; e=1; f=1; g=1; end
8:  begin a=0;b=0;c=0;d=0;e=0;f=0; g=0; end
9:  begin a=0;b=0;c=0;f=0;g=0; d=0; e=1; end
default  begin  a=0;b=0;c=0;d=0;e=0;f=0;g=0; end
endcase 
Cathodes={a,b,c,d,e,f,g};
end
endmodule

module Step1timer(clk_1,Q3,Q2,Q1,Q0,over);
input clk_1;
output [3:0]Q3;
output [3:0]Q2;
output [3:0]Q1;
output [3:0]Q0;
output over;
reg [3:0]Q3;
reg [3:0]Q2;
reg [3:0]Q1;
reg [3:0]Q0;
reg [3:0]state;
reg over;



initial begin
state<=4'b0;
over<=0;
end


always @(posedge clk_1)
begin
if(state==4'd8)
        begin
            over=1;
        end
    else
        begin 
            state<=state+4'd1;
        end
end

always@* begin
case(state)
4'd0:  begin Q3=4'b0101; Q2=4'b0001; Q1=4'b0110; Q0=4'b0011; end
4'd1:  begin Q3=4'b0001; Q2=4'b0110; Q1=4'b0011; Q0=4'b0111; end
4'd2:  begin Q0=4'b0000; Q3=4'b0110; Q2=4'b0011; Q1=4'b0111; end
4'd3:  begin Q1=4'b0000; Q0=4'b1001; Q3=4'b0011; Q2=4'b0111; end
4'd4:  begin Q2=4'b0000; Q1=4'b1001; Q0=4'b0001; Q3=4'b0111; end
4'd5:  begin Q3=4'b0000; Q2=4'b1001; Q1=4'b0001; Q0=4'b0000; end
4'd6:  begin Q0=4'b0000; Q3=4'b1001; Q2=4'b0001; Q1=4'b0000; end
4'd7:  begin Q1=4'b0000; Q0=4'b1000; Q3=4'b0001; Q2=4'b0000; end
4'd8:  begin Q2=4'b0000; Q1=4'b1000; Q0=4'b0101; Q3=4'b0000; end
 default begin Q3=4'b0101; Q2=4'b0001; Q1=4'b0110; Q0=4'b0011; end
    endcase
end


endmodule
















module result(ring,Q,Cathodes);
input [3:0] ring;
input [3:0] Q;
output reg [6:0] Cathodes;
wire [6:0] cathodes;
reg [3:0] q;
always @(Q)begin
if (Q[3]==1) q=~Q+4'b0001;
else q=Q;
end
SSDDriver S(q, cathodes);
always @(ring)begin
case (ring) 
4'b0111: Cathodes=7'b1111111;
4'b1011: Cathodes=7'b1111111;
4'b1101: begin
if (Q[3]==1) Cathodes=7'b1111110;
else Cathodes=7'b1111111;
end
4'b1110: Cathodes=cathodes;
default Cathodes=7'b1111111;
endcase 
end
endmodule




module lab7_second(a,b,c,d,clock,ring,enter,Cathodes,overflow);
input clock,a,b,c,d,enter;
input [3:0] ring;
output [6:0] Cathodes;
output overflow;
reg overflow,aa, A, B, C, D;
reg [4:0] K;
initial begin K=5'b00000; {A,B,C,D}=4'b0000; overflow=0; end
always @(posedge enter)begin
if (enter==1)begin
{A,B,C,D}<=K[3:0];
K<={1'b0,K[3:0]}+{1'b0,a,b,c,d};
aa<=a;
end
end
always @(K)
overflow<=K[4]^(K[3]-aa-A);
result R(ring,K[3:0],Cathodes);
endmodule


























module Step1(clk_100M,A0, A1, A2, A3, a,b,c,d,e,f,g,over,in1,in2,in3,in4,enter,overflow);
input clk_100M;
input enter;
input in1,in2,in3,in4;
output A0, A1, A2, A3;
output a,b,c,d,e,f,g;
output over;
output overflow;
wire A0, A1, A2, A3;
wire clk_500,clk_1;
reg a,b,c,d,e,f,g;
wire [3:0]Q3;
wire [3:0]Q2;
wire [3:0]Q1;
wire [3:0]Q0;
wire [6:0]Cathodes0;
wire [6:0]Cathodes1;
wire [6:0]Cathodes2;
wire [6:0]Cathodes3;
wire [6:0]Cathodes;
wire over;
Clock_divider_500 UUT(clk_100M,clk_500);
Clock_divider_1 UUT1(clk_500,clk_1);
four_bit_Ring_Counter UUT2(clk_500,{A0,A1,A2,A3});
Step1timer UUT7(clk_1,Q3,Q2,Q1,Q0,over);
SSDDriver UUT3(Q0,Cathodes0);
SSDDriver UUT4(Q1,Cathodes1);
SSDDriver UUT5(Q2,Cathodes2);
SSDDriver UUT6(Q3,Cathodes3);
lab7_second UUT8 (in1,in2,in3,in4,clk_500,{A0,A1,A2,A3},enter,Cathodes,overflow);
always @({A0, A1, A2, A3}) begin
if ({A0, A1, A2, A3}==4'b0111)
begin
if (over==0)
begin
{a,b,c,d,e,f,g}=Cathodes3;
end
else {a,b,c,d,e,f,g}=7'b1111111;
end
else if ({A0, A1, A2, A3}==4'b1011)
begin
if (over==0)
begin
{a,b,c,d,e,f,g}=Cathodes2;
end
else {a,b,c,d,e,f,g}=7'b1111111;
end
else if ({A0, A1, A2, A3}==4'b1101) 
begin
if (over==0)
begin
{a,b,c,d,e,f,g}=Cathodes1;
end
else {a,b,c,d,e,f,g}=Cathodes;
end
else if ({A0, A1, A2, A3}==4'b1110) 
begin
if (over==0)
begin
{a,b,c,d,e,f,g}=Cathodes0;
end
else {a,b,c,d,e,f,g}=Cathodes;
end
end




endmodule









