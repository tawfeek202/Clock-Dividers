module SYNCH_DIV_CLK (
    input  clk,
    input  rst,
    output SYNCH_DIV_CLK
);
  wire Q0, Q1, Q2;


  DFF D0_inst (
      .D  ((~Q0)),
      .clk(clk),
      .rst(rst),
      .Q  (Q0)
  );

  DFF D1_inst (
      .D  (Q1 ^ Q0),
      .clk(clk),
      .rst(rst),
      .Q  (Q1)
  );

  DFF D2_inst (
      .D  (Q2 & (Q1 & Q0)),
      .clk(clk),
      .rst(rst),
      .Q  (Q2)
  );
  assign SYNCH_DIV_CLK = Q2;

endmodule
