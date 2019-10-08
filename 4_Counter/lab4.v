`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/26 13:30:38
// Design Name: 
// Module Name: lab4
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


module SSD(Q,a,b,c,d,e,f,g);
input [3:0]Q;
output reg a,b,c,d,e,f,g;
always @(Q) begin 
case (Q) 
0: begin a=0;b=0;c=0;d=0;e=0;f=0;g=1; end
1:  begin a=1;b=0;c=0;d=1; e=1; f=1; g=1; end
2:  begin a=0;b=0;d=0;e=0;g=0;c=1; f=1; end
3:  begin a=0;b=0;c=0;d=0;g=0;e=1; f=1; end
4:  begin a=1;b=0;c=0;d=1;e=1;g=0; d=1; f=0; end
5:  begin a=0;c=0;d=0;g=0;f=0;b=1; e=1; end
6:  begin a=0;b=1; g=0;c=0;d=0;e=0;f=0; end
7:  begin a=0;b=0;c=0; d=1; e=1; f=1; g=1; end
8:  begin a=0;b=0;c=0;d=0;e=0;f=0; g=0; end
9:  begin a=0;b=0;c=0;d=0;f=0;g=0; e=1; end
10: begin d=1;a=0;b=0;c=0;g=0;e=0;f=0; end
11: begin a=1; b=1;g=0;c=0;d=0;e=0;f=0; end
12: begin a=0;d=0;e=0; b=1; c=1; f=0;g=1;end
13: begin a=1;b=0;c=0;d=0;e=0;f=1;g=0; end
14: begin b=1; c=1; a=0;g=0;d=0;e=0;f=0; end
15: begin b=1; c=1; d=1;a=0;g=0;e=0;f=0; end
endcase 
end
endmodule



module lab4(clk,upd,reset,Q);
input clk,upd,reset;
output reg [3:0]Q;

always @(posedge clk or posedge reset)
if (reset==1) Q<=4'b0;
else if (upd==1) Q<=Q+1;
else Q<=Q-1;
endmodule

module lab4_all(clk,upd,reset,Q0,Q1,Q2,Q3,a, b, c, d, e, f, g,a0,a1,a2,a3);
input clk, reset, upd; 
output reg a0,a1,a2,a3;
output Q3, Q2, Q1, Q0, a, b, c, d, e, f, g; 
reg Q3, Q2, Q1, Q0;
wire [3:0] Q; 
initial begin
a0=1'b0;
a1=1'b1;
a2=1'b1;
a3=1'b1;
end
SSD S(Q,a,b,c,d,e,f,g);
lab4 L(clk,upd,reset,Q);

always @(Q) begin
Q3=Q[3];
Q2=Q[2];
Q1=Q[1];
Q0=Q[0];
end
endmodule