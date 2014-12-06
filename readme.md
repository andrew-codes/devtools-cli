# devtools-cli

This is a CLI written in node to automate developer tasks. This includes:

- setting up and linking dotfiles
- creating gitignore files based on a templates found on [Github](https://github.com/github/gitignore)

# Requirements

- [node](http://nodejs.org)

# Quick Start

```bash
npm install devtools-cli -g

# 1. Auto-completion in CLI
devtools-autocomplete

# 2. Initialize a user config file
devtools init --user <your-computer-user-name>

# 3. Edit the users/<your-computer-user-name>/config.js with your favorite editor

# 4. install devtools for user
devtools install --user <your-computer-user-name>
```
