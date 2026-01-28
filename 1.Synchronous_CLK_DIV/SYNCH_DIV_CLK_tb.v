`timescale 1ns / 1ps  // Unit = 1ns, Precision = 1ps
module SYNCH_DIV_CLK_tb ();
  //////////////////// Signals ///////////////////
  reg  clk;
  reg  rst;
  wire SYNCH_DIV_CLK;
  //////////////// Design under test /////////
  SYNCH_DIV_CLK DUT (
      .clk(clk),
      .rst(rst),
      .SYNCH_DIV_CLK(SYNCH_DIV_CLK)
  );

  ////////// Clock Generation ////////////
  initial clk = 0;
  always #62.5 clk = ~clk;
  // ///////////// Initial Block /////////////
  initial begin
    rst = 1'b1;  // Active Low Reset
    #250;  // Wait 250ns (2 cycles)
    rst = 1'b0;  // Release Reset
    #2500;  // Run for 2500ns (2.5us)
    $stop;
  end

endmodule
