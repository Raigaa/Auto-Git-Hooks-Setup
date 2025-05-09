#!/bin/bash

echo "Initializing the Python project..."
echo "Which Python command should be used? (python, python3, py)"
read PYTHON_CMD

if [[ ! "$PYTHON_CMD" =~ ^(python|python3|py)$ ]]; then
  echo "Invalid input. Please choose from 'python', 'python3', or 'py'."
  exit 1
fi

if [ ! -d "venv" ]; then
  echo "Creating virtual environment..."
  $PYTHON_CMD -m venv venv
  echo "Virtual environment created."
fi

echo "Activating virtual environment..."
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
  source venv/bin/activate
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]]; then
  source venv/Scripts/activate
fi

echo "Installing flake8..."
pip install flake8

if [ ! -f .gitignore ]; then
  touch .gitignore
fi

if ! grep -q "venv" .gitignore; then
  echo "venv" >> .gitignore
  echo "Added venv to .gitignore"
fi

echo "Configuring flake8..."
cat <<EOF > setup.cfg
[flake8]
max-line-length = 79
EOF
echo "flake8 configuration created in setup.cfg"

echo "Creating pre-commit hook..."
cat <<EOF > .git/hooks/pre-commit
#!/bin/bash
echo "Running flake8..."
flake8
if [ \$? -ne 0 ]; then
  echo "Linting errors found. Commit aborted!"
  exit 1
fi
EOF
chmod +x .git/hooks/pre-commit

echo "Creating commit-msg hook..."
cat <<EOF > .git/hooks/commit-msg
#!/bin/bash

msg=\$(cat "\$1")

types="feat|fix|docs|style|refactor|test|chore"

# Pattern: type(scope): message
pattern="^(${types})\([a-z0-9\-]+\): .{1,}$"

if echo "\$msg" | grep -qE "\$pattern"; then
  echo "Valid commit message."
  exit 0
else
  echo "Invalid format!"
  echo "Use: type(scope): message"
  echo "Example: feat(auth): add login"
  exit 1
fi
EOF
chmod +x .git/hooks/commit-msg

echo "Creating post-commit hook..."
cat <<EOF > .git/hooks/post-commit
#!/bin/bash
echo "Commit successfully made!"
EOF
chmod +x .git/hooks/post-commit

echo "Creating post-merge hook..."
cat <<EOF > .git/hooks/post-merge
#!/bin/bash
echo "Restoring dependencies after merge..."
pip install -r requirements.txt
EOF
chmod +x .git/hooks/post-merge

echo "Installation complete!"
