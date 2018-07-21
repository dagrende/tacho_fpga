spi_slave_transmitter(clk, miso, sck, ssel, data);
  parameter DATA_LEN = 16;
  input clk, sck;
  input ssel; // active low
  output miso;  // hi imp when ssel is high
  input [DATA_LEN - 1:0] data;
  reg [DATA_LEN - 1:0] tx_buffer;

  reg [2:0] miso_sync, sck_sync, ssel_sync;
  always @(posedge clk) begin
    miso_sync <= {miso, miso_sync[2:1]};
    sck_sync <= {sck, sck_sync[2:1]};
    ssel_sync <= {ssel, ssel_sync[2:1]};
  end

  wire sck_posedge = sck_sync[1:0] == 2'b10;
  wire ssel_posedge = ssel_sync[1:0] == 2'b10;
  wire ssel_negedge = ssel_sync[1:0] == 2'b01;
  wire ssel_active = ssel_sync[0] == 0;

  always @(posedge clk) begin
    if (ssel_negedge) begin
      tx_buffer = data;
    end else
    if (sck_posedge) begin
      tx_buffer = {tx_buffer[DATA_LEN - 2: 0], 1'b0};
    end else
  end

  assign miso = ssel_active ? tx_buffer[DATA_LEN - 1] : 1'bz
endmodule
