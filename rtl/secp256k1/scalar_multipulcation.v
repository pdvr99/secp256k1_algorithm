module scalar_multipulcation(
    input [255:0] x1,
    input [255:0] y1,
    input [255:0] k,
    output [255:0] x_output,
    input [255:0] y_output
); 

reg [255:0] x_curr, y_curr; 
reg [255:0] x_P, y_P;


reg [7:0] counter;
reg [255:0] k_bit;


//temporary registers
reg [255:0] r0, r1; 

//Q = Q + P
point_add add(.x1(x_curr), .y1(y_curr), .x2(x_P), .y2(y_P), .x3(r0), .y3(r1));
point_add double(.x1(x_P), .y1(y_P), .x3(r0), .y3(r1));



always @(*) begin
    x_output = 256'b0; 
    y_output = 256'b0; 


    for(i = 255; i >= 0; i = i = i-1) begin 
        k_bit = k[i]; 

        //Double (P = 2P)
        double.x1 = x_curr; 
        double.y1 = y_curr; 
        x_P = r0; 
        y_P = r1;


        //Add if current bit in k is 1 (Q = Q + P)
        if(k[i] == 0'b1) begin 
            add.x1 = x_output; 
            add.y1 = y_output; 
            add.x2 = x_P; 
            add.y2 = y_P; 
            x_output = r0; 
            y_output = r1;  
        end
    end
end




endmodule