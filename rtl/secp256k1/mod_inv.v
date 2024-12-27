module mod_inv(
    input [255:0] input_num, 
    output reg [255:0] inverse,
    input clk, 
    input reset, 
    input start, 
    output reg done

);


parameter p = 256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F;

reg [1:0] state, next_state; 

//State Machine states
localparam WAIT = 2'b00,
    CALCULATE = 2'b01,
    SUBSITUTE = 2'b10, 
    COMPLETE = 2'b11; 

//registers and coefficients
reg [255:0] a, b; // gcd(a,b)
reg [255:0] c1, c2; // a * c1 + b * c2 = gcd(a,b)

//Temporary Registers 
reg [255:0] r0, r1, r2, r3; //r0 and r1 for a and b. r2 and r3 for c1 and c2


always @(posedge clk or posedge reset) begin 
    if(reset) begin 
        state <= WAIT; 
        done <= 0; 
        inverse <= 256'b0;
        c1 <= 256'b0;
        c2 <= 256'b0;
        a <= 0; 
        b <= 0;
    end else begin 
        state <= next_state; 
    end
end


always @(state or start or a or b or c1 or c2 or r0 or r1 or r2 or r3) begin 
    case(state)
        WAIT: 
        begin 
            if (start) begin 
                a = input_num; 
                b = p; 
                c1 = 256'b1; //Coefficient for a (c1 = 1)
                c2 = 256'b0; //Coefficient for b (c2 = 0)
                next_state = CALCULATE; 
                done = 0; 
            end else begin 
                next_state = WAIT; 
            end
        end

        CALCULATE: 
        begin 
            if (a >= b) begin 
                r0 = a - b; 
                r2 = c1 - c2; 
                next_state = CALCULATE; 
            end else begin 
                r0 = b;
                r1 = a;
                r2 = c2;
                r3 = c1;
                next_state = SUBSITUTE; 
            end
        end

        SUBSITUTE: 
        begin
            a = r0; 
            b = r1; 
            c1 = r2; 
            c2 = r3; 

            if(b == 0) begin
                inverse = c1; 
                done = 1; 
                next_state = DONE; 
            end else begin 
                next_state = COMPUTE; 
            end
        end

        DONE: 
        begin 
            next_state = WAIT; //Reset to WAIT state after finishing
        end

        default: 
        begin 
            next_state = WAIT; 
        end
    endcase
end



endmodule