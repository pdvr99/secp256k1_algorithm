`timescale 1ns / 1ps

module tb_mod_inv(); 

    //input signals 
    reg [255:0] input_num; 
    reg clk; 
    reg reset;
    reg start; 


    //output signals 
    wire [255:0] inverse;
    wire done; 

    mod_inv uut(.input_num(input_num), .inverse(inverse), .clk(clk), .reset(reset), .start(start), .done(done)); 

    always begin 
        #5 clk = ~clk;
    end

    initial begin 
        clk = 0; 
        reset = 0;
        start = 0; 


        reset = 1; 
        #10 
        reset = 0; 
        #10

        //test case
        input_num = 256'hA3F9D2B8C6A1F4E2B3A7D1E4F123CB98A1234567890ABCDEFA1234567890F12;
        start = 1; 
        #100; 

        start = 0; 
        #10;

        if (done) begin 
            $display("Test case has passed. Modular Inverse: %h", inverse);
        end else begin 
            $display("Test case has failed."); 
        end

        $finish; 

    end


endmodule