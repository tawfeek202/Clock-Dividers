module DFF (
    input  wire D,
    input  wire clk,
    input  wire rst,
    output reg  Q,
    output wire Qbar
);

  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      Q <= 1'b0;
    end else begin
      Q <= D;
    end
  end

  assign Qbar = !Q;

endmodule
