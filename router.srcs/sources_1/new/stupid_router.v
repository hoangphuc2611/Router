`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2024 06:43:12 PM
// Design Name: 
// Module Name: stupid_router
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


module stupid_router(
    input clk,
    input reset_n,
    input [15:0] din,
    input [15:0] frame_n,
    input [15:0] valid_n,
    output [15:0] dout,
    output [15:0] busy_n,
    output [15:0] valido_n,
    output [15:0] frameo_n
    );
    
    assign dout = din;
    assign valido_n = valid_n;
    assign frameo_n = frame_n;
    assign busy_n = 16'hffff;
    
endmodule
