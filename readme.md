# Project Initialization Scripts

This repository contains two initialization scripts: `python.sh` and `node.sh`. These scripts automate the setup and configuration of Python and Node.js projects, including virtual environments, linting, Git hooks, and more.

---

## python.sh

### Purpose

`python.sh` sets up a Python project by creating a virtual environment, installing `flake8` for linting, and configuring Git hooks for pre-commit checks, commit message validation, and post-merge dependency installation.

### Features

1. **Interactive Python Command Selection**: 
   - The script prompts you to specify which Python command to use (e.g., `python`, `python3`, or `py`).
   
2. **Virtual Environment Setup**: 
   - If a virtual environment does not already exist, the script creates one using the specified Python command.
   
3. **flake8 Linting Setup**: 
   - Installs `flake8` for Python code linting and configures it with a maximum line length of 79 characters.
   
4. **Git Hooks**:
   - Creates the following Git hooks:
     - **pre-commit**: Runs `flake8` to ensure code quality before each commit.
     - **commit-msg**: Enforces a commit message format using a regular expression (e.g., `feat(auth): add login`).
     - **post-commit**: A simple message confirming that the commit was successfully made.
     - **post-merge**: Automatically installs dependencies after a merge by running `pip install -r requirements.txt`.
   
5. **Git Ignore Setup**:
   - Automatically adds `venv` to the `.gitignore` file to exclude the virtual environment from version control.

### How to Use

1. Clone this repository or navigate to the project directory.
2. Run the `python.sh` script:
   ```bash
   ./python.sh
   ```
3. Follow the prompt to select your Python command.

The script will set up the virtual environment, install necessary packages, and configure Git hooks.

---

## node.sh

### Purpose

`node.sh` sets up a Node.js project by initializing npm, installing eslint and lint-staged, and configuring Git hooks for pre-commit checks, commit message validation, and post-merge dependency installation.

### Features

1. **npm Initialization**:
   - The script initializes a new Node.js project if `package.json` does not exist.

2. **Git Ignore Setup**:
   - Automatically adds `node_modules` and `script.sh` to the `.gitignore` file to exclude dependencies and script files from version control.

3. **ESLint Setup**:
   - Installs `eslint` for linting JavaScript and TypeScript files.
   - Runs `npx eslint --init` to configure ESLint according to the project's needs.

4. **lint-staged Setup**:
   - Installs and configures `lint-staged` to run ESLint automatically on staged files before committing.
   - Modifies the `package.json` to include the `lint-staged` configuration.

5. **Git Hooks**:
   - Creates the following Git hooks:
     - **pre-commit**: Runs `lint-staged` to lint staged files before committing.
     - **commit-msg**: Enforces a commit message format using a regular expression (e.g., `feat(auth): add login`).
     - **post-commit**: A simple message confirming that the commit was successfully made.
     - **post-merge**: Automatically installs dependencies after a merge by running `npm install`.

### How to Use

1. Clone this repository or navigate to the Node.js project directory.
2. Run the `node.sh` script:
   ```bash
   ./node.sh
   ```
3. The script will set up the project, configure linting, and add the necessary Git hooks.

---

## Common Requirements

- **Bash**: These scripts are written for Unix-like environments and should be executed in a Bash-compatible shell (e.g., Linux, macOS, or WSL on Windows).
- **Git**: The scripts assume that the project is version-controlled with Git and that you have the necessary permissions to modify Git hooks.

---

## Troubleshooting

1. **Permission issues**:
   - If you encounter permission issues when trying to run the scripts, make sure they are executable:
     ```bash
     chmod +x python.sh node.sh
     ```

2. **Missing Dependencies**:
   - If a command is not found, make sure that the required tools (e.g., Python, npm, Git) are installed on your system.

---

## Conclusion

These scripts automate the setup and configuration of Python and Node.js projects, making it easier to establish best practices (such as linting and commit message conventions) and maintain project consistency. Simply run the appropriate script, and you're all set to start working with the project

HF! 