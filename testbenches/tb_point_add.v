'timescale 1ns / 1ps

module tb_point_add(); 

    //input 
    reg [255:0] x1, y1; 
    reg [255:0] x2, y2;

    reg clk, rest 

    //output
    wire [255:0] x3, y3;

    point_add uut(.x1(x1), .y1(y1), .x2(x2), .y2(y2), .x3(x3), .y3(y3)); 

    always begin 
        #5 clk = ~clk; 
    end

    initial begin
        clk = 0; 
        reset = 0; 

        reset = 1; 
        #10 reset = 0; 

        //Test Case: 
        x1 = 256'hA3F9D2B8C6A1F4E2B3A7D1E4F123CB98A1234567890ABCDEFA1234567890F12;
        y1 = 256'h9A3F2D7C8B1E6F4A5C9D2E0F8A7B1C2D3E8F9A123456789ABCDEF0123456789;
        x2 = 256'hD8A4C3E2F1B7D9E0A1F6C8D2E1F7A3B9C6E2F0A9D5B8C3E9F1A4D0B2A7E4F5;
        y2 = 256'hB4D2A9F8C7E3A6F9B1D2A4C5E6F7A8B1C0E9D3F7A6B8C2D9A4F7C1E9B5A2F3;
        #100;

        $finish;

    end




endmodule; 