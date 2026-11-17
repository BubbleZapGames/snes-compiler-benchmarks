# Four SNES C toolchains: a measured comparison

These results compare **VBCC, Calypsi, TCC and WDC** builds of one game in MesenCE 2.2.1, NTSC: startup, loading, footprint and graphics-upload tradeoffs, without an overall toolchain ranking.

“Master clocks” are ticks of the SNES timing reference, approximately 21.477272 million per second. One NTSC frame spans 357,366 master clocks. For elapsed work, fewer clocks means less time; for remaining headroom, more is better.

## Startup and map loading

| Measurement | VBCC | Calypsi | TCC | WDC |
|---|---:|---:|---:|---:|
| Power-on to first NMI, master clocks | 16,424,266 | 41,404,074 | 26,037,334 | 22,463,666 |
| Power-on to first NMI, milliseconds | 764.73 | 1,927.81 | 1,212.32 | 1,045.93 |
| NMI entry to first OAM DMA byte, master clocks | 812–818 | 652–658 | 1,088–1,094 | 776–782 |
| Startup `map_load`, inclusive clocks | 4,394,554 | 5,688,348 | 13,480,038 | 9,666,732 |
| Door `map_load`, inclusive clocks | 8,249,006 | 10,637,148 | 25,542,458 | 18,283,430 |

Lower is better throughout this table. Power-on to first NMI measures how quickly startup reaches its first vertical-blank interrupt, when the game can perform display updates. It is a startup milestone, not a measurement of when gameplay becomes interactive.

The NMI-to-OAM row measures the delay before the **first actual sprite-data write** reaches OAM through PPU port `$2104`. It includes the interrupt entry path and transfer startup, rather than stopping when the CPU requests DMA. Calypsi begins this transfer earliest here, despite taking longest to reach the first NMI after power-on.

`map_load` measures one loading call, including functions it calls, **not total transition time**. Shorter calls reduce map-preparation work. VBCC has the shortest measured calls; TCC has the longest.

## Code and cartridge footprint

| Measurement, bytes | VBCC | Calypsi | TCC | WDC |
|---|---:|---:|---:|---:|
| Executable code sections, approximate | 35,215 | 29,901 | 63,994 | 40,078 |
| Used ROM, approximate | 121,615 | 116,326 | 153,396 | 126,498 |
| ROM image size | 131,072 | 262,144 | 524,288 | 131,072 |

Code sections estimate program code and linked support routines; used ROM includes other content. Smaller figures leave more room for the game. **Image size includes padding**: Calypsi has the smallest reported used ROM, yet its padded image exceeds VBCC’s and WDC’s.

These estimates use different accounting methods. Calypsi counts unique populated HEX bytes; TCC uses allocation reports; VBCC and WDC use mapped section spans. Assembly and support code are included as represented by those reports. TCC’s bundled support code includes unused routines and a few embedded data bytes. These are useful footprint estimates, not identical counts of instructions the game actually executes.

Build settings also matter: TCC enables `816-opt` **except for `map.c`**, where optimization produced incorrect accesses to memory banks. Its checked `constify` option is enabled. The WDC candidate was built **without optimization**. These results do not establish either compiler’s best achievable performance.

## DMA capacity before drawing resumes

NMI provides a limited blanking window for graphics updates before drawing resumes. DMA transfers data to video memory (VRAM), sprite attributes (OAM) and palette memory (CGRAM). More upload capacity can refresh more graphics at once, but all required work must fit the window.

| Measurement | VBCC | Calypsi | TCC | WDC |
|---|---:|---:|---:|---:|
| Original base sprite budget, clocks | 41,600 | 41,600 | 41,600 | 41,600 |
| Revised base sprite budget, clocks | 41,600 | 36,400 | 34,000 | 31,200 |
| Full 32×32 sections admitted, synthetic maximum | 7 | 6 | 4 | 5 |
| Full sections admitted with CGRAM, 128-byte water, four rows and full 1,792-byte UI | 3 | 2 | 1 | 1 |
| Late VRAM bytes after revised budgets in tested cases | 0 | 0 | 0 | 0 |

