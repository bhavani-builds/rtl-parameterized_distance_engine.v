
#!/usr/bin/env bash
set -euo pipefail

RTL="rtl/parameterized_distance_engine.v"

if [[ ! -f "$RTL" ]]; then
    echo "FAIL: RTL file not found: $RTL"
    exit 1
fi

if ! command -v verilator >/dev/null 2>&1; then
    echo "FAIL: Verilator is not installed"
    exit 1
fi

echo "Checking RTL syntax and warnings..."

verilator --lint-only -Wall --Wno-fatal "$RTL"

echo "PASS: RTL lint completed."
echo "Note: This is a lint check, not synthesis."
