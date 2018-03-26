# autohotkeyAPA_titleFixer
An autohotkey macro to convert text in selected field to sentence case (APA style for citation titles).
*Note: Autohotkey is WINDOWS only* (sorry Mac/Linux users!)

## tl;dr
* run exe file
* place text cursor inside the title text field in Mendeley or Zotero
* press the hotkey (either _pause_ or  _\`+e_)
* be amazed
* check for capitalization special cases

## General usage
In order **to use this macro**, run the .exe file (or the.ahk file if you have AutoHotkey installed: http://ahkscript.org/), place the cursor within the Mendeley text field you want to convert (you don't have to select or copy the text onto the clipboard), then activate the hotkey (set to run with the _Pause_ key or with the combination of _\`+e_ (that is, left tick--\`, above tab--and the letter 'e').  The contents of the text field will be converted to sentence case but may need some final manual adjustments for things like acronyms and proper nouns. The macro will run in the Windows taskbar, looking like a green H. To close just right click on the icon and select exit.

## Special cases
This macro does account for **capitalization** of the first letter after a colon or other punctuation which APA specifies. It does try to account for some proper nouns, acronyms, or other special cases (I've included those that I come across), but please be vigilant to see if you need to fix any manually.  I welcome pull request to add other special cases.

## Code access
The **code can be examined** by opening the .ahk file in a text editor (my code was initially inspired from the code posted at https://autohotkey.com/board/topic/24431-convert-text-uppercase-lowercase-capitalized-or-inverted/).

Within comments in the .ahk file, you will find directions for **how to modify** which key is used to active the macro or change which applications you can active the macro in.  Running the changes will require installing AutoHotkey.

Hope it helps!