One full section uploads four 128-byte strips: **512 VRAM bytes**. Higher admitted counts mean greater capacity under that artificial load. They count **section uploads per NMI, not visible sprites**. Already-uploaded graphics can remain visible without being uploaded again.

The budgets tell the scheduler how much sprite work to admit; a larger allowance is not inherently better. The inherited budgets caused actual late VRAM writes on **all three ports: Calypsi, TCC and WDC**. Reduced budgets, plus revised TCC estimates for section/strip costs and safety allowances, gave zero late bytes in the tested cases. “Late” means an actual VRAM-port write at scanline 0 or later, after drawing resumes.

### Stress-test limits

Full-section tests force artificial pending work. Normal scheduling also depends on sprite shapes and available upload slots, so its results are not interchangeable with those maxima. Compact examples illustrate the limits:

- **Calypsi:** four full sections plus palette, four map rows, 128-byte water and a 288-cell UI produced 3,008 VRAM bytes, 544 OAM bytes and 512 CGRAM bytes; the final VRAM byte arrived at scanline 260.
- **WDC:** an adjusted 16-case sweep recorded zero late bytes over 639 sampled NMIs, using full 1,792-byte UI, four 64-byte rows and 512 CGRAM bytes when enabled, with naturally occurring 96/128-byte water transfers.
- **TCC:** actual bat/slime shapes under the full mixed load admitted one section. Across 30 physical NMIs and 15 committed updates, there were no late bytes; the minimum estimated completion margin was 690 clocks.

A deliberately excessive **1,568-byte Calypsi water transfer still overran** after budget reduction. The game’s measured water maximum was **128 bytes per NMI**. Finite tests cannot prove safety in every state. CPU lag can also leave an NMI with no committed upload, so physical interrupt counts and completed-update counts differ.

## Gameplay and stress-workload timings

The supplied phase matrix adds the following **average busy master clocks per logical game frame**. Lower means less measured busy time for that phase. A logical frame is one game update; lag can make it span more than one physical display frame. An average above the **357,366-clock NTSC frame budget** therefore signals work exceeding one display frame on average. These averages do not give peak costs, lag counts or a guaranteed frame rate.

All 52 phase rows are retained below, including setup phases for context. `settle`, `approach` and `warmup` are preparation phases; the remaining labels identify movement, collision, facing changes, fire breath, hitbox, scrolling and enemy-pathfinding workloads. `test0` and `test1` are map identifiers. Here, `door`, `door_up` and `door_down` measure whole-frame busy time, not the isolated `map_load` call above.

