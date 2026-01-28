module DFF (
    input  D,
    input  clk,
    input  rst,
    output reg Q
);

  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      Q <= 1'b0;
    end else begin
      Q <= D;
    end
  end


endmodule
