#!/bin/bash
# File existence checks
if [ -f "design.sv" ]; then
echo "Design file found"
elif [ -d "src/" ]; then
echo "Source directory exists but no design file"
else
echo "Nothing found — creating project structure"
mkdir -p src/
fi
# String comparison
if [ "$USER" = "root" ]; then
echo "Running as root — be careful!"
fi
# Numeric comparison
if [ "$COUNT" -gt 100 ]; then
echo "More than 100 files"
fi
# Common test operators:
# -f file File exists and is regular file
# -d dir Directory exists
# -z str String is empty
# -n str String is non-empty
# -eq -ne -lt -le -gt -ge Numeric comparisons
# = != String comparisons
