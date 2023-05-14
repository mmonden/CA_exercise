module fwunit #(
   parameter integer DATA_W = 16
   )(
	input writeback1_EX_MEM_output,	
    input writeback1_MEM_WB_output,	
    input [3:0] inst1_ID_EX_output,     // rs2
    input [63:0] inst_imm_ID_EX_output, // rs1

    input [4:0] inst2_EX_MEM_output,    // rd
    input [4:0] inst2_MEM_WB_output,    // rd

	output  mux_bottom,
    output  mux_top
   );


    always@(*) begin
        if(writeback1_EX_MEM_output && (inst2_EX_MEM_output != 4'b0) && (inst2_EX_MEM_output == inst_imm_ID_EX_output)) begin
            mux_top = 2'b10;
        end else if(writeback1_MEM_WB_output && (inst2_MEM_WB_output != 4'b0) 
                            && !(writeback1_EX_MEM_output && (inst2_EX_MEM_output != 0) && (inst2_EX_MEM_output == inst_imm_ID_EX_output)) 
                            && (inst2_MEM_WB_output == inst_imm_ID_EX_output)) begin
            mux_top = 2'b01;
        end

        if(writeback1_EX_MEM_output && (inst2_EX_MEM_output != 4'b0) && (inst2_EX_MEM_output == inst1_ID_EX_output)) begin
            mux_bottom = 2'b10;
        end else if(writeback1_MEM_WB_output && (inst2_MEM_WB_output != 4'b0) 
                            && !(writeback1_EX_MEM_output && (inst2_EX_MEM_output != 0) && (inst2_EX_MEM_output == inst1_ID_EX_output)) 
                            && (inst2_MEM_WB_output == inst1_ID_EX_output)) begin
            mux_bottom = 2'b01;
        end
    end

endmodule