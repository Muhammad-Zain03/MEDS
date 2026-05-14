SCRIPT = ./scripts/analyze.sh
TEST_LOG = test_data/sample.log
OUT_DIR = output

.PHONY: all run clean help

all: run

run:
	@mkdir -p $(OUT_DIR)
	$(SCRIPT) $(TEST_LOG) > $(OUT_DIR)/report.txt
	@echo "Analysis complete. Report saved to $(OUT_DIR)/report.txt"

clean:
	rm -rf $(OUT_DIR)
	@echo "Cleaned up output directory."

help:
	@echo "Available targets:"
	@echo "  all    : Default target, runs 'run'"
	@echo "  run    : Runs analyze.sh on sample.log and saves output"
	@echo "  clean  : Removes generated output files"
	@echo "  help   : Shows this message"
