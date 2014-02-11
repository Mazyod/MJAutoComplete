MJAutoComplete
==============

Simple drop-in for using autocomplete component on iOS.

### Biggest Gotcha

When you send the list of autoComplete items to the component, make sure they are AutoCompleteItem array!! Use `[MJAutoCompleteItem autoCompleteCellModelFromStrings:responseArray]` if necessary.
