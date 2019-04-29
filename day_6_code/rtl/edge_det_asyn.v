// =============================================================================
// Filename: edge_det_asyn.v
// Author: KANG, Jian
// Email: jkangac@connect.ust.hk
// Affiliation: Hong Kong University of Science and Technology
// Description:
// -----------------------------------------------------------------------------
`timescale 1 ns / 1 ps
module edge_det_asyn(
	input clk,
	input rst,
	input data_in,
	output rise_edge_flag, fall_edge_flag
		
);

reg data_temp;

always @ (posedge clk)
    begin
        if(rst)
        	begin
        		data_temp <= 1'b0;
        	end
        else
        	begin
        		data_temp <= data_in;
        	end
    end


assign rise_edge_flag = !data_temp & data_in;
assign fall_edge_flag = data_temp & !data_in;
endmodule