#!/bin/bash

set -euo pipefail

usage() {
    echo "Usage: $0 <log_file>"
    exit 1
}

analyze_log() {
    local input_file=$1
    
    echo "--- FEATURE BRANCH ANALYSIS ---"

    total=$(grep -c "TEST" "$input_file" || echo 0)
    passed=$(grep -c "TEST PASS" "$input_file" || echo 0)
    failed=$(grep -c "TEST FAIL" "$input_file" || echo 0)

    pass_rate=$(awk -v p="$passed" -v t="$total" 'BEGIN {if (t>0) printf "%.2f", (p/t)*100; else print "0"}')

    echo "Total Tests: $total"
    echo "Passed: $passed"
    echo "Failed: $failed"
    echo "Pass Rate: $pass_rate%"

    if [ "$failed" -gt 0 ]; then
        echo "Status: CRITICAL (Failures detected)"
        exit 1
    else
        echo "Status: SUCCESS (All tests passed)"
        exit 0
    fi
}

if [ $# -ne 1 ]; then
    usage
fi
