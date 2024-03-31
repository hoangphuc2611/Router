`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2024 12:34:52 AM
// Design Name: 
// Module Name: top_router_tb
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

module top_router_tb(
    );
    parameter simulation_cycle = 10;
    bit SystemClock;
    
    initial begin
        SystemClock = 0;
        forever begin
            #(simulation_cycle/2)
                SystemClock = ~SystemClock;
        end
    end
    
    router_io top_io(SystemClock);
    program_test router_test(top_io);
    router dut( .clk        (top_io.clk),
                .reset_n    (top_io.reset_n),
                .din        (top_io.din),
                .frame_n    (top_io.frame_n),
                .valid_n    (top_io.valid_n),
                .dout       (top_io.dout),
                .busy_n     (top_io.busy_n),
                .valido_n   (top_io.valido_n),
                .frameo_n   (top_io.frameo_n)
                );
endmodule : top_router_tb
