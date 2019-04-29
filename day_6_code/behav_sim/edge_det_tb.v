// =============================================================================
// Filename: edge_det_tb.v
// Author: KANG, Jian
// Email: jkangac@connect.ust.hk
// Affiliation: Hong Kong University of Science and Technology
//Description:
// -----------------------------------------------------------------------------
`timescale 1 ns / 1 ps

module edge_det_tb;

// ----------------------------------
// Local parameter declaration
// ----------------------------------
localparam CLK_PERIOD = 5;  // clock period: ns

// ----------------------------------
// Interface of the tested module
// ----------------------------------
reg clk;
reg rst;
reg data_in;
wire rise_flag_syn;
wire fall_flag_syn;
wire rise_flag_asyn;
wire fall_flag_asyn;
// ----------------------------------
// Instantiate the tested module
// ----------------------------------
edge_det_asyn edge_det_asyn_inst(
  .clk(clk),
  .rst(rst),
  .data_in(data_in),
  .rise_edge_flag(rise_flag_syn), 
  .fall_edge_flag(fall_flag_syn)  
);

edge_det_syn edge_det_syn_inst(
  .clk(clk),
  .rst(rst),
  .data_in(data_in),
  .rise_edge_flag(rise_flag_asyn), 
  .fall_edge_flag(fall_flag_asyn)   
);
// ----------------------------------
// Clock generation
// ----------------------------------
initial begin
  clk = 1'b0;
  forever #(CLK_PERIOD/2.0) clk = ~clk;
end

// ----------------------------------
// Input stimulus
// Generate the ad-hoc stimulus
//This is an example
//initial begin
  // Reset
  //rst         = 1'b1;
  //start       = 1'b0;
  //dividend    = 32'd0;
  //divisor     = 32'd0;
  //#(2*CLK_PERIOD) rst = 1'b0;
  //end
// ----------------------------------

initial
  begin
  //Add Your Code
      rst = 1'b1;
      #18 rst = 1'b0; 
  end

initial begin
    data_in = 1'b0;
    #33
    data_in = 1'b1;
    #66
    data_in = 1'b0;
    #20
    $finish;
end
// ----------------------------------
// Output monitor
//This is an example
//always @(posedge clk) begin
  //if (done) begin
    //("%0d / %0d: quotient = %0d, remainder = //%0d", dividend, divisor,
      //quotient, remainder);
  //end
// ----------------------------------
//Add Your Code

endmodule