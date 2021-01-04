module PC (input clk,reset,stall,
           input [31 :0]     dIn,//next_pc
           output reg [31:0] dOut);//pc
   always @(posedge clk or negedge reset)
     begin
        if(reset==1'b0)
          dOut <= 32'h0000_0000;
        else
          if(!stall)
            dOut <= dIn;
     end
endmodule // PC
