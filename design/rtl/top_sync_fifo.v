`include "fifo.vh"
module top_sync_fifo #(
  // parameter `DATA_WIDTH = 32, //FIFO Width
  parameter DEPTH      = 32  //FIFO Depth or number of entries in FIFO
) (
  input                        i_clk  ,   // Clock
  input                        i_rst_n,   // Active-low reset
  input                        i_rd_en,   // Read enable
  input                        i_wr_en,   // Write enable
  input      [`DATA_WIDTH-1:0] i_data ,   // Input data
  output reg [`DATA_WIDTH-1:0] o_data ,   // Output data
  output                       o_empty,   // Fifo empty flag
  output                       o_full     // Fifo full flag
);

sync_fifo inst_sync_fifo (
  .i_clk  (i_clk  ), // Clock
  .i_rst_n(i_rst_n), // Active-low reset
  .i_rd_en(i_rd_en), // Read enable
  .i_wr_en(i_wr_en), // Write enable
  .i_data (i_data ), // Input data
  .o_data (o_data ), // Output data
  .o_empty(o_empty), // Fifo empty flag
  .o_full (o_full )  // Fifo full flag
);




endmodule