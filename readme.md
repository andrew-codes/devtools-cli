# devtools-cli

This is a CLI written in node to automate developer tasks. This includes:

- setting up and linking dotfiles
- creating gitignore files based on a templates found on [Github](https://github.com/github/gitignore)

# Requirements

- [node](http://nodejs.org)

# Quick Start

```bash
npm install devtools-cli -g

# 1. Initialize a user config file
devtools init --user <your-computer-user-name>

# 2. Edit the users/<your-computer-user-name>/config.js with your favorite editor

# 3. install devtools for user
devtools install --user <your-computer-user-name>
```
