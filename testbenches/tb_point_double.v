`timescale 1ns / 1ps

module tb_point_double(); 

    //input signals 
    reg [255:0] x1, y1; 
    reg clk; 
    reg reset; 

    //output signals 
    wire [255:0] x_out, y_out; 

    point_double uut(.x1(x1), .y1(y1), .x3(x_out), .y3(y_out)); 

    always begin 
        #5 clk = ~clk; 
    end

    initial begin 
        clk = 0; 
        reset = 0; 

        reset = 1; 
        #10 reset = 0; 

        //Test Case 1
        x1 = 256'hA3F9D2B8C6A1F4E2B3A7D1E4F123CB98A1234567890ABCDEFA1234567890F12;
        y1 = 256'h9A3F2D7C8B1E6F4A5C9D2E0F8A7B1C2D3E8F9A123456789ABCDEF0123456789;
        #100; 

        $finish; 
    end


endmodule