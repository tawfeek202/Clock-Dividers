`timescale 1ns / 1ps

module Mod5_Clk_Div_tb ();

  // ////////////////// Signals ///////////////////
  reg  i_clk;
  reg  i_rst_n;  // Renamed to match the DUT port name
  wire o_clk;    // The output clock

  // //////////////// Design under test /////////
  Mod5_Clk_Div DUT (
      .i_clk(i_clk),
      .i_rst_n(i_rst_n),
      .o_clk(o_clk)
  );

  // ////////// Clock Generation ////////////
  // 8 MHz Input Clock (125ns Period)
  initial i_clk = 0;
  always #62.5 i_clk = ~i_clk;

  // ///////////// Initial Block /////////////
  initial begin
    // 1. Initialize & Assert Reset (Active Low = 0)
    i_rst_n = 1'b0; 
    
    // 2. Wait for a few cycles (200ns)
    #200;
    
    // 3. Release Reset (Set to 1 to let it run)
    i_rst_n = 1'b1; 
    
    // 4. Run long enough to see the Divide-by-5 behavior
    // 125ns * 5 = 625ns output period. 
    // Running for 5000ns will give us about 8 output cycles.
    #5000;
    
    $stop;
  end

endmodule