`timescale 1ns / 1ps  // Unit = 1ns, Precision = 1ps
module ASYNCH_DIV_CLK_tb ();


  //////////////////// Signals ///////////////////
  reg  clk;
  reg  rst;
  wire ASYNCH_DIV_CLK;


  //////////////// Design under test /////////
  ASYNCH_DIV_CLK DUT (  //divided by 8 CLK divider
      .clk(clk),
      .rst(rst),
      .ASYNCH_DIV_CLK(ASYNCH_DIV_CLK)
  );



  ////////// Clock Generation ////////////
  always #62.5 clk = ~clk;



  // ///////////// Initial Block /////////////
  initial begin
    clk = 0;
    #100 rst = 1'b0;
    #100 rst = 1'b1;  // Release Reset
    #100000 $stop;
  end

endmodule
