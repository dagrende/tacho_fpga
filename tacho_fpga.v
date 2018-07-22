module tacho_fpga(clk, quadA, quadB, miso, mosi, sck, ssel);
	parameter COUNT_BITS = 32;
	input clk, quadA, quadB;
	output miso;
  input mosi, sck, ssel;
  wire [COUNT_BITS - 1:0] data;

	//quad_counter counter(clk, quadA, quadB, count);
  spi_slave_transmitter spi_tx(clk, miso, sck, ssel, data);

  assign data = 32'h87654321; 
endmodule
