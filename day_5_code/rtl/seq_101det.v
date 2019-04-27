// =============================================================================
// Filename: seq_101det.v
// Author: KANG, Jian
// Email: jkangac@connect.ust.hk
// Affiliation: Hong Kong University of Science and Technology
// Description:
// -----------------------------------------------------------------------------
`timescale 1 ns / 1 ps
module seq_101det(
	input clk,
	input rst,
	input data_in,
	output flag_101 	
);

reg flag_101;
reg [2:0] state_reg, state_next;

localparam S0=0;
localparam S1=1;
localparam S2=2;
localparam S3=3;

//flag_101puts
always @ (*) 
     begin
          case (state_reg)
               S0:
                    begin
                        flag_101 = 0;
                    end
               S1:
                    begin
                        flag_101 = 0;
                    end
               S2:
                    begin
                        flag_101 = 0;
                    end
               S3:
                    begin
                        flag_101 = 1;
                    end
               default:
                    begin
                        flag_101 = 0;
                    end
          endcase
     end

//States
always @ (*)
     begin
        state_next = state_reg;
        case (state_reg)
            S0:
                begin
                	if (data_in == 1'b0) 
                	    begin
                	        state_next = S0;
                	    end
                	else 
                	    begin
                	        state_next = S1;
                	    end
                end
            S1:
                begin
                	if (data_in == 1'b0) 
                	    begin
                	        state_next = S2;
                	    end
                	else 
                	    begin
                	        state_next = S1;
                	    end
                end
            S2:
                begin
                	if (data_in == 1'b0) 
                	    begin
                	        state_next = S0;
                	    end
                	else 
                	    begin
                	        state_next = S3;
                	    end
                end
            S3:
                begin
                	if (data_in == 1'b0) 
                	    begin
                	        state_next = S2;
                	    end
                	else 
                	    begin
                	        state_next = S1;
                	    end
                end
            default:
                begin
                    state_next = S0;
                end
        endcase
     end

//Update state
always @ (posedge clk)
    begin
        if(rst)
            begin
                state_reg <= S0;
            end
        else
            begin
                state_reg <= state_next;
            end
    end

endmodule
