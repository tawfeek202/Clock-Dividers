module Ring_Counter_Div4 (
    input  i_clk,
    input  i_rst_n,
    output o_clk_div4
);

  reg [3:0] q;

  always @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
      q <= 4'b1000;
    end else begin
      q <= {q[0], q[3:1]};
    end
  end


  //Output Logic (50% Duty Cycle)
  // To divide by 4, we want 2 cycles High and 2 cycles Low.
  // 'q' sequence: 1000 -> 0100 -> 0010 -> 0001
  // If we OR q[3] and q[2], we get High for the first two states.
  assign o_clk_div4 = q[3] | q[2];

endmodule
