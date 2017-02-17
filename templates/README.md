# {{MODULE_NAME}}

This is project the [MagicMirror²](https://github.com/MichMich/MagicMirror/).

## Configuration options
| Option           | Description
|----------------- |-----------
| `option1`        | *Required* DESCRIPTION HERE
| `option2`        | *Optional* DESCRIPTION HERE TOO <br><br>**Type:** `int`(milliseconds) <br>Default 60000 milliseconds (1 minute)



## Using the module
To use this module, add the following configuration block to the modules array in the `config/config.js` file:
```js
var config = {
    modules: [
        {
            module: '{{MODULE_NAME}}',
            config: {
                // See below for configurable options
            }
        }
    ]
}
```
