// =============================================================================
// Filename: BCD_encoder.v
// Author: KANG, Jian
// Email: jkangac@connect.ust.hk
// Affiliation: Hong Kong University of Science and Technology
// Description:
// -----------------------------------------------------------------------------
module BCD_encoder(
	input [3:0] in,
	output reg [9:0] out
		
);

always @ (*)
    begin
        case (in) 
            4'd0:
                begin
                    out = 10'b00_0000_0001;
                end
             4'd1:
                begin
                    out = 10'b00_0000_0010;
                end
             4'd2:
                begin
                    out = 10'b00_0000_0100;
                end  
            4'd3:
                begin
                    out = 10'b00_0000_1000;
                end
             4'd4:
                begin
                    out = 10'b00_0001_0000;
                end
             4'd5:
                begin
                    out = 10'b00_0010_0000;
                end 
             4'd6:
                begin
                    out = 10'b00_0100_0000;
                end
             4'd7:
                begin
                    out = 10'b00_1000_0000;
                end
             4'd8:
                begin
                    out = 10'b01_0000_0000;
                end
             4'd9:
                begin
                    out = 10'b10_0000_0000;
                end                                                                          
            default:
                begin
                    out = 10'b00_0000_0000;                    
                end
        endcase
    end
endmodule