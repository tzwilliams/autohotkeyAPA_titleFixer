# autohotkeyAPA_titleFixer
An autohotkey macro to convert text in selected field to sentence case (APA style for citation titles).  
*Note: Autohotkey is WINDOWS only* (sorry Mac/Linux/ChromeOS/etc. users!)

Author: Taylor Williams

## tl;dr
1. download [textFieldToSentenceCase.exe](https://github.com/tzwilliams/autohotkeyAPA_titleFixer/blob/master/textFieldToSentenceCase.exe)
1. run exe file
1. place text cursor inside the title text field in Mendeley or Zotero
1. press the hotkey (either **pause** or  **\`+e**)
1. be amazed
1. check for capitalization special cases

## General usage
### Download
Unfortunately GitHub doesn't make it easy to download a single file. Most users will only need the .exe file.  (See *Downloading the ahk file* below for those instructions.)
Follow these steps to __download the .exe file__.
1. Click on the file you want to download: [textFieldToSentenceCase.exe](https://github.com/tzwilliams/autohotkeyAPA_titleFixer/blob/master/textFieldToSentenceCase.exe).
1. In the top right, right click the _Download_ button.

### Run and use
In order **to use this macro**, run the .exe file (or the.ahk file if you have AutoHotkey installed: http://ahkscript.org/), place the cursor within the Mendeley text field you want to convert (you don't have to select or copy the text onto the clipboard), then activate the hotkey (set to run with the _Pause_ key or with the combination of _\`+e_ (that is, left tick--\`, above tab--and the letter 'e').  The contents of the text field will be converted to sentence case but may need some final manual adjustments for things like acronyms and proper nouns. The macro will run in the Windows taskbar, looking like a green H. To close just right click on the icon and select exit.

## Special cases
This macro does account for **capitalization** of the first letter after a colon or other punctuation which APA specifies. It does try to account for some proper nouns, acronyms, or other special cases (I've included those that I come across*), but please be vigilant to see if you need to fix any manually.  To contribute updates for your special cases, I welcome submitted pull requests or GitHub issues.

## Troubleshooting
There is a known bug where the script will occationally place what is on the clipboard into the text field rather than the edited contents of that text field.  If this happens then perform an undo command (ctrl/cmd+z) and try the hotkey again.

## Code access
### Downloading the ahk file
Follow these steps to __download the .ahk file__.
1. Go to the file you want to download: [textFieldToSentenceCase.ahk](https://github.com/tzwilliams/autohotkeyAPA_titleFixer/blob/master/textFieldToSentenceCase.ahk).  This opens the file in the GitHub UI.
1. Click it to view the contents within the GitHub UI.
1. In the top right, right click the _Raw_ button.
1. Right click anywhere, select Save as...

### Modifying the code
The **code can be examined** (and then edited) by opening the .ahk file in a text editor (my code was initially inspired from the code posted at https://autohotkey.com/board/topic/24431-convert-text-uppercase-lowercase-capitalized-or-inverted/).  

Within comments in the .ahk file, you will find directions for **how to modify** which key is used to active the macro or change which applications you can active the macro in.  Running the changes will require installing AutoHotkey.

Hope it helps!

## Notes
* Below are the special cases the script looks for as of 29 Sept 2018 (this is copied from the autohotkey script, so look between the "/b" bookends for acronymns).
```
;correct common capitalizations ( "i)" sets the whole search string to be case insensitive;
;				"\b" restricts to a word boundary;
;				"\dD" matches e.g. 1D, 2D, 3D)
	;convert to ALL CAPS	;(Note, this is broken into multiple separate lines
				; because errors were being introduced when all entries
				; were in a single command)
	Clipboard := RegExReplace(Clipboard, "i)((MOOC)|(\bSTEM)|(\b\dD\b)|(\bBME\b)|(\bIQ\b)|(\bIRT\b)|(\bSEM\b))", "$U1")
	Clipboard := RegExReplace(Clipboard, "i)((PBL\b)|(P12)|(P-12)|(K12)|(K-12)|(IEEE)|(\bENE\b))", "$U1")
	Clipboard := RegExReplace(Clipboard, "i)((\bR\b)|(\bNSF\b)|(\bEPICS\b)|(\bABET\b)|(\bAERA\b)|(\bLTS\b))", "$U1")
	Clipboard := RegExReplace(Clipboard, "i)((\bJSON\b)|(\bNCEES\b)|(\bFE\b)|(\bUSA\b)|(\bANN\b))", "$U1")
	Clipboard := RegExReplace(Clipboard, "i)((\bHMM\b)|(\bEDM\b)|(\bLA\b)|(\bLAK\b)|(\bLMS\b)|(\bMATLAB\b))", "$U1")
	Clipboard := RegExReplace(Clipboard, "i)((\bEEG\b)|(\bEKG\b)|(\bECG\b)|(\bEMG\b)|(\bNSSE\b)|(\bXML\b))", "$U1")
	Clipboard := RegExReplace(Clipboard, "i)((\bI\b)|(\bII\b)|(\bIII\b)|(\bIV\b)|(\bV\b))", "$U1")
	Clipboard := RegExReplace(Clipboard, "i)((\bVI\b)|(\bVII\b)|(\bVIII\b)|(\bIX\b)|(\bX\b))", "$U1")
	Clipboard := RegExReplace(Clipboard, "i)((\bXI\b)|(\bXII\b)|(\bXIII\b)|(\bXIV\b)|(\bXV\b))", "$U1")


	;capitalization special cases
	Clipboard := RegExReplace(Clipboard, "(vanth)", "VaNTH")
	Clipboard := RegExReplace(Clipboard, "(markov)", "Markov")
	Clipboard := RegExReplace(Clipboard, "(google)", "Google")
	Clipboard := RegExReplace(Clipboard, "(bayes)", "Bayes")
	Clipboard := RegExReplace(Clipboard, "(python)", "Python")
	Clipboard := RegExReplace(Clipboard, "(american)", "American")
	Clipboard := RegExReplace(Clipboard, "(america)", "America")
	Clipboard := RegExReplace(Clipboard, "(kenya)", "Kenya")
	Clipboard := RegExReplace(Clipboard, "(nairobi)", "Nairobi")
	Clipboard := RegExReplace(Clipboard, "(kakuma)", "Kakuma")
	Clipboard := RegExReplace(Clipboard, "(n-tarp)", "n-TARP")
	Clipboard := RegExReplace(Clipboard, "(edx)", "edX")
	Clipboard := RegExReplace(Clipboard, "(futurelearn)", "FutureLearn")
```

