module N_bit_adder(input1,input2,answer);
parameter N=64;
input [N-1:0] input1,input2;
   output [N-1:0] answer;
   wire  carry_out;
  wire [N-1:0] carry;
   genvar i;

   generate 
   for(i=0;i<N;i=i+1)
     begin: generate_N_bit_Adder
   if(i==0) 
  half_adder f(input1[0],input2[0],answer[0],carry[0]);
   else
  full_adder f(input1[i],input2[i],carry[i-1],answer[i],carry[i]);
     end
  assign carry_out = carry[N-1];
   endgenerate
endmodule 

module half_adder(x,y,s,c);
   input x,y;
   output s,c;
   assign s=x^y;
   assign c=x&y;
endmodule 

module full_adder(x,y,c_in,s,c_out);
   input x,y,c_in;
   output s,c_out;
 assign s = (x^y) ^ c_in;
 assign c_out = (y&c_in)| (x&y) | (x&c_in);
endmodule // full_adder


module uni_shift_64b(op,clk,rst_a, load,sh_ro_lt_rt,ip);
output reg [63:0] op;
input load;
input [1:0] sh_ro_lt_rt;
input [63:0] ip;
input clk, rst_a;
reg [63:0]temp;
N_bit_adder u(
          
          .answer(ip));
always @(posedge clk or posedge rst_a)
begin
if (rst_a)
op = 0;
else
case(load)
1'b1:
begin
temp = ip;

end
1'b0: 
case (sh_ro_lt_rt)
2'b00: op = temp<<1; 
2'b01: op = temp>>1;  
2'b10: op = {temp[62:0],temp[63]}; 
2'b11: op = {temp[0], temp[63:1]}; 

default: $display("Invalid Shift Control Input");
endcase
default: $display("Invalid Load Control Input");
endcase
end

endmodule