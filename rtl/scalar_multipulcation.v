module scalar_multipulcation(
    input [255:0] x1,
    input [255:0] y1,
    input [255:0] k,
    output [255:0] x_output,
    output [255:0] y_output,
    input clk, 
    input reset
); 

//P is current point and R is resulting point

reg [255:0] x_curr;
reg [255:0] y_curr;
reg [255:0] x_R; 
reg [255:0] y_R;


reg [7:0] counter;
reg [255:0] k_bit;
reg [255:0] k_reg;


//temporary registers
reg [255:0] r0, r1; 

wire [255:0] x_add, y_add; 

wire [255:0] x_double, y_double; 


//R = R + P
point_add add(.x1(x_curr), .y1(y_curr), .x2(x_R), .y2(y_R), .x3(x_add), .y3(y_add));

//P = 2P
point_double double(.x1(x_curr), .y1(y_curr), .x3(x_double), .y3(y_double));



always @(posedge clk or posedge reset) begin
    if(reset) begin
        x_output <= 256'b0; 
        y_output <= 256'b0; 
        x_R <= 256'b0; 
        y_R <= 256'b0;
        x_curr <= x1; 
        y_curr <= y1; 
        counter <= 8'd255; //b'11111111 = d'255
        k_reg <= k;
    end else if(counter >=  0) begin
        k_bit = k_reg[counter];

        //Double 
        x_curr <= x_double; 
        y_curr <= y_double; 

        //Add
        if(k_bit == 1) begin  
            x_R <= x_add; 
            y_R <= y_add; 
        end
        
        counter <= counter - 1; 
    end
end

always @(*) begin 
    x_output = x_R;
    y_output = y_R; 
end 
        




endmodule