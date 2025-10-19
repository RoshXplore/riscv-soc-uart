`timescale 1ns / 1ps

module data_memory(
    input         clk,
    input         reset,
    input  [4:0]  read_addr,     // Read address
    input  [4:0]  write_addr,    // Write address
    input  [31:0] write_data,    // Data to write
    input         sw,            // Store enable
    output reg [31:0] read_data  // Read data output
);

    // Memory array - 32 words of 32 bits
    reg [31:0] memory [0:31];
    integer i;

    always @(posedge clk) begin
        if (reset) begin
            // Initialize memory to zero
            for (i = 0; i < 32; i = i + 1) begin
                memory[i] <= 32'd0;
            end
            read_data <= 32'd0;
        end else begin
            // Write operation
            if (sw && write_addr < 32) begin
                memory[write_addr] <= write_data;
            end
            
            // Read operation (always active)
            if (read_addr < 32) begin
                read_data <= memory[read_addr];
            end else begin
                read_data <= 32'd0;
            end
        end
    end

endmodule
