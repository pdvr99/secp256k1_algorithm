'timescale 1ns / 1ps

module tb_scalar_multipulcation; 

    //input signals 
    reg [255:0] x1, y1; 
    reg [255:0] k; 
    reg [255:0] clk; 
    reg [255:0] reset; 

    //output signal 
    wire [255:0] x_out, y_out; 


    scalar_multipulcation uut(.x1(x1), .y1(y1), .k(k), .x_output(x_out), .y_output(y_out), .clk(clk), .reset(reset));

    //Start clock 
    always begin 
        #5 clk = ~clk; //Wait for 5 ns
    end

    initial begin 
        clk = 0; 
        reset = 0; 

        //start reset 
        reset = 1; 
        #10 reset = 0; //After 10 ns reset will be 0 

        //test case 1
        x1 = 256'hA3F9D2B8C6A1F4E2B3A7D1E4F123CB98A1234567890ABCDEFA1234567890F12;
        y1 = 256'h9A3F2D7C8B1E6F4A5C9D2E0F8A7B1C2D3E8F9A123456789ABCDEF0123456789;
        k = 256'h4F2B8D9A5C3F6E1D7A9B0C4D8E6F2A9C0F5A1B7E8D9F3A2C5B7D4A8E1F2C3D;
        #100; //Wait for 100 ns before doing the next case 


        //test case 2 (k = 0)
        k = 256'b0; 
        #100;

        //test case 3 (largest number)
        k = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        #100; 

        $finish;
    end

endmodule


