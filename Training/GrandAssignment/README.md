# RISC-V Log Analyzer

## Overview
A shell-based tool to parse simulation logs and calculate pass/fail statistics for RISC-V test suites.

## Project Structure
- `scripts/`: Contains `analyze.sh`
- `test_data/`: Sample log files
- `Makefile`: Automation for running and cleaning
- `output/`: Generated reports

## Usage
To run the analysis:
\`\`\`bash
make run
\`\`\`

To clean output:
\`\`\`bash
make clean
\`\`\`
