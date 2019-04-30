// =============================================================================
// Filename: serial_parallel_trans.v
// Author: KANG, Jian
// Email: jkangac@connect.ust.hk
// Affiliation: Hong Kong University of Science and Technology
// Description: This module is to do the transformation between serial and parallel
// Parameter N: The width of parallel data
// The module has four mode which is controlled by mode
// Mode: 00 LSB of data_in is the serial input, parallel output
// 		 01 Parallel input, LSB of output is serial output
//		 10 Parallel in, parallel out, one clock period delay
// 		 11 Parallel in, inverse parallel out, one clock period delay
// -----------------------------------------------------------------------------
`timescale 1 ns / 1 ps
module serial_parallel_trans 
#(
		parameter N = 3
)//default width is 3 bit
(
		input clk,
		input rst,
		input [N-1:0] data_in,
		input [1:0] mode,
		input data_enable,//show the master is ready
		output reg [N-1:0] data_out,
		output reg data_valid, //show the output is valide
		output reg data_last//the last bit is finished
		
);
//function used in the module
function integer clogb2(input integer depth);
	begin
		for (clogb2 = 0; depth > 1 ; clogb2 = clogb2 + 1)
		        depth = depth >> 1;
		    end
endfunction
//Calculate the width of counter
parameter integer M = clogb2(N);
//inner registers
reg [N-1:0] data_reg, data_next;//register to storage data temp
reg [1:0] state_reg, state_next;//state reg of FSM
reg [M:0] cnt_reg, cnt_next; //counter used in P/S and S/P
wire [N-1:0] data_out_mode_3;
// state list
localparam IDEL=0;
localparam DATA_PROCESS = 1;
localparam DATA_FINISH = 2;

//Outputs
always @ (*) 
     begin
          case (state_reg)
               IDEL:
                    begin
                        data_out = 0;
                        data_valid = 1'b0;
                        data_last = 1'b0;
                    end
               DATA_PROCESS:
                    begin
                    	data_last = 1'b0;
                        if(mode == 2'd2 || mode == 2'd3||mode == 2'd0) 
                           begin
                                data_out = 0;
                        		data_valid = 1'b0;
                           end
                        else if(mode == 2'd1)
                            begin
                                data_out[N-1:1] = 0;
                                data_out[1] = data_reg[cnt_reg];
                                data_valid = 1'b1;
                            end
                        else 
                            begin
                        		data_out = 0;
                        		data_valid = 1'b0;                                
                            end
                    end
               DATA_FINISH:
                    begin
                    	data_last = 1'b1;
                        if(mode == 2'd2) 
                           begin
                           	  data_out = data_reg;
                           	  data_valid = 1'b1;
                           end
                        else if(mode == 2'd3)
                           begin
                           	   data_out = data_out_mode_3;
                               data_valid = 1'b1;
                           end
                        else if(mode == 2'd0)
                           begin
                           	   data_out = data_reg;
                           	   data_valid = 1'b1;
                           end
                        else if(mode == 2'b1)
                        	begin
                                data_out[N-1:1] = 0;
                                data_out[1] = data_reg[cnt_reg];
                                data_valid = 1'b1;
                        	end
                       	else 
                       	    begin
                        		data_out = 0;
                        		data_valid = 1'b0;                          	        
                       	    end
                    end              
               default:
                    begin
                       data_out = 0;
                       data_valid = 1'b0;  
                    end
          endcase
     end

//States
always @ (*)
     begin
        state_next = state_reg;
        cnt_next = cnt_reg;
        data_next = data_reg;
        case (state_reg)
            IDEL:
                begin
                	if(data_enable) 
                	   begin
                	      state_next = DATA_PROCESS;
                	      cnt_next = cnt_reg + 1'b1;
                	      data_next = data_in;
                	   end
                	else 
                	   begin
                	   	  data_next = data_reg;
                	      state_next = IDEL;
                	      cnt_next = cnt_reg;
                	   end
                end
            DATA_PROCESS:
                begin
                    if(mode == 2'd2 || mode == 2'd3) 
                       begin
                       	  data_next = data_reg;
                          state_next = DATA_FINISH;
                          cnt_next = 0;
                       end
                    else
                       begin
                          if(cnt_reg < N-1) //this is used reduce one clock period
                             begin
                                cnt_next = cnt_reg + 1'b1;
                                state_next = DATA_PROCESS;
                                if(mode == 2'd0) 
                                   begin
                                      data_next[cnt_reg] = data_in[0];
                                   end
                                else 
                                   begin
                                      data_next = data_reg;
                                   end
                             end
                          else 
                             begin
                                cnt_next = cnt_reg;
                                state_next = DATA_FINISH;
                                data_next = data_reg;
                             end
                       end
                end
            DATA_FINISH:
                begin
                    state_next = IDEL;
                    cnt_next = 0;
                    data_next = 0;
                end             
            default:
                begin
                    state_next = IDEL;
                    cnt_next = 0;
                    data_next = 0;
                end
        endcase
     end

//Update state
always @ (posedge clk)
    begin
        if(rst)
            begin
                state_reg <= IDEL;
                cnt_reg <= 0;
                data_reg <= 0;
            end
        else
            begin
                state_reg <= state_next;
                cnt_reg <= cnt_next;
                data_reg <= data_next;
            end
    end

//combination logic
generate
    genvar cell_num;
    for (cell_num = 0; cell_num < N-1; cell_num = cell_num + 1)
        begin: label//Add name here
            assign data_out_mode_3[cell_num] = data_reg[N - cell_num -1];
        end
endgenerate

endmodule


