#!/bin/bash

echo "Initializing the project..."

if [ ! -f package.json ]; then
  npm init -y
fi

if ! grep -q "script.sh" .gitignore; then
  echo "script.sh" >> .gitignore
  echo "Added script.sh to .gitignore to ignore it from Git tracking"
fi

if ! grep -q "node_modules" .gitignore; then
  echo "node_modules" >> .gitignore
  echo "Added node_modules to .gitignore"
fi

echo "Installing ESLint and lint-staged"
npm install --save-dev eslint lint-staged

echo "Configuring ESLint..."
npx eslint --init

echo "Adding Git hooks..."

cat <<EOF > .git/hooks/pre-commit
#!/bin/bash
npx lint-staged
EOF
chmod +x .git/hooks/pre-commit

cat <<EOF > .git/hooks/commit-msg
#!/bin/bash

msg=$(cat "$1")

types="feat|fix|docs|style|refactor|test|chore"

# Pattern: type(scope): message
pattern="^(${types})\([a-z0-9\-]+\): .{1,}$"

if echo "$msg" | grep -qE "$pattern"; then
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

cat <<EOF > .git/hooks/post-commit
#!/bin/bash
echo "Commit successfully made!"
EOF
chmod +x .git/hooks/post-commit

cat <<EOF > .git/hooks/post-merge
#!/bin/bash
echo "Restoring dependencies after merge..."
npm install
EOF
chmod +x .git/hooks/post-merge

echo "Configuring lint-staged..."
if ! grep -q "lint-staged" package.json; then
  jq '. + { "lint-staged": { "*.{js,jsx,ts,tsx}": ["eslint --fix"] } }' package.json > tmp.json && mv tmp.json package.json
  echo "Added lint-staged configuration to package.json"
fi
npx npm set-script lint "eslint ."

cat <<EOF > lint-staged.config.js
module.exports = {
  "*.{js,jsx,ts,tsx}": ["eslint --fix"],
};
EOF

echo "Installation complete!"
