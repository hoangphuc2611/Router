`timescale 1ns/100ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2024 12:04:27 AM
// Design Name:
// Module Name: router
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


module router (
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
    reg busy [15:0], busy_temp[15:0];
    reg [3:0] address [15:0];       // Address register for each input gates
    reg [2:0] address_cnt [15:0];   // Address counter for each input gates
    reg [3:0] in_sel [15:0];        // Register for saving which input gate to use for each output gates
    reg [3:0] in_sel_next [15:0];   // Prepare input address
    wire address_flag [15:0];           // Address flag = 1 when done receiving address
    wire [15:0] out_sel_decoder [15:0]; // Output from 16 decoders decoding which output gate to transfer to
    wire [15:0] out_sel_wire [15:0];    // Rearrange for each bus is for 1 output port (previously each bus is for 1 input port)
    wire [3:0] in_sel_wire [15:0];      // 
    
    wire [15:0] dout_t;
    wire [15:0] valido_t;
    wire [15:0] frameo_t;
    
    integer i, j;
    
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            for (i = 0; i < 16; i = i + 1) begin
                //frame0_n[i] <= 1'b1;
                //address_flag[i] <= 1'b0;
                address[i] <= 4'bz;
                address_cnt[i] <= 3'b0;
                in_sel[i] <= 4'bZ;
                in_sel_next[i] <= 4'bz;
                busy[i] <= 1'b0;
                busy_temp[i] <= 1'b0;
            end
        end
        else begin
            // Looping 16 times for each input/output gates
            for (i = 0; i < 16; i = i + 1) begin
                busy_temp[i] <= (out_sel_wire[i] != 16'b0);
                busy[i] <= busy_temp[i];  
                // Shift registers to save address/destination port from din
                if (!frame_n[i] && !address_flag[i]) begin
                    address[i] <= {din[i], address[i][3:1]};
                    address_cnt[i] <= address_cnt[i] + 1;
                end                
                // Register to save selected input port for the MUX
                in_sel_next[i] <= in_sel_wire[i];
                in_sel[i] <= (busy_n[i]) ? in_sel_next[i] : in_sel[i];
            end
        end
    end
    
    
    genvar x;
    generate
        for (x = 0; x < 16; x = x + 1) begin : addr_flag
            assign address_flag[x] = address_cnt[x][2];
        end
        for (x = 0; x < 16; x = x + 1) begin : reset_frame
            always @(frame_n[x]) begin
                // Begin of a package
                // Ending of a package
                if (frame_n[x]) begin
                    address_cnt[x] <= 4'b0;
                    address[x] <= 4'bx;
                end
            end
        end
    
        // Array of decoders to select output port for each input port
        for (x = 0; x < 16; x = x + 1) begin : decoder
            decoder4_16 out_sel_decode(.en(address_flag[x]), .in(address[x]), .out(out_sel_decoder[x]));
        end
        
        for (x = 0; x < 16; x = x + 1) begin : decoder_input_bus
            assign out_sel_wire[x] = {  out_sel_decoder[15][x],
                                        out_sel_decoder[14][x],
                                        out_sel_decoder[13][x],
                                        out_sel_decoder[12][x],
                                        out_sel_decoder[11][x],
                                        out_sel_decoder[10][x],
                                        out_sel_decoder[9][x],
                                        out_sel_decoder[8][x],
                                        out_sel_decoder[7][x],
                                        out_sel_decoder[6][x],
                                        out_sel_decoder[5][x],
                                        out_sel_decoder[4][x],
                                        out_sel_decoder[3][x],
                                        out_sel_decoder[2][x],
                                        out_sel_decoder[1][x],
                                        out_sel_decoder[0][x]};
        end
        
        // Array of modules to choose input port with higher priority and give the address to the MUX
        for (x = 0; x < 16; x = x + 1) begin : priority
            priority_check priority_sel(.en(1'b1), .in(out_sel_wire[x]), .out(in_sel_wire[x]));
        end
        // Data output port
        for (x = 0; x < 16; x = x + 1) begin : data_out
            selector data(.sel(in_sel[x]), .in(din), .out(dout_t[x]));
            assign dout[x] = (busy[x] && valid_n[in_sel[x]]) ? 1'bz : dout_t[x];
        end
        // Valid output port
        for (x = 0; x < 16; x = x + 1) begin : valid_out
            selector valid(.sel(in_sel[x]), .in(valid_n), .out(valido_t[x]));
            assign valido_n[x] = (busy[x]) ? valido_t[x] : 1'b1;
        end
        // Frame output port
        for (x = 0; x < 16; x = x + 1) begin : frame_out
            selector frame(.sel(in_sel[x]), .in(frame_n), .out(frameo_t[x]));
            assign frameo_n[x] = (busy[x]) ? frameo_t[x] : 1'b1;
        end
        // Busy output signal
        for (x = 0; x < 16; x = x + 1) begin : busy_out
            assign busy_n[x] = (~busy[x]);
        end
    endgenerate
endmodule