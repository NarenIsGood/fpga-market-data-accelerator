# Packet Parser Verification Plan

## Goal
Verify the byte-stream packet parser handles normal traffic and basic control edge cases before synthesis.

## Planned Test Cases

- [ ] Continuous valid byte stream
- [ ] Single-cycle gap in `valid`
- [ ] Multiple back-to-back packets
- [ ] Reset during an active stream
- [ ] Boundary byte values (`8'h00`, `8'hFF`)

## Checks
For each test, verify:

- Input bytes remain correctly aligned
- Invalid cycles do not generate parsed output
- `parsed_valid` only asserts for valid parsed data
- Reset returns parser state to idle
- No data from a previous packet leaks into the next packet

## Next Step
Implement these cases in `tb/packet_parser_tb.sv` and verify the waveform before FPGA synthesis.
