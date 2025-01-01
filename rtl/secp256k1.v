module secp256k1(
    input [255:0] x1,
    input [255:0] y1,
    input [255:0] k, 
    output [255:0] x_result,
    output [255:0] y_result,
    input clk, 
    input reset
);

scalar_multipulcation sm(.x1(x1), .y1(y1), .k(k), .x_output(x_result), .y_output(y_result), .clk(clk), .reset(reset));


endmodule