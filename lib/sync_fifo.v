`include "fifo.vh"
module sync_fifo #(
 // parameter `DATA_WIDTH = 32, //FIFO Width
  parameter DEPTH      = 32  //FIFO Depth or number of entries in FIFO
) (
  input                       i_clk,   // Clock
  input                       i_rst_n, // Active-low reset
  input                       i_rd_en, // Read enable
  input                       i_wr_en, // Write enable
  input      [`DATA_WIDTH-1:0] i_data,  // Input data
  output reg [`DATA_WIDTH-1:0] o_data,  // Output data
  output                      o_empty, // Fifo empty flag
  output                      o_full   // Fifo full flag
);




//Internal Variables
  reg [   `DATA_WIDTH-1:0] mem      [DEPTH-1:0]; //FIFO  memory
  reg [$clog2(DEPTH)-1:0] rd_ptr;               //Read  pointer
  reg [$clog2(DEPTH)-1:0] wr_ptr;               //Write pointer
  reg [  $clog2(DEPTH):0] count_reg;            //FIFO  status count_reg register


//Empyt and full Flags
  assign o_full  = (count_reg == DEPTH) ? 1 : 0 ;
  assign o_empty = (count_reg == 'b0  ) ? 1 : 0 ;

//Synchronous Write Operation
  always @(posedge i_clk) begin
    if (~i_rst_n) begin
      wr_ptr <= 0;

    end
    else if (i_wr_en && ~o_full) begin
      wr_ptr      <= wr_ptr + 1;
      mem[wr_ptr] <= i_data;
    end
  end

//Synchronous Read Operation
  always @(posedge i_clk) begin
    if (~i_rst_n) begin
      rd_ptr <= 0;
    end
    else if (i_rd_en && ~o_empty) begin
      rd_ptr <= rd_ptr + 1;
      o_data <= mem[rd_ptr];
    end
  end

//FIFO status count_reg Register
  always @(posedge i_clk ) begin
    if (~i_rst_n) begin
      count_reg <= 0;
    end
    else begin
      case({i_wr_en,i_rd_en})
        2'b00 : count_reg <= count_reg ;                          // No change if both read and write are low
        2'b01 : if(~o_empty) count_reg <= count_reg - 1; else count_reg <= count_reg;   // Decremnent count_reg if read asserted and not empty
        2'b10 : if(~o_full)  count_reg <= count_reg + 1; else count_reg <= count_reg;   // Increment count_reg if write asserted and not full
        2'b11 : count_reg <= count_reg;                             // No change in count_reg if both asserted
      endcase

    end
  end


endmodule