# General shell functions

# Environment variable loader
# Usage: getenv [path/to/.env]
# Loads environment variables from a .env file and exports them to the current session
getenv() {
    local env_file="${1:-.env}"

    if [[ ! -f "$env_file" ]]; then
        echo "Error: .env file not found: $env_file" >&2
        return 1
    fi

    echo "Loading environment variables from: $env_file"

    # Read the file line by line
    while IFS= read -r line || [[ -n "$line" ]]; do
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

        # Remove inline comments and trim whitespace
        line="${line%%#*}"
        line="${line#"${line%%[![:space:]]*}"}"  # trim leading whitespace
        line="${line%"${line##*[![:space:]]}"}"  # trim trailing whitespace

        # Skip if line is now empty
        [[ -z "$line" ]] && continue

        # Export the variable
        export "$line"
    done < "$env_file"

    echo "Environment variables loaded successfully"
}
