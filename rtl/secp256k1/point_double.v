module point_double (
    input [255:0] x1,
    input [255:0] y1,
    output [255:0] x3, 
    output [255:0] y3
);

    wire [255:0] lamda;  
    wire [255:0] numerator; 
    wire [255:0] denominator;

    wire [255:0] r0, r1, r2, r3, r4, r5, r6, r7;

    r0 = 256'd3

    mod_mult mult1(.x(r0), .y(x1), product(r1));
    mod_mult mult1(.x(r1), .y(x1), product(r2));

    numerator = r2; 

    mod_inv inverse(.input_num(y1), .inverse(denominator)); 

    mod_mult new_param(.x(numerator), .y(denominator), .product(lamda));

    //x3
    mod_mult x3_mult1(.x(lamda), .y(lamda), .product(r3));
    r4 = 256'd2; 
    mod_mult x3_mult2(.x(r4), .y(x1), .product(r5));
    mod_sub x3_sub(.x(r3), .y(x5), .difference(x3)); 

    //y3
    mod_sub y3_x1x3(.x(x1), .y(x3), .difference(r6)); 
    mod_mult y3_mult(.x(lamda), .y(r6), .product(r7));
    mod_sub y3_sub(.x(r7), .y(y1), .difference(y3)); 



endmodule