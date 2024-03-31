`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2024 03:05:16 PM
// Design Name: 
// Module Name: router_io
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


interface router_io(input bit clk);
    logic reset_n;
    logic [15:0] din;
    logic [15:0] frame_n;
    logic [15:0] valid_n;
    logic [15:0] dout;
    logic [15:0] busy_n;
    logic [15:0] valido_n;
    logic [15:0] frameo_n;
    
    default clocking cb @(posedge clk);
        default input #1ns output #1ns;
        output reset_n;
        output din;
        output frame_n;
        output valid_n;
        input dout;
        input busy_n;
        input valido_n;
        input frameo_n;
    endclocking : cb
    
    modport TB(clocking cb, output reset_n);
endinterface : router_io
