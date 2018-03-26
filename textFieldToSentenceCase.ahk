;Macro to convert text in selected field to sentence case in Mendeley (APA style for article titles)
;Author: Taylor Williams
;Date: 2018.01.19


; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.
; Hotkey modifiers (one or more of these can be placed before a hotkey):
; 	# Windows Key
; 	! Control
; 	^ Alt
; 	+ Shift

#SingleInstance force ;this will replace the copy in memory with the one being opened


;============================================

	
;Convert text in selected field to sentence case in Mendeley (APA style for article titles)
	;In order to use this hotkey, just place the cursor within the text field you want to convert (you don't have to select or copy copy the text onto the clipboard). Then activate the hotkey. Most of the code is inside a function to prevent accidental conflicts with global variables.  (Code modified from forum at https://autohotkey.com/board/topic/24431-convert-text-uppercase-lowercase-capitalized-or-inverted/)
	;This macro accounts for capitalization of the first letter after a colon or other punctuation which APA specifies.  It does not correctly capitalize proper nouns--you will have to do that manually.

	#IfWinActive ahk_exe MendeleyDesktop.exe	;only active the following if Mendeley is the active window.  You can comment or delete this line if you want the macro to be globally active.  Alternatively you can modify the active executable filename if you use another program
	`:: 			;hotkey used to activate the macro.  You can change it to be whatever you want by modifying what comes before the ::
	{
		QuickToolTip("Running", 1500)
		Convert_Sentence()
		return
	}
	#IfWinActive	;return to allowing hotkeys activation any active window 

	
	Convert_Sentence()
	{
		Clip_Save:= ClipboardAll	;save what is currently on the clipboard
		Clipboard:= ""
		Send ^a				;optional line for when wanting to convert entire text box.  Comment or delete this line if you prefer to preselect the text to convert
		Send ^c
		FoundPos := RegExMatch(Clipboard, "\d{4}")		;look for the pattern "####".  If found, there's a good chance that the title field wasn't selected when the hotkey was activated.  This is included for safety.
		
		;if the "####" pattern is found, it likely the citation was copied to the clipboard rather than the title. Display message and exit.
		if(FoundPos != 0)
		{
			QuickToolTip("Check that the correct field is active", 1500)
			return
		}
		else
		{
			Send ^a	;select all
			StringLower, Clipboard, Clipboard		;convert the entire clipboard contents to lowercase

			;correct common uppercase situations (first char, first char after punctuation, I, and I'_).  
			;	"$U1" replaces the matching char with uppercase version of itself
			Clipboard := RegExReplace(Clipboard, "(((^|([.!?:—–]+\s+))[a-z])| i | i')", "$U1")		
				 
			;correct common abbreviation capitalizations ( "i)" sets the whole search string to be case insensitive;
			;												"\b" restricts to a word boundary; 
			;												"\dd" matches e.g. 1D, 2D, 3D)
			;convert to ALL CAPS	
			Clipboard := RegExReplace(Clipboard, "i)((MOOC)|(\bSTEM)|(\b\dD\b)|(\bBME\b)|(PBL\b)|(p12)|(p-12)|(k12)|"
												. "(k-12)|(IEEE)|(\bENE\b)|(\bR\b)|(\bNSF\b)|(\bEPICS\b)|(\bABET\b))|"
												. "(\bUSA\b)", "$U1")	 ;the . allows continuation of the previous line
															; adding the following seems to have broken something: |(\bNCEES\b))|(\bFE\b))
		 
			;capitalization special cases
			Clipboard := RegExReplace(Clipboard, "(vanth)", "VaNTH")	
			
			;remove the space before a colon
			Clipboard := RegExReplace(Clipboard, "( : )", ": ")	
			 
			Send %Clipboard%       ;type the clipboard text at the cursor location
			Len:= Strlen(Clipboard)
			;Send +{left %Len%}		;highlights the edited text
			Clipboard:= Clip_Save		;restore the clipboard contents from before this function
		}
	}

	
	
	QuickToolTip(text, delay)
	{
		ToolTip, %text%
		SetTimer ToolTipOff, %delay%
		return

		ToolTipOff:
		SetTimer ToolTipOff, Off
		ToolTip
		return
	}