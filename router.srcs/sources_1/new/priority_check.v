`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2024 10:06:00 PM
// Design Name: 
// Module Name: priority_check
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module priority_check(
    input en,
    input [15:0] in,
    output reg [4:0] out
    );
//    wire [15:0] sel;
//    assign sel[0] = in[0];
//    assign sel[1] = (~in[0]) & in[1];
//    assign sel[2] = (~in[0]) & (~in[1]) & in[2];
//    assign sel[3] = (~in[0]) & (~in[1]) & (~in[2]) & in[3];
//    assign sel[4] = (~in[0]) & (~in[1]) & (~in[2]) & (~in[3]) & in[4];
//    assign sel[5] = (~in[0]) & (~in[1]) & (~in[2]) & (~in[3]) & (~in[4]) & in[5];
//    assign sel[6] = (~in[0]) & (~in[1]) & (~in[2]) & (~in[3]) & (~in[4]) & (~in[5]) & in[6];
//    assign sel[7] = (~in[0]) & (~in[1]) & (~in[2]) & (~in[3]) & (~in[4]) & (~in[5]) & (~in[6]) & in[7];
//    assign sel[8] = (~in[0]) & (~in[1]) & (~in[2]) & (~in[3]) & (~in[4]) & (~in[5]) & (~in[6]) & (~in[7]) & in[8];
//    assign sel[9] = (~in[0]) & (~in[1]) & (~in[2]) & (~in[3]) & (~in[4]) & (~in[5]) & (~in[6]) & (~in[7]) & (~in[8]) & in[9];
//    assign sel[10] = (~in[0]) & (~in[1]) & (~in[2]) & (~in[3]) & (~in[4]) & (~in[5]) & (~in[6]) & (~in[7]) & (~in[8]) & (~in[9]) & in[10];
//    assign sel[11] = (~in[0]) & (~in[1]) & (~in[2]) & (~in[3]) & (~in[4]) & (~in[5]) & (~in[6]) & (~in[7]) & (~in[8]) & (~in[9]) & (~in[10]) & in[11];
//    assign sel[12] = (~in[0]) & (~in[1]) & (~in[2]) & (~in[3]) & (~in[4]) & (~in[5]) & (~in[6]) & (~in[7]) & (~in[8]) & (~in[9]) & (~in[10]) & (~in[11]) & in[12];
//    assign sel[13] = (~in[0]) & (~in[1]) & (~in[2]) & (~in[3]) & (~in[4]) & (~in[5]) & (~in[6]) & (~in[7]) & (~in[8]) & (~in[9]) & (~in[10]) & (~in[11]) & (~in[12]) & in[13];
//    assign sel[14] = (~in[0]) & (~in[1]) & (~in[2]) & (~in[3]) & (~in[4]) & (~in[5]) & (~in[6]) & (~in[7]) & (~in[8]) & (~in[9]) & (~in[10]) & (~in[11]) & (~in[12]) & (~in[13]) & in[14];
//    assign sel[15] = (~in[0]) & (~in[1]) & (~in[2]) & (~in[3]) & (~in[4]) & (~in[5]) & (~in[6]) & (~in[7]) & (~in[8]) & (~in[9]) & (~in[10]) & (~in[11]) & (~in[12]) & (~in[13]) & (~in[14]) & in[15];
//    always @(*) begin
//        if (en) begin
//            out = in;
//            if (in[0]) out[15:1] = 15'b0;
//            else if (in[1]) out[15:2] = 14'b0;
//            else if (in[2]) out[15:3] = 13'b0;
//            else if (in[3]) out[15:4] = 12'b0;
//            else if (in[4]) out[15:5] = 11'b0;
//            else if (in[5]) out[15:6] = 10'b0;
//            else if (in[6]) out[15:7] = 9'b0;
//            else if (in[7]) out[15:8] = 8'b0;
//            else if (in[8]) out[15:9] = 7'b0;
//            else if (in[9]) out[15:10] = 6'b0;
//            else if (in[10]) out[15:11] = 5'b0;
//            else if (in[11]) out[15:12] = 4'b0;
//            else if (in[12]) out[15:13] = 3'b0;
//            else if (in[13]) out[15:14] = 2'b0;
//            else if (in[14]) out[15] = 1'b0;
//        end
//        else begin
//            out = 16'b0;
//        end
//    end
    always @(*) begin
        if (en) begin
            out = in;
            if (in[0]) out = 4'h0;
            else if (in[1]) out = 4'h1;
            else if (in[2]) out = 4'h2;
            else if (in[3]) out = 4'h3;
            else if (in[4]) out = 4'h4;
            else if (in[5]) out = 4'h5;
            else if (in[6]) out = 4'h6;
            else if (in[7]) out = 4'h7;
            else if (in[8]) out = 4'h8;
            else if (in[9]) out = 4'h9;
            else if (in[10]) out = 4'ha;
            else if (in[11]) out = 4'hb;
            else if (in[12]) out = 4'hc;
            else if (in[13]) out = 4'hd;
            else if (in[14]) out = 4'he;
            else if (in[15]) out = 4'hf;
			else out = 4'bzzzz;
		  end
        else begin
            out = 4'bzzzz;
        end
    end
endmodule
