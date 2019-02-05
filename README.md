# Spielebuch
[![Build Status](https://app.bitrise.io/app/a3630b2c59177ea1/status.svg?token=M338UjA3bQXJP8OlSNY_5w&branch=master)](https://app.bitrise.io/app/a3630b2c59177ea1)

iOS app to save the results of board &amp; card games

# Development Notes
## xUnique
This project uses [xUnique](https://github.com/truebit/xUnique) to reduce merge conflicts with the Xcode project file. To automate the unification process all work is done in git hooks. Since hooks are not part of a git project, please add them manually:

Add a file `.git/hooks/pre-commit` containing:
```
#!/bin/sh

# Run xUnique --> https://github.com/truebit/xUnique
./Automation/pre-commit-xUnique
```

Add a file `.git/hooks/post-commit` containing:
```
#!/bin/sh

# Run xUnique --> https://github.com/truebit/xUnique
./Automation/post-commit-xUnique
```

Afterwards run `chmod +x` on both hooks to make them executable.

