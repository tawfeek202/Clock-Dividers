`timescale 1ns / 1ps

module Behavioral_Clk_Div_tb;

  // Parameters
  localparam IN_FREQ = 10_000_000;
  localparam TGT_FREQ = 1_000_000;

  // Signals
  reg  clk;
  reg  rst_n;
  wire o_clk;

  // Instantiate DUT
  Behavioral_Clk_Div #(
      .INPUT_FREQ (IN_FREQ),
      .TARGET_FREQ(TGT_FREQ)
  ) u_dut (
      .i_clk  (clk),
      .i_rst_n(rst_n),
      .o_clk  (o_clk)
  );

  // Clock Generation (10 MHz = 100ns period -> Toggle every 50ns)
  initial clk = 0;
  always #50 clk = ~clk;


  initial begin

    rst_n = 0;
    #200;
    rst_n = 1;  // Release Reset
    #10000;
    $stop;

  end
endmodule
