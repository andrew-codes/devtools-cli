# devtools

This is a CLI written in node to automate developer tasks. This includes:

- setting up and linking dotfiles
- creating gitignore files based on a templates found on [Github](https://github.com/github/gitignore)

# Requirements

- [git](http://git-scm.com)
- [node](http://nodejs.org)

# Quick Start

```bash
npm install devtools-cli -g

# 1. Initialize a user config file
devtools init --user <your-name>

# 2. Edit the your-name.config.js with your favorite editor

# 3. install devtools for user
devtools install --user <your-name>
```
