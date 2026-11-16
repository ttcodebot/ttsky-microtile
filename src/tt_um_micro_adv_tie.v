/*
 * Copyright (c) 2026 Tiny Tapeout
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Adversarial micro tile for antenna checks: every output is tied to a constant by a tie cell
// (no diffusion) placed at the far (west) end of the tile; every input drives exactly one
// smallest gate (0.126 um2), placed at increasing distances from the pins.
module tt_um_micro_adv_tie (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire       clk,
    input  wire       rst_n
);

  (* keep *) sky130_fd_sc_hd__conb_1 adv_t0 (.HI(uo_out[0]), .LO(uo_out[1]));
  (* keep *) sky130_fd_sc_hd__conb_1 adv_t1 (.HI(uo_out[2]), .LO(uo_out[3]));
  (* keep *) sky130_fd_sc_hd__conb_1 adv_t2 (.HI(uo_out[4]), .LO(uo_out[5]));
  (* keep *) sky130_fd_sc_hd__conb_1 adv_t3 (.HI(uo_out[6]), .LO(uo_out[7]));

  wire lo, hi_unused;
  (* keep *) sky130_fd_sc_hd__conb_1 adv_tlo (.HI(hi_unused), .LO(lo));

  (* keep *) sky130_fd_sc_hd__a21boi_0 adv_i0 (.A1(lo), .A2(lo), .B1_N(ui_in[0]), .Y());
  (* keep *) sky130_fd_sc_hd__a21boi_0 adv_i1 (.A1(lo), .A2(lo), .B1_N(ui_in[1]), .Y());
  (* keep *) sky130_fd_sc_hd__a21boi_0 adv_i2 (.A1(lo), .A2(lo), .B1_N(ui_in[2]), .Y());
  (* keep *) sky130_fd_sc_hd__a21boi_0 adv_i3 (.A1(lo), .A2(lo), .B1_N(ui_in[3]), .Y());
  (* keep *) sky130_fd_sc_hd__a21boi_0 adv_i4 (.A1(lo), .A2(lo), .B1_N(ui_in[4]), .Y());
  (* keep *) sky130_fd_sc_hd__a21boi_0 adv_i5 (.A1(lo), .A2(lo), .B1_N(ui_in[5]), .Y());
  (* keep *) sky130_fd_sc_hd__a21boi_0 adv_i6 (.A1(lo), .A2(lo), .B1_N(ui_in[6]), .Y());
  (* keep *) sky130_fd_sc_hd__a21boi_0 adv_i7 (.A1(lo), .A2(lo), .B1_N(ui_in[7]), .Y());
  (* keep *) sky130_fd_sc_hd__a21boi_0 adv_i8 (.A1(lo), .A2(lo), .B1_N(clk), .Y());
  (* keep *) sky130_fd_sc_hd__a21boi_0 adv_i9 (.A1(lo), .A2(lo), .B1_N(rst_n), .Y());

  wire _unused = &{hi_unused, 1'b0};

endmodule
