`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2024 09:50:38 PM
// Design Name: 
// Module Name: decoder4_16
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


module decoder4_16 (
    en, in, out
    );
    input en;
    input [3:0] in;
    output reg [15:0] out;
    
    always @(*) begin
        if (en) begin
            out = 16'b0;
            case (in)
                4'h0: out[0] = 1'b1;
                4'h1: out[1] = 1'b1;
                4'h2: out[2] = 1'b1;
                4'h3: out[3] = 1'b1;
                4'h4: out[4] = 1'b1;
                4'h5: out[5] = 1'b1;
                4'h6: out[6] = 1'b1;
                4'h7: out[7] = 1'b1;
                4'h8: out[8] = 1'b1;
                4'h9: out[9] = 1'b1;
                4'ha: out[10] = 1'b1;
                4'hb: out[11] = 1'b1;
                4'hc: out[12] = 1'b1;
                4'hd: out[13] = 1'b1;
                4'he: out[14] = 1'b1;
                4'hf: out[15] = 1'b1;
                default: out = 16'b0;
            endcase
        end
        else begin
            out = 16'b0;
        end
    end
endmodule
