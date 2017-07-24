# MagicMirror-Module-Template
This is a module to help developers to start building their own modules for the [MagicMirror](https://github.com/MichMich/MagicMirror). 

There samples of code for:
- External request
- Config parameters
- Custom URL path route
- Passing of messages (NOTIFICATIONS)

Also this module include tasks for checking your code. For that you need install the developer dependencies.

```
cd MI_MODULE_PATH && npm install 
```

Run the `test` npm script
```
npm test
```

Current Tests:
- [ESLint](http://eslint.org/) for linting the javascript
- [stylelint](https://stylelint.io/) for linting the CSS with [stylelint-config-standard](https://github.com/stylelint/stylelint-config-standard) as its base
- [jsonlint](https://github.com/zaach/jsonlint) for linting the translation files
- [markdownlint](https://github.com/DavidAnson/markdownlint) for checking the markdown files (`README.md`, `CHANGELOG.md`, `LICENSE.txt`)
- [js-yaml](https://github.com/nodeca/js-yaml) to lint the `.travis.yml` (run through [grunt-yamllint](https://github.com/geedew/grunt-yamllint))


## Installation

`bash -c "$(curl -sL https://raw.githubusercontent.com/roramirez/MagicMirror-Module-Template/master/create_module.sh)"`

This creates a module example to start your development more easy.

If you have any suggest, please let me know [by an issue](https://github.com/roramirez/MagicMirror-Module-Template/issues/new).