| Scenario | Phase | VBCC | Calypsi | TCC | WDC |
|---|---|---:|---:|---:|---:|
| standard | settle | 84,851 | 116,276 | 221,144 | 145,330 |
| standard | steady_test0 | 83,636 | 114,926 | 219,053 | 143,610 |
| standard | walk_test0 | 113,143 | 146,093 | 287,526 | 192,533 |
| standard | door | 179,567 | 230,997 | 484,763 | 320,180 |
| standard | steady_test1 | 184,962 | 233,686 | 458,304 | 316,150 |
| standard_run | settle | 84,851 | 116,276 | 221,144 | 145,330 |
| standard_run | steady_test0 | 83,636 | 114,926 | 219,053 | 143,610 |
| standard_run | run_test0 | 113,318 | 148,015 | 291,334 | 192,250 |
| standard_run | door | 182,058 | 231,713 | 478,708 | 328,725 |
| standard_run | steady_test1 | 182,942 | 233,696 | 458,137 | 308,185 |
| wall_run | settle | 88,535 | 120,366 | 227,499 | 150,549 |
| wall_run | approach | 114,021 | 147,530 | 292,726 | 193,593 |
| wall_run | wall_press | 144,823 | 181,603 | 358,695 | 239,131 |
| player_move | settle | 88,535 | 120,366 | 227,499 | 150,549 |
| player_move | normal_walk | 86,284 | 118,129 | 225,068 | 149,216 |
| player_move | fully_blocked | 86,517 | 118,297 | 226,513 | 149,318 |
| player_move | edge_clear_1px | 86,495 | 118,269 | 226,477 | 149,281 |
| player_move | edge_clear_2px_right | 86,530 | 118,310 | 226,541 | 149,335 |
| player_move | edge_clear_2px_left | 86,457 | 118,158 | 226,307 | 149,294 |
| player_move | run_edge_clear_1px | 87,614 | 119,530 | 228,487 | 151,147 |
| player_move | edge_clear_horizontal_1px | 86,275 | 118,015 | 224,789 | 149,144 |
| player_move | edge_clear_horizontal_2px | 86,264 | 117,997 | 224,712 | 149,057 |
| facing | settle | 88,535 | 120,366 | 227,499 | 150,549 |
| facing | approach | 86,441 | 118,483 | 226,693 | 151,015 |
| facing | walk_lr | 89,094 | 121,108 | 237,087 | 156,233 |
| facing | run_lr | 90,293 | 122,455 | 240,181 | 160,760 |
| facing | breath_lr | 155,196 | 204,266 | 432,372 | 245,622 |
| breath | settle | 88,535 | 120,366 | 227,499 | 150,549 |
| breath | wake | 137,614 | 176,255 | 328,926 | 227,400 |
| breath | return | 207,403 | 257,869 | 496,033 | 313,709 |
| breath | breath_right | 189,352 | 229,777 | 492,269 | 325,092 |
| breath | breath_up | 142,048 | 152,220 | 327,599 | 119,165 |
| breath_run | settle | 88,535 | 120,366 | 227,499 | 150,549 |
| breath_run | wake | 138,349 | 174,428 | 333,109 | 226,438 |
| breath_run | return | 197,005 | 247,111 | 473,624 | 303,299 |
| breath_run | breath_right | 221,605 | 281,584 | 521,872 | 329,064 |
| breath_run | breath_up | 133,114 | 228,552 | 370,795 | 369,585 |
| hitbox_bench | settle | 88,535 | 120,366 | 227,499 | 150,549 |
| hitbox_bench | hitbox_bench | 194,671 | 258,590 | 562,377 | 290,682 |
| scroll_jitter | approach | 99,532 | 132,942 | 246,682 | 169,149 |
| scroll_jitter | warmup | 99,321 | 134,538 | 257,318 | 176,111 |
| scroll_jitter | scroll_jitter | 99,421 | 134,655 | 257,591 | 176,746 |
| pathing | settle | 88,535 | 120,366 | 227,499 | 150,549 |
| pathing | walk_test0 | 113,665 | 146,729 | 285,388 | 191,293 |
| pathing | door_up | 179,423 | 230,845 | 476,847 | 322,665 |
| pathing | door_down | 193,231 | 253,256 | 540,885 | 360,859 |
| pathing | chase | 116,006 | 158,149 | 294,496 | 191,179 |
| pathing_moving | settle | 88,535 | 120,366 | 227,499 | 150,549 |
| pathing_moving | walk_test0 | 113,665 | 146,729 | 285,388 | 191,293 |
| pathing_moving | door_up | 179,423 | 230,845 | 476,847 | 322,665 |
| pathing_moving | door_down | 193,231 | 253,256 | 540,885 | 360,859 |
| pathing_moving | pace | 138,259 | 177,493 | 335,956 | 224,768 |

These are observed phase averages, not equal-work compiler benchmarks. For example, WDC records 119,165 clocks for `breath / breath_up`, versus VBCC’s 142,048, while `breath_run / breath_up` records 369,585 for WDC and 133,114 for VBCC. Diverging gameplay states prevent treating either comparison as a general speed ranking. The CSV containing p95, maxima, lag counts and endpoints was not supplied, so those metrics cannot be added from this matrix.

## What this establishes for toolchain choice

These builds expose different startup, loading, storage and upload-capacity tradeoffs. Their gameplay states and workloads are not fully equivalent: combat, enemy paths and phase lengths diverge as idle pathfinding time and lag change. WDC matched sprites in 40 shared poses with no OAM packing errors, but failed the overall comparison because state/frame alignment drifted. That subset does not prove full correctness.

The phase matrix is now included above; the referenced CSV and per-port method files remain unavailable. **Scenario-wide gameplay rankings cannot be inferred from this summary.** Use these measurements to identify priorities and validation needs for your own game.
