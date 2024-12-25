module point_add (
    input [255:0] x1,
    input [255:0] y1,
    input [255:0] x2,
    input [255:0] y2,
    output [255:0] x3, 
    output [255:0] y3
);

    wire [255:0] lamda; 
    wire [255:0] numerator; 
    wire [255:0] denominator;

    wire [255:0] r0, r1, r2, r3, r4, r5;

    mod_sub y2y1(.x(y2), .y(y1), .difference(numerator));
    mod_sub x2x1(.x(x2), .y(x1), .difference(denominator));

    mod_inv inverse(.input_num(denominator), .inverse(lamda)); 

    mod_mult new_param(.x(numerator), .y(lamda), .product(lamda));

    //x3
    mod_mult x3_param(.x(lamda), .y(lamda), .product(r0));
    mod_sub x3_sub1(.x(r0), .y(x1), .difference(r1)); 
    mod_sub x3_sub2(.x(r1), .y(x2), .difference(x3)); 

    //y3
    mod_sub y3_x1x3(.x(x1), .y(x3), .difference(r2)); 
    mod_mult y3_mult(.x(lamda), .y(r2), .product(r3));
    mod_sub y3_sub(.x(r3), .y(y1), .difference(y3)); 



endmodule