;Macro to convert text in selected field to sentence case in Mendeley (APA style for article titles)
;Author: Taylor Williams


; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.
; Hotkey modifiers (one or more of these can be placed before a hotkey):
; 	# Windows Key
; 	! Control
; 	^ Alt
; 	+ Shift

#SingleInstance force ;this will replace the copy in memory with the one being opened


;------------app functions
QuickToolTip(text, delay := 2000){
	ToolTip, %text%
	SetTimer ToolTipOff, %delay%
	return

	ToolTipOff:
	SetTimer ToolTipOff, Off
	ToolTip
	return
}
Toast(text, delay := 2000){
	QuickToolTip(text, delay)
}

;============================================

;Convert text in selected field to sentence case in Mendeley or Zotero (APA style for article titles)
	;In order to use this hotkey, just place the cursor within the text field you want to convert (you don't have to select or copy copy the text onto the clipboard). Then activate the hotkey. Most of the code is inside a function to prevent accidental conflicts with global variables.  (Code modified from forum at https://autohotkey.com/board/topic/24431-convert-text-uppercase-lowercase-capitalized-or-inverted/)
	;This macro accounts for capitalization of the first letter after a colon or other punctuation which APA specifies.  It will try to capitalize some common acronyms. It does not correctly capitalize proper nouns--you will have to do that manually.


	;only active the following if Mendeley or Zotero is the active window.  You can comment or delete this line if you want the macro to be globally active.  Alternatively you can modify the active executable filename if you use another program
	#IfWinActive ahk_exe MendeleyDesktop.exe
		` & e:: 	;hotkey used to activate the macro.  You can change it to be whatever you want by modifying what comes before the ::
		Pause::		;alternate hotkey
	#IfWinActive ahk_exe zotero.exe
		` & e:: 	;hotkey used to activate the macro.  You can change it to be whatever you want by modifying what comes before the ::
		Pause::		;alternate hotkey
	{
		ConvertToSentenceCase()
		return
	}
	#IfWinActive	;return to allowing hotkeys activation any active window

	
	;Alternate method if Zotero or Mendeley can not be used.  Copy the text then press ctrl+alt+shift+T
	!^+T::
		InputBox, inText, Input text to convert to APA, Provide the text you want converted to APA.  The results will be on the clipboard (for you to paste as needed)., ,,,,,,, %Clipboard%

		;run converter only if "OK" was pressed
		if(ErrorLevel = 0){
			Clipboard := ConvertToSentenceCase(inText)
		}
		return

	
	;Conversion function for APA formatting
	ConvertToSentenceCase(inText := "")
	{
		;enable or disable troubleshooting messages
			troubleshootingMode := 0		;enable (1) to see tool tips with the current clipboard status at key points in the script
			sleepStd := 20		;ms for script to pause at several moments in order to prevent errors
			

			Clip_Save:= ClipboardAll	;save what is currently on the clipboard		
			
			if(inText == ""){ ;if no text passed to the function then get text from the cursor's location

					Clipboard:= ""			;clear the clipboard
					Send ^a				;optional line for when wanting to convert entire text box.  Comment or delete this line if you prefer to preselect the text to convert
					sleep, 50
					Send ^c

				;show troubleshooting messages if enabled
				if(troubleshootingMode = 1){
					QuickToolTip(Clipboard, 500)
					sleep, 500
					QuickToolTip("*", 200)
					sleep, sleepStd
				}

				;look for the pattern "####".  If found, there's a good chance that the title field wasn't selected when the hotkey was activated.  This is included for safety.
					foundYear := RegExMatch(Clipboard, "\d{4}")

				;if the "####" pattern is found, it likely the citation was copied to the clipboard rather than the title. Display message and exit. 
					if(foundYear != 0){
						QuickToolTip("Check that the correct field is active", 750)
						Send, {Up}
						Send, {Down}

						return
					}
			
				if(troubleshootingMode = 1){
					QuickToolTip(Clipboard, 500)
					sleep, 500
					QuickToolTip("**", 200)
					sleep, 200
				}

		
				Send ^a	;select all
				Send ^c

			}else{
				Clipboard:= inText
			}
			
			
			
			sleep, sleepStd
			StringLower, Clipboard, Clipboard		;convert the entire clipboard contents to lowercase


			Clipboard := RegExReplace(Clipboard, "^( )+", "")	;removing any leading spaces

			sleep, sleepStd
			;correct common uppercase situations (first char, first char after punctuation, I, and I'_).
			;	"$U1" replaces the matching char with uppercase version of itself
			Clipboard := RegExReplace(Clipboard, "(((^|([.!?:—–]+\s+))[a-z])| i | i')", "$U1")

					if(troubleshootingMode = 1){
						QuickToolTip(Clipboard, 500)
						sleep, 500
						QuickToolTip("***", 200)
						sleep, 200
					}


				sleep, sleepStd
				;correct common capitalizations ( "i)" sets the whole search string to be case insensitive;
				;												"\b" restricts to a word boundary;
				;												"\dD" matches e.g. 1D, 2D, 3D)
					;the . allows continuation of the previous line (but caused problems, so it isn't used)
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

					if(troubleshootingMode = 1){
						QuickToolTip(Clipboard, 500)
						sleep, 500
						QuickToolTip("****", 200)
						sleep, 200
					}

				sleep, sleepStd
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



					sleep, sleepStd
					;remove spacing and punctuation errors
					Clipboard := RegExReplace(Clipboard, "( : )", ": ")	;space before a colon
					Clipboard := RegExReplace(Clipboard, "( \?)", "?")	;space before a question mark
					Clipboard := RegExReplace(Clipboard, "( \.)", ".")	;space before a period
					Clipboard := RegExReplace(Clipboard, "( , )", ", ")	;space before a comma
					Clipboard := RegExReplace(Clipboard, "( , )", ", ")	;space before a comma
			;		Clipboard := RegExReplace(Clipboard, "( `( )", " (")	;space after opening paren
			;		Clipboard := RegExReplace(Clipboard, "( `) )", ") ")	;space before closing paren
			;		Clipboard := RegExReplace(Clipboard, "( :.)", ": ")	;space before a colon
					Clipboard := RegExReplace(Clipboard, "(  )", " ")	;double space
					Clipboard := RegExReplace(Clipboard, "( ' )", "' ")	;plural possessive space
					Clipboard := RegExReplace(Clipboard, "( ’ )", "' ")	;plural possessive space
					Clipboard := RegExReplace(Clipboard, "(’)", "'")	;consistent apostrophe symbol
					Clipboard := RegExReplace(Clipboard, "(”)", """")	;consistent quote symbol
					Clipboard := RegExReplace(Clipboard, "( )+$", "")	;removing end of string spaces (one or more)
					Clipboard := RegExReplace(Clipboard, "(\.)$", "")	;removing end of string period
					Clipboard := RegExReplace(Clipboard, "(&amp;)", "&")	;correcting '&' error sometimes present

			if(troubleshootingMode = 1){
				QuickToolTip(Clipboard, 500)
				sleep, 500
				QuickToolTip("*****", 200)
				sleep, 200
			}

			
			outText := Clipboard	;store the converted text
			sleep, sleepStd
		
			if(inText = ""){
				SendInput %outText%
				Clipboard := Clip_Save	;restore the clipboard contents from before this function
				return  ;exit ConvertToSentenceCase()
			}else{
				return %outText%  ;exit ConvertToSentenceCase()
			}
			
	} ;end convert case function
