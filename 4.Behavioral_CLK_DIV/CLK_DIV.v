module Behavioral_Clk_Div #(
    parameter INPUT_FREQ  = 10_000_000,  // 10 MHz
    parameter TARGET_FREQ = 1_000_000    // 1 MHz (Divide by 10)
) (
    input      i_clk,
    input      i_rst_n,
    output reg o_clk
);

  // Formula: (Input / (2 * Target)) - 1
  // Example for Div-10: (10M / 2M) - 1 = 5 - 1 = 4
  // We count 0,1,2,3,4 (5 ticks) then toggle.
  localparam COUNTER_THRESHOLD = (INPUT_FREQ / (2 * TARGET_FREQ)) - 1;

  // Calculate exact number of bits needed to store the threshold
  localparam COUNTER_WIDTH = $clog2(COUNTER_THRESHOLD + 1);

  reg [COUNTER_WIDTH-1:0] counter_r;

  always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
      counter_r <= 0;
      o_clk     <= 0;
    end else begin
      if (counter_r == COUNTER_THRESHOLD) begin
        o_clk     <= ~o_clk;  // Toggle Output
        counter_r <= 0;  // Reset Counter
      end else begin
        counter_r <= counter_r + 1;
      end
    end
  end

endmodule
