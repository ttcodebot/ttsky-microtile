## How it works

Micro tile test with 6 uio inputs and 6 uio outputs, directions fixed by the container (counter with uio).

While `rst_n` is low it is a combinational loopback: `uo_out = {ui_in[7:6], uio_in} ^ 0x00`,
`uio_out = ui_in[7:2] ^ 0x00[7:2]`.

## How to test

Hold `rst_n` low, drive `ui_in` and `uio_in`, and compare the outputs with the formulas above.

## External hardware

None
