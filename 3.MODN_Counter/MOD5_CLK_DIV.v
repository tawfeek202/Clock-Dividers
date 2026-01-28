module Mod5_Clk_Div (
    input  i_clk,
    input  i_rst_n,
    output o_clk
);

    // --- 1. The Counter Logic ---
    reg [2:0] counter_r;
    
    always @(posedge i_clk or negedge i_rst_n) begin
        if (!i_rst_n) 
            counter_r <= 0;
        else begin
            if (counter_r == 4) 
                counter_r <= 0;
            else 
                counter_r <= counter_r + 1;
        end
    end

    // --- 2. Create the "Lookahead" Logic ---
    // We want the output High for counts 0 and 1.
    // This wire is purely combinational.
    wire count_is_low = (counter_r < 2); 


    // --- 3. Instantiate Flip-Flops for the Trick ---
    
    wire signal_A; // The standard pulse
    wire signal_B; // The delayed pulse

    // Instance 1: Positive Edge FF (Generates the base pulse)
    DFF INST1(
        .clk   (i_clk),
        .rst_n (i_rst_n),
        .D     (count_is_low),
        .Q     (signal_A)
    );

    // Instance 2: Negative Edge FF (Delays Signal A by 0.5 cycles)
    NDFF inst2 (
        .clk   (i_clk),
        .rst_n (i_rst_n),
        .D     (signal_A), // Input comes from Signal A
        .Q     (signal_B)
    );


    // --- 4. Final Assignment ---
    // Combine them to stretch the pulse
    assign o_clk = signal_A | signal_B;

endmodule