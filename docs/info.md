## How it works

Micro tile test with 4 bidirectional pins (synthetic capacity design, 4 stages + 0 bits, with uio).

While `rst_n` is low it is a combinational loopback: `uo_out = {ui_in[7:4], uio_in} ^ 0x3c`,
`uio_oe = ui_in[3:0]`, `uio_out = ui_in[7:4] ^ 0x3c[7:4]`.

## How to test

Hold `rst_n` low, drive `ui_in` and `uio_in`, and compare the outputs with the formulas above.

## External hardware

None
