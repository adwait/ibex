

# Notes on the ibex core:


## Testbench and verification wrappers:

The top level tb is located [here](tb/ibex_tb.v), with an associated [Makefile](tb/Makefile).


### Instruction interfacing and hijacking:
 
- The core takes in instructions which are 39 bits wide. This includes 32 data bits and 7 ECC bits [IPs](https://github.com/lowRISC/ibex/tree/master/vendor/lowrisc_ip/ip/prim/rtl). These can be sucessfully ignored if ECC is disabled (?).
- The testbench sets inputs values following typical waveforms generated. A few things are yet to be fixed/figured out: what is the correct reseting and instruction hijakcing procedure. This will require a verilog file, but currently have the following issue:
- Currently there is an issue with building a single .v file: [here](https://lowrisc.zulipchat.com/#narrow/stream/198227-ibex) is the relevant discussion on Zulip

## PMP related resources:

1. Kevin's PMP paper [Verifying PMP in Keystone](https://ascslab.org/conferences/secriscv/materials/papers/paper_19.pdf)
2. PMP header from Keystone: [PMP](https://github.com/keystone-enclave/riscv-pk/blob/f855a56f919142a0fa9987be79a3c1ad09384e66/sm_rs/pmp.h)
3. Ibex CSR [docs](https://ibex-core.readthedocs.io/en/latest/03_reference/cs_registers.html#cs-registers), RISCV [standards](https://ibex-core.readthedocs.io/en/latest/01_overview/compliance.html) and [PMP docs](https://ibex-core.readthedocs.io/en/latest/03_reference/pmp.html)