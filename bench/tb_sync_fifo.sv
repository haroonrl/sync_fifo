
module tb_fifo (); /* this is automatically generated */

  // clock
  logic clk;
  initial begin
    clk = '0;
    forever #(5) clk = ~clk;
  end

  /*// synchronous reset
  logic srstb;

  

  initial begin
    srstb <= '0;
    repeat(10)@(posedge clk);
    srstb <= '1;
  end*/

  // (*NOTE*) replace reset, clock, others

  parameter DATA_WIDTH = 32;
  parameter      DEPTH = 32;

  logic                  i_rst_n;
  logic                  i_rd_en;
  logic                  i_wr_en;
  logic [DATA_WIDTH-1:0] i_data;
  logic [DATA_WIDTH-1:0] o_data;
  logic                  o_empty;
  logic                  o_full;

  top_sync_fifo #(
      .DATA_WIDTH(DATA_WIDTH),
      .DEPTH(DEPTH)
    ) inst_fifo (
      .i_clk   (clk),
      .i_rst_n (i_rst_n),
      .i_rd_en (i_rd_en),
      .i_wr_en (i_wr_en),
      .i_data  (i_data),
      .o_data  (o_data),
      .o_empty (o_empty),
      .o_full  (o_full)
    );

  //Reset task
  task reset();
    i_rst_n <= '0;
    repeat(20)@(posedge clk);
    i_rst_n <= '1;
  endtask 

  //Initialization  
  task init();
    i_rd_en <= '0;
    i_wr_en <= '0;
    i_data  <= '0;
  endtask
  //Write
  task write(int iter);
    for(int it = 0; it < iter; it++) begin
      i_rd_en <= '0;
      i_wr_en <= '1;
      i_data  <= $random();
      @(posedge clk);
    end
  endtask
  //Read
   task read(int iter);
    for(int it = 0; it < iter; it++) begin
      i_rd_en <= '1;
      i_wr_en <= '0;
      i_data  <= $random();
      @(posedge clk);
    end
  endtask
  //Simultaneous Read & Write 
   task write_n_read(int iter);
    for(int it = 0; it < iter; it++) begin
      i_rd_en <= '1;
      i_wr_en <= '1;
      i_data  <= $random();
      @(posedge clk);
    end
  endtask


  initial begin
    
    //Test case-1 Read on empty FIFO
    //Test case-2 Write on Full FIFO
    //Test case-3 Simultaneously Read & Write 

    //Apply reset 
    reset();
    init();
    repeat(10)@(posedge clk);

    //read on empty
   // read(1);
    
    //Write fifo fully 
   // write(31);

    //Write on full check
   // write(1);

   // repeat(10)@(posedge clk);
    //Read fifo fully
   
   // read(31);
    //read on empt
   // read(1);s
   //  init();
   write(10);
   repeat(10)@(posedge clk);
     write_n_read(10);
    repeat(10)@(posedge clk);
    $finish;
  end

  // dump wave
  initial begin
   // $display("random seed : %0d", $unsigned($get_initial_random_seed()));
   // if ( $test$plusargs("fsdb") ) begin
   //   $fsdbDumpfile("tb_fifo.fsdb");
   //   $fsdbDumpvars(0, "tb_fifo", "+mda", "+functions");
   // end
  end

endmodule
