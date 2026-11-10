![](../../workflows/gds/badge.svg) ![](../../workflows/test/badge.svg)

# Micro tile test for sky130A

An experimental Tiny Tapeout _micro tile_: a small hardened macro, four of which are placed inside an ordinary 1x1 Tiny Tapeout project (the container), which muxes between them.

- [Read the documentation for project](docs/info.md)
- Container project: https://github.com/ttcodebot/ttsky-microtile-container

## Micro tile format

| Property    | Value                                                                                                        |
| ----------- | ------------------------------------------------------------------------------------------------------------ |
| PDK         | `sky130A`                                                                                                    |
| Size        | 70.38 x 51.68 um (153 sites x 19 rows)                                                                       |
| Core area   | 64.86 x 46.24 um (141 sites x 17 rows), 2999 um2                                                             |
| Ports       | `clk`, `rst_n`, `ui_in[7:0]`, `uo_out[7:0]`                                                                  |
| Layers      | li1 to met3 (signals route on met1, met2 and met3); met4 is left to the container                            |
| Signal pins | met3, 1.0 x 0.3 um, on the east edge, one per row (2.72 um pitch)                                            |
| Power pins  | `VPWR` / `VGND`: four horizontal met3 stripes (1.0 um wide), tied to the met1 rails by 0.8 um met2 stripes   |

The container runs its vertical met4 power stripes over the micro tile and connects them to the met3 stripes with via3.

The format is defined by the `micro` tile size and the `tt_block_micro_pg.def` template in the `microtile-sky130` branch of https://github.com/ttcodebot/tt-support-tools, which the workflows in this repository use.

## Why this size

A 1x1 tile is 161.00 x 111.52 um: 350 sites x 41 rows.

- Height: two micro tiles of 19 rows take 38 rows. The remaining three rows at the top of the container hold its pins, one row of standard cells and the horizontal routing from the pins to the channel.
- Width: two micro tiles of 153 sites leave a 44 site (20.24 um) channel in the middle for the mux logic of the container, its routing to the 72 micro tile pins, and one met4 power stripe of each net.
