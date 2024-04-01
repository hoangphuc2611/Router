`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2024 02:29:19 PM
// Design Name: 
// Module Name: selector
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


module selector(
    input [3:0] sel,
    input [15:0] in,
    output out
    );
    
    wire [15:0] tri_sel;
    
    decoder4_16 haha(.en(1'b1), .in(sel), .out(tri_sel));
    
    genvar x;
    generate 
        for (x = 0; x < 16; x = x + 1) begin : tri_state
            assign out = (tri_sel[x]) ? in[x] : 1'bZ;
        end
    endgenerate
    
endmodule
