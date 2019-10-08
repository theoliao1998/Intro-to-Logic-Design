`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/21 13:28:33
// Design Name: 
// Module Name: lab6sim
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

module KeypadScanner(Clock, reset, OR_row, row, col, code, And, State);
input Clock, reset, OR_row;
input [3:0] row;
output reg And;
output [3:0] col;
output [3:0] code;
output [2:0] State;
reg [3:0] col;
reg [3:0] code;
reg [2:0] State;
initial begin State=3'b000; col=4'b1111;  end
always @(posedge Clock or posedge reset) begin 
if (reset==1) 
begin State<=3'b000; col<=4'b1111; end
else  begin
case (State) 
0:begin  
if (OR_row==0) col<=4'b1111;
else  begin
col<=4'b0001;
State<=3'b001;
end
end 
1:  begin  
if (OR_row==0) begin
col=4'b0010;
State=3'b010;
end
else  begin
case ({row,col}) 
8'b00010001: begin code=4'b0000; end
8'b00010010:begin code=4'b0001; end
8'b00010100:begin code=4'b0010; end
8'b00011000:begin code=4'b0011; end
8'b00100001:begin code=4'b0100; end
8'b00100010:begin code=4'b0101; end
8'b00100100:begin code=4'b0110; end
8'b00101000:begin code=4'b0111; end
8'b01000001:begin code=4'b1000; end
8'b01000010:begin code=4'b1001; end
8'b01000100:begin code=4'b1010; end
8'b01001000:begin code=4'b1011; end
8'b10000001:begin code=4'b1100; end
8'b10000010:begin code=4'b1101; end
8'b10000100:begin code=4'b1110; end
8'b10001000:begin code=4'b1111; end
default  begin  end
endcase 
col=4'b1111;
State=3'b101;
end
end 
2:   begin  
if (OR_row==0) begin
col=4'b0100;
State=3'b011;
end
else  begin
case ({row,col}) 
8'b00010001: begin code=4'b0000; end
8'b00010010:begin code=4'b0001; end
8'b00010100:begin code=4'b0010; end
8'b00011000:begin code=4'b0011; end
8'b00100001:begin code=4'b0100; end
8'b00100010:begin code=4'b0101; end
8'b00100100:begin code=4'b0110; end
8'b00101000:begin code=4'b0111; end
8'b01000001:begin code=4'b1000; end
8'b01000010:begin code=4'b1001; end
8'b01000100:begin code=4'b1010; end
8'b01001000:begin code=4'b1011; end
8'b10000001:begin code=4'b1100; end
8'b10000010:begin code=4'b1101; end
8'b10000100:begin code=4'b1110; end
8'b10001000:begin code=4'b1111; end
default  begin  end
endcase 
col=4'b1111;
State=3'b101;
end
end 
3:  begin  
if (OR_row==0) begin
col=4'b1000;
State=3'b100;
end
else  begin
case ({row,col}) 
8'b00010001: begin code=4'b0000; end
8'b00010010:begin code=4'b0001; end
8'b00010100:begin code=4'b0010; end
8'b00011000:begin code=4'b0011; end
8'b00100001:begin code=4'b0100; end
8'b00100010:begin code=4'b0101; end
8'b00100100:begin code=4'b0110; end
8'b00101000:begin code=4'b0111; end
8'b01000001:begin code=4'b1000; end
8'b01000010:begin code=4'b1001; end
8'b01000100:begin code=4'b1010; end
8'b01001000:begin code=4'b1011; end
8'b10000001:begin code=4'b1100; end
8'b10000010:begin code=4'b1101; end
8'b10000100:begin code=4'b1110; end
8'b10001000:begin code=4'b1111; end
default  begin  end
endcase 
col=4'b1111;
State=3'b101;
end
end 
4: begin  
if (OR_row==0) begin
col=4'b1111;
State=3'b000;
end
else  begin
case ({row,col}) 
8'b00010001: begin code=4'b0000; end
8'b00010010:begin code=4'b0001; end
8'b00010100:begin code=4'b0010; end
8'b00011000:begin code=4'b0011; end
8'b00100001:begin code=4'b0100; end
8'b00100010:begin code=4'b0101; end
8'b00100100:begin code=4'b0110; end
8'b00101000:begin code=4'b0111; end
8'b01000001:begin code=4'b1000; end
8'b01000010:begin code=4'b1001; end
8'b01000100:begin code=4'b1010; end
8'b01001000:begin code=4'b1011; end
8'b10000001:begin code=4'b1100; end
8'b10000010:begin code=4'b1101; end
8'b10000100:begin code=4'b1110; end
8'b10001000:begin code=4'b1111; end
default  begin  end
endcase 
col=4'b1111;
State=3'b101;
end
end 
5:  begin  
if (OR_row==0) begin
col=4'b1111;
State=3'b000;
end
else  begin
col=4'b1111;
State=3'b101;
end
end 
default  begin  
col=4'b1111;
State=3'b000;
end
endcase 
end
end
/*always @(col, row) begin
case ({row,col}) 
8'b00010001: begin code=4'b0000; end
8'b00010010:begin code=4'b0001; end
8'b00010100:begin code=4'b0010; end
8'b00011000:begin code=4'b0011; end
8'b00100001:begin code=4'b0100; end
8'b00100010:begin code=4'b0101; end
8'b00100100:begin code=4'b0110; end
8'b00101000:begin code=4'b0111; end
8'b01000001:begin code=4'b1000; end
8'b01000010:begin code=4'b1001; end
8'b01000100:begin code=4'b1010; end
8'b01001000:begin code=4'b1011; end
8'b10000001:begin code=4'b1100; end
8'b10000010:begin code=4'b1101; end
8'b10000100:begin code=4'b1110; end
8'b10001000:begin code=4'b1111; end
default  begin  end
endcase 
end*/

always @(State)
if (State==3'b101) And=0;
else And=1;
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
10: begin a=0;b=0;c=0; d=1; e=0; f=0;g=0;end
11: begin a=1;b=1;c=0; d=0; e=0; f=0;g=0;end
12: begin a=0;b=1;c=1; d=0; e=0; f=0;g=1;end
13: begin a=1;b=0;c=0; d=0; e=0; f=1;g=0;end
14: begin a=0;b=1;c=1; d=0; e=0; f=0;g=0;end
15: begin a=0;b=1;c=1; d=1; e=0; f=0;g=0;end
default  begin  a=0;b=0;c=0;d=0;e=0;f=0;g=0; end
endcase 
Cathodes={a,b,c,d,e,f,g};
end
endmodule


module lab6_main(row, col, clk, rst, AN, code, LED, State, roww, coll, clock);
input clk, rst;
input [3:0] row;
output [3:0] col;
output [6:0] LED;
output reg [3:0] AN;
output [3:0] code;
output [2:0] State;
output clock;
wire And;
output [3:0]roww;
output [3:0]coll;
reg [3:0]roww;
reg [3:0]coll;
wire OR_row, Clk_500Hz, Clk_1Hz;
ClockDivider C1(clk, rst, clock);
or (OR_row, row[3], row[2], row[1],  row[0]);
KeypadScanner K(clock, rst, OR_row, row, col, code, And, State);
SSDDriver S(code, LED);
always @(And)
if (And==0) AN=4'b1110;
else AN=4'b1111;
always @(row or col) begin
roww=row;
coll=col;
end
endmodule






module lab6_keypad(row, col, key);
    input [3:0] col, key;
    output [3:0] row;

    reg [3:0] row;

    always @ (col or key) begin
      case (key)
        //  ROW 0
        4'b0000: begin
          if (col == 4'b1111) row <= 4'b0001; else
          if (col == 4'b0001) row <= 4'b0001; else row <= 4'b0000;
        end
        4'b0001: begin
          if (col == 4'b1111) row <= 4'b0001; else
          if (col == 4'b0010) row <= 4'b0001; else row <= 4'b0000;
        end
        4'b0010: begin
          if (col == 4'b1111) row <= 4'b0001; else
          if (col == 4'b0100) row <= 4'b0001; else row <= 4'b0000;
        end
        4'b0011: begin
          if (col == 4'b1111) row <= 4'b0001; else
          if (col == 4'b1000) row <= 4'b0001; else row <= 4'b0000;
        end
        //  ROW 1
        4'b0100: begin
          if (col == 4'b1111) row <= 4'b0010; else
          if (col == 4'b0001) row <= 4'b0010; else row <= 4'b0000;
        end
        4'b0101: begin
          if (col == 4'b1111) row <= 4'b0010; else
          if (col == 4'b0010) row <= 4'b0010; else row <= 4'b0000;
        end
        4'b0110: begin
          if (col == 4'b1111) row <= 4'b0010; else
          if (col == 4'b0100) row <= 4'b0010; else row <= 4'b0000;
        end
        4'b0111: begin
          if (col == 4'b1111) row <= 4'b0010; else
          if (col == 4'b1000) row <= 4'b0010; else row <= 4'b0000;
        end
        //  ROW 2
        4'b1000: begin
          if (col == 4'b1111) row <= 4'b0100; else
          if (col == 4'b0001) row <= 4'b0100; else row <= 4'b0000;
        end
        4'b1001: begin
          if (col == 4'b1111) row <= 4'b0100; else
          if (col == 4'b0010) row <= 4'b0100; else row <= 4'b0000;
        end
        4'b1010: begin
          if (col == 4'b1111) row <= 4'b0100; else
          if (col == 4'b0100) row <= 4'b0100; else row <= 4'b0000;
        end
        4'b1011: begin
          if (col == 4'b1111) row <= 4'b0100; else
          if (col == 4'b1000) row <= 4'b0100; else row <= 4'b0000;
        end
        //  ROW 3
        4'b1100: begin
          if (col == 4'b1111) row <= 4'b1000; else
          if (col == 4'b0001) row <= 4'b1000; else row <= 4'b0000;
        end
        4'b1101: begin
          if (col == 4'b1111) row <= 4'b1000; else
          if (col == 4'b0010) row <= 4'b1000; else row <= 4'b0000;
        end
        4'b1110: begin
          if (col == 4'b1111) row <= 4'b1000; else
          if (col == 4'b0100) row <= 4'b1000; else row <= 4'b0000;
        end
        4'b1111: begin
          if (col == 4'b1111) row <= 4'b1000; else
          if (col == 4'b1000) row <= 4'b1000; else row <= 4'b0000;
        end
        default: row <= 4'b0000;
      endcase
    end

endmodule



module lab6sim(AN, state, roww, coll, clock, code, clk, rst, key);
    input clk, rst;
    input [3:0] key;
    output clock;
    output [3:0] code, roww, coll, AN;
    output [2:0] state;

    wire [3:0] row, col, AN, roww, coll;
    wire [6:0] LED;
    
    lab6_keypad keypad (row, col, key); // The keypad module
    lab6_main keypad_reader (row, col, clk, rst, AN, code, LED, state, roww, coll, clock); // Your original top module for this lab
endmodule





module counter_N_bit (clock, reset, load, CE, Dat, Q);
parameter N = 3;
input clock, reset, load, CE;
input [N-1:0] Dat;
output [N-1:0] Q;
reg [N-1:0] Q;
initial begin
Q=3'b000;
end
always @ (posedge reset or posedge clock)
if (reset == 1'b1) Q <= 0;
else if (load == 1'b1) Q <= Dat;
else if (CE == 1'b1) Q <= Q + 1;
else Q <= Q;
endmodule


module ClockDivider(clock, reset, Clock);
input clock, reset;
output reg Clock;
reg load; 
wire [2:0] Q;
wire [2:0] Dat;
assign Dat= 3'b0;
counter_N_bit UUT(clock, reset, load,1, Dat, Q);
initial Clock<=0;
always @ (Q)
if (Q == 3'b101) begin
load<=1;
Clock<=~Clock;
end
else begin
load<=0;
end
endmodule













