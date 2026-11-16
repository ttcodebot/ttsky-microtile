/*
 * Copyright (c) 2026 Tiny Tapeout
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Adversarial micro tile for antenna checks: every output is driven by the weakest driver of
// the library (and2_0, 0.281 um2 of diffusion) at the far (west) end of the tile, and every
// input drives exactly one smallest gate (and2_0 input, 0.126 um2) there.
module tt_um_micro_adv_far (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire       clk,
    input  wire       rst_n
);

  wire lo, hi;
  (* keep *) sky130_fd_sc_hd__conb_1 adv_t (.HI(hi), .LO(lo));

  (* keep *) sky130_fd_sc_hd__and2_0 adv_o0 (.A(ui_in[0]), .B(ui_in[1]), .X(uo_out[0]));
  (* keep *) sky130_fd_sc_hd__and2_0 adv_o1 (.A(ui_in[2]), .B(ui_in[3]), .X(uo_out[1]));
  (* keep *) sky130_fd_sc_hd__and2_0 adv_o2 (.A(ui_in[4]), .B(ui_in[5]), .X(uo_out[2]));
  (* keep *) sky130_fd_sc_hd__and2_0 adv_o3 (.A(ui_in[6]), .B(ui_in[7]), .X(uo_out[3]));
  (* keep *) sky130_fd_sc_hd__and2_0 adv_o4 (.A(clk), .B(rst_n), .X(uo_out[4]));
  (* keep *) sky130_fd_sc_hd__and2_0 adv_o5 (.A(hi), .B(hi), .X(uo_out[5]));
  (* keep *) sky130_fd_sc_hd__and2_0 adv_o6 (.A(hi), .B(lo), .X(uo_out[6]));
  (* keep *) sky130_fd_sc_hd__and2_0 adv_o7 (.A(lo), .B(hi), .X(uo_out[7]));

endmodule
