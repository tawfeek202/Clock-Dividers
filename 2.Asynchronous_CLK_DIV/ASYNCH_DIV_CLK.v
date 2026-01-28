module ASYNCH_DIV_CLK (  //divided by 8 CLK divider
    input  clk,
    input  rst,
    output ASYNCH_DIV_CLK
);
  wire Q0, Q1, Q2;
  wire Q0_bar, Q1_bar, Q2_bar;


  DFF INST0 (
      .D(Q0_bar),
      .clk(clk),
      .rst(rst),
      .Q(Q0),
      .Qbar(Q0_bar)
  );
  DFF INST1 (
      .D(Q1_bar),
      .clk(Q0),
      .rst(rst),
      .Q(Q1),
      .Qbar(Q1_bar)
  );

  DFF INST2 (
      .D(Q2_bar),
      .clk(Q1),
      .rst(rst),
      .Q(Q2),
      .Qbar(Q2_bar)
  );
  assign ASYNCH_DIV_CLK = Q2;  //divided by 8

endmodule
