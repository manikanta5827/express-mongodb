
#!/bin/bash

# Detect OS
detect_os() {
  case "$(uname -s)" in
    Linux*)     OS="Linux";;
    Darwin*)    OS="Mac";;
    CYGWIN*|MINGW*) OS="Windows";;
    *)          OS="UNKNOWN"
  esac
}

log_os() {
  echo "Detected Operating System: $OS"
}

# Create target directory
create_folder() {
  if [ -d "$1" ]; then
    echo "Directory $1 already exists. Exiting..."
    exit 1
  fi
  mkdir "$1"
}

# Copy template files
copy_files() {
  if [[ "$OS" == "Linux" || "$OS" == "Mac" ]]; then
    echo "Copying files for $OS..."
    cp -r ./templates/* "$1"
  elif [[ "$OS" == "Windows" ]]; then
    echo "Copying files for Windows..."
    xcopy /E /I .\templates\* "$1"
  fi
}

# Install npm dependencies
# Install npm dependencies
install_dependencies() {
  echo "Installing npm dependencies in $1..."
  cd "$1" 
  npm init -y 
  npm install compression cors dotenv express mongoose 
  npm install morgan nodemon -D
  
  # Set type=module and main=app.js using jq if available
  if command -v jq &> /dev/null; then
    jq '.type = "module" | .main = "app.js" | .scripts.start = "node app.js" | .scripts.dev = "nodemon app.js"' package.json > package.tmp.json
    mv package.tmp.json package.json
  else
    # If jq is not available, fallback to using sed for script modification
    sed -i '' 's/"main": "index.js"/"main": "app.js"/' package.json
    sed -i '' '/"scripts": {/a\
    "start": "node app.js",\
    "dev": "nodemon app.js",
    ' package.json
    sed -i '' '/"version":/a\
    "type": "module",
    ' package.json
  fi
}


function print_console_message(){
  echo "Manisha has successfully created a new Express.js project in $1."
  echo "To start your project, navigate to $1 and run:"
  echo "npm start"
  echo "or"
  echo "npm run dev"
  echo "for development mode."
}

# Main function
main() {
  detect_os
  log_os
  create_folder "$1"
  copy_files "$1"
  install_dependencies "$1"
  print_console_message
}

# Entry point
if [ -z "$1" ]; then
  echo "Usage: manisha <folder-name>"
  exit 1
fi

main "$1"
