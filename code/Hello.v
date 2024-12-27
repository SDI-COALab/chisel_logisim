module Hello(
  input   clock,
  input   reset,
  output  io_led
);
  assign io_led = 1'h0; // @[Hello.scala 26:10]
endmodule
