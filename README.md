# MJAutoComplete

A simple drop-in for using an autocomplete component on iOS.

## Dependencies

+ **NONE**. ([SDWebImage](https://github.com/rs/SDWebImage) is used for demoing purposes only.)

## Challenges

### Thumbnail support

#### Problem:

After a default very simple implementation that allowed the user to lazily load the thumbnails and cache them on their side, I realized that most of the async image loading components for iOS out there are **`UIImageView` categories**. This meant that providing the user with a model object that has an image property will not be compatible with these components. I thought about embedding a component within the project, like the notorious [SDWebImage](https://github.com/rs/SDWebImage), but that meant that there will be a different internal cache for the component that I must either expose to the user, or somehow allow the user to manage/disable.

#### Solution:

The final solution I decided to go with is the removal of the thumbnail support *completely*. There is a feature in the component that allowed the user to subclass the `AutoCompleteCell`, hence customize the cell with a `UIImageView` with it's own cache. This puts more burden on the user of the component, but I think it's for the best. I am from a school of thought that supports fine-grain maintainable/replacable components rather than a huge monolithic component that just tries to do everything.

## Biggest Gotcha

When you send the list of autoComplete items to the component, make sure they are AutoCompleteItem array!! Use `[MJAutoCompleteItem autoCompleteCellModelFromStrings:responseArray]` if necessary.

## Special Thanks

+ The awesome [SDWebImage component](https://github.com/rs/SDWebImage), used for demo purpose only.
