# MJAutoComplete

A simple drop-in for using an autocomplete component on iOS.

## Biggest Gotcha

When you send the list of autoComplete items to the component, make sure they are AutoCompleteItem array!! Use `[MJAutoCompleteItem autoCompleteCellModelFromStrings:responseArray]` if necessary.

## Special Thanks

+ Thanks to Nick Lockwood for his great [AsyncImageView component](https://github.com/nicklockwood/AsyncImageView).
