// =============================================================================
// Filename: edge_det_syn.v
// Author: KANG, Jian
// Email: jkangac@connect.ust.hk
// Affiliation: Hong Kong University of Science and Technology
// Description: tbis is a synchrounous detection
// -----------------------------------------------------------------------------
`timescale 1 ns / 1 ps
module edge_det_syn(
	input clk,
	input rst,
	input data_in,
	output rise_edge_flag, fall_edge_flag
		
);

reg data_temp;
reg data_temp_1;

always @ (posedge clk)
    begin
        if(rst)
        	begin
        		data_temp <= 1'b0;
        		data_temp_1 <= 1'b0;
        	end
        else
        	begin
        		data_temp <= data_in;
        		data_temp_1 <= data_temp;
        	end
    end


assign rise_edge_flag = !data_temp & data_temp_1;
assign fall_edge_flag = data_temp & !data_temp_1;
endmodule