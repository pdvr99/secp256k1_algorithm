module mod_add(
    input [255:0] x, 
    input [255:0] y, 
    output reg [255:0] sum
);

parameter p = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F;


reg [255:0] result; 


always @(*) begin

    result = x + y;  

    if (result >= p) begin 
        result = result - p; //Works because p is prime a = b mod (p) --> a = b
    end

    sum = result; 
end


endmodule