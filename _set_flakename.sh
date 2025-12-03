#!/usr/bin/env bash
OPTIONS=("default" "yoga12")
DEFAULT_OPTION="default"

echo "Please select an option:"
for opt in "${OPTIONS[@]}"; do
    if [[ "$opt" == "$DEFAULT_OPTION" ]]; then
        echo "  - $opt (default)"
    else
        echo "  - $opt"
    fi
done

# Prompt for input
read -p "Enter your choice (default: $DEFAULT_OPTION): " USER_INPUT

# If $USER_INPUT is unset or empty, use $DEFAULT_OPTION instead.
FLAKE_NAME="${USER_INPUT:-$DEFAULT_OPTION}"

# Check if FLAKE_NAME in OPTIONS
for opt in "${OPTIONS[@]}"; do
    if [[ "$opt" == "$FLAKE_NAME" ]]; then
        return 0
    fi
done
echo "Invalid selection '$FLAKE_NAME'"
return 1
