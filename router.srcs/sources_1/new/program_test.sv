`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 08:23:13 PM
// Design Name: 
// Module Name: program_test
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

program automatic program_test(
    router_io.TB rtr_io
    );
    // You need a 'typedef' if you want more than one variable to share the same enumerations.
    enum {IDLE, HEAD, PAD, PAYLOAD} state;    
       
    parameter PACKAGES_NUM = 21;
    // Queue array for PAYLOAD
    logic [31:0] payload_array[$] ;//= 32'hffxxxxx0;
    // Dynamic array for HEADER
    logic [3:0] header_array[];
    // Regsiter to save temporary value for PAYLOAD
    logic [19:0] random_payload;
    logic valid_temp;
    
    integer i, j;
    
    initial begin
        // -- Reset
        reset();
        // -- Initialize
        // Randomize data in package 
        repeat (PACKAGES_NUM) begin
            random_payload = $urandom();
            payload_array.push_front({8'hff, random_payload, 4'h0});
        end
        // Allocate 100 memory locations to "header_array"
        header_array = new[PACKAGES_NUM];
        foreach (header_array[i]) begin
            header_array[i] = $urandom();
        end
        
        // After reset
        for (j = 0; j < PACKAGES_NUM; j = j + 1) begin
            state = HEAD;
            rtr_io.cb.frame_n <= 16'b0;
            // Setting target address
//            for (i = 0; i < 4; i = i + 1) begin
//                rtr_io.cb.din <= 16'b0;
//                @(rtr_io.cb);
//            end
            for (i = 0; i < 16; i = i + 1) begin
                rtr_io.cb.din[i] <= i;
            end
                @(rtr_io.cb);
            for (i = 0; i < 16; i = i + 1) begin
                rtr_io.cb.din[i] <= i >> 1;
            end
                @(rtr_io.cb);
            for (i = 0; i < 16; i = i + 1) begin
                rtr_io.cb.din[i] <= i >> 2;
            end
                @(rtr_io.cb);
            for (i = 0; i < 16; i = i + 1) begin
                rtr_io.cb.din[i] <= i >> 3;
            end
                @(rtr_io.cb);
            
            // Padding
            state = PAD;
            rtr_io.cb.valid_n <= ~('b0);
            rtr_io.cb.din <= ~('b0);
            repeat($urandom_range(1,5)) @(rtr_io.cb); 
            // Sending payload data
            state = PAYLOAD;
            for (i = 0; i < 31; i = i + 1) begin
                rtr_io.cb.din <= {16{payload_array[j][i]}};
                //rtr_io.cb.valid_n[0] <= $urandom();
                valid_temp = $urandom();
                rtr_io.cb.valid_n <= {16{valid_temp}};
                @(rtr_io.cb);
            end
            rtr_io.cb.frame_n <= ~('b0);
            //rtr_io.cb.valid_n[0] <= $urandom();
            valid_temp = $urandom();
            rtr_io.cb.valid_n <= {16{valid_temp}};
            rtr_io.cb.din <= {16{payload_array[j][31]}};
            @(rtr_io.cb);
            rtr_io.cb.valid_n <= ~('b0);
        end
        $stop;
    end
    
    task reset();
        payload_array.delete();
        header_array.delete();
        random_payload = 'b0;
        rtr_io.reset_n = 1'b0;
        rtr_io.cb.frame_n <= ~('b0);
        rtr_io.cb.valid_n <= ~('b0);
        ##2 rtr_io.cb.reset_n <= 1'b1;
        repeat(15) @(rtr_io.cb);
    endtask: reset
endprogram: program_test


//program automatic program_test(
//    router_io.TB rtr_io
//    );
    
//    parameter PACKAGES_NUM = 21;
//    // You need a 'typedef' if you want more than one variable to share the same enumerations.
//    enum {IDLE, HEAD, PAD, PAYLOAD} state;
    
//    bit [3:0] sa; // Source address
//    bit [7:0] da; // Destination address
//    logic [7:0] payload [$]; // Packet data array
  
////    // Queue array for PAYLOAD
////    logic [31:0] payload_array[$:PACKAGES_NUM];
////    // Dynamic array for HEADER
////    logic [3:0] header_array[];
////    // Regsiter to save temporary value for PAYLOAD
////    logic [19:0] random_payload;
    
//    logic [7:0] pkt2cmp_payload[$];
    
//    initial begin
//        reset();
//        repeat (PACKAGES_NUM) begin
//            gen();
//            fork
//                send();
//                recv();
//            join
//            check();
//            //@(rtr_io.cb);
//        end
//    end
    
//    task reset();
//        rtr_io.reset_n = 1'b0;
//        rtr_io.cb.frame_n <= 16'hffff;
//        rtr_io.cb.valid_n <= ~('b0);
//        ##2 rtr_io.cb.reset_n <= 1'b1;
//        repeat(15) @(rtr_io.cb);
//    endtask: reset
    
//    task gen();
//        sa = 3;
//        da = 7;
//        payload.delete();
//        repeat($urandom_range(2,4))
//            payload.push_back($urandom());
//    endtask : gen
    
//    task send();
//        send_address();
//        send_pad();
//        send_payloaf();
//    endtask : send
    
//    task send_address();
    
//    endtask : send_address
    
//    task send_pad();
    
//    endtask : send_pad
    
//    task send_payload();
    
//    endtask : send_payload
    
//    task recv();
//        get_payload();
//    endtask : recv
    
//    task check();
//        compare();
//    endtask : check
    
//    task get_payload();
//        @(negedge rtr_io.cb.frameo_n[da]);
//    endtask : get_payload
    
//    function compare();
//        return 0;
//    endfunction : compare
    
    
    
//endprogram: program_test

//    integer i, j;
    
//    initial begin
//        // -- Initialize
//        // Randomize data in package array
//        repeat (PACKAGES_NUM) begin
//            random_payload = $urandom();
//            payload_array.push_front({8'hff, random_payload, 4'h0});
//        end
//        // Allocate 100 memory locations to "header_array"
//        header_array = new[PACKAGES_NUM];
//        foreach (header_array[i]) begin
//            header_array[i] = $urandom();
//        end
        
//        // -- Reset
//        reset();
//        // After reset
//        for (j = 0; j < PACKAGES_NUM; j = j + 1) begin
//            state = HEAD;
//            rtr_io.cb.frame_n[0] <= 1'b0;
//            // Setting target address
//            for (i = 0; i < 4; i = i + 1) begin
//                rtr_io.cb.din[0] <= 1'b0;
//                @(rtr_io.cb);
//            end
//            // Padding
//            state = PAD;
//            rtr_io.cb.valid_n[0] <= 1'b1;
//            rtr_io.cb.din[0] <= 1'b1;
//            repeat($urandom_range(1,5)) @(rtr_io.cb); 
//            // Sending payload data
//            state = PAYLOAD;
//            for (i = 0; i < 31; i = i + 1) begin
//                rtr_io.cb.din[0] <= payload_array[j][i];
//                rtr_io.cb.valid_n[0] <= $urandom();
//                @(rtr_io.cb);
//            end
//            rtr_io.cb.frame_n[0] <= 1'b1;
//            rtr_io.cb.valid_n[0] <= $urandom();
//            rtr_io.cb.din[0] <= payload_array[j][31];
//            @(rtr_io.cb);
//            rtr_io.cb.valid_n[0] <= 1'b1;
//        end
//        $stop;
//    end