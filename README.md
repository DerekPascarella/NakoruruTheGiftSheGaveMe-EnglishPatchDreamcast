#### Download the English translation patch in DCP format for use with <a href="https://github.com/DerekPascarella/UniversalDreamcastPatcher">Universal Dreamcast Patcher</a> (GDIs only, patching instructions below):
  * <a href="xxx">Nakoruru - The Gift She Gave Me (English v1.0).dcp</a>
#### Download the English translation "Bonus Disc" (more information below):
  * <a href="xxx">Nakoruru - The Gift She Gave Me (English v1.0 - Bonus Disc) [GDI].zip</a>
  * <a href="xxx">Nakoruru - The Gift She Gave Me (English v1.0 - Bonus Disc).cdi</a>
<br>
<pre>
Nakoruru: The Gift She Gave Me (Nakoruru: Ano Hito kara no Okurimono)
English Translation v1.0
Sega Dreamcast
<br>
Project Page:
<a href="https://github.com/DerekPascarella/NakoruruTheGiftSheGaveMe-EnglishPatchDreamcast">https://github.com/DerekPascarella/NakoruruTheGiftSheGaveMe-EnglishPatchDreamcast</a>
<br>

.------------------::[ Credits ]::------------------
|
| LEAD DEVELOPER / PROJECT LEAD:
| Derek Pascarella (ateam)
|
| LEAD TRANSLATORS:
| Marshal Wong
| Duralumin
|
| LEAD EDITORS:
| Lewis Cox (LewisJFC)
| Derek Pascarella (ateam)
|
| LEAD GRAPHIC ARTIST:
| Derek Pascarella (ateam)
|
| ADDITIONAL TRANSLATORS:
| Piggy (witchpiggy)
|
| ADDITIONAL GRAPHIC ARTISTS:
| Nico
| Danthrax4
|
| SPECIAL THANKS:
| Lacquerware
|
`---------------------------------------------------


.-----------::[ Patching Instructions ]::-----------
|
| The .DCP patch file shipped with this release is designed for use with
| Universal Dreamcast Patcher:
|
| https://github.com/DerekPascarella/UniversalDreamcastPatcher
|
| Note that Universal Dreamcast Patcher supports both TOSEC-style GDI and
| Redump-style CUE disc images as source input.
|
| 1) Click "Select GDI or CUE" to open the source disc image.
|
| 2) Click "Select Patch" to open the .DCP patch file.
|
| 3) Click "Apply Patch" to generate the patched GDI.
|    - The patched GDI will be generated in the folder from which the
|      application is launched.
|
| 4) Click "Quit" to exit the application.
|
`---------------------------------------------------


.------------::[ v1.0 Release Notes ]::-------------
|
| japanese title: Nakoruru: Ano Hito kara no Okurimono (ナコルル〜あのひとからのおくりもの〜)
|
| things to note:
| -tested emulators: retroarch+flycast (enable HLE bios), nulldc
| -character sprite texture fade-in/out effect is affected by fast data-read speeds
|  of ODEs. set "read_limit = 1250" in GDEMU.ini. for MODE, create mode.cfg file inside
|  game folder containing:
|      Flags=8
|      BlockDelay=4
|  ...or use menu to set seek time "on" and gdrom read speed "normal".
| -game supports vibration
| -set text speed to "instant"
| -everything is translated (images, text, menus), only thing in English was "Press
|  Start Button" on title screen
| -lyrics input minigame, went from basic Kana lesson to just teaching Japanese
|  phoenetics to the player
| -new font sheet
| -save files metadata all show in english in dc save manager in bios
| -all vmu icons translated
| -custom english logo by Nico.
| -translated VMU icon by Danthrax4 (i did the "Accessing VMU" one).
| -i did all other graphics myself.
| -quiz time-limit removed in order to allow player to research questions, as they were
|  all very Japanese/Ainu culture specific, and changing them to something Western
|  didn't blend well with the rest of the game.
| -marshal lead translation with assistance from piggy and duralumin (let all three
|  write a paragraph about the project, their backgrounds, etc.).
| -lewis was lead editor, which is one of the most important roles for delivering
|  a script that's fun for players to read.
| -ainu language/culture, special thanks to Lacquerware for helping locate old forum
|  discussing meaning of some terms.
| -unlockable content:
|	* character bios / messages from voice actors
|	* picture gallery
|   * music gallery/sound test
|   * vmu icons to download
| -bonus disc with unlocked vmu save, theme song, and OVA episode.
|   * uses dreampassport web browser, couldn't figure out how to disable screensaver,
|     so when screensaver shows up, just press a button on the d-pad to make it go
|     away.  also hope you like the screensaver!
| -disc content in repo, little clock programs, also translated (virus-free!)
| -added translation team to intro screens.
|
| custom tooling:
| -various webapps to aid the team in day-to-day tasks (script searchers, dialog box
|  previews, etc.).
| -utilities to extract script and generate spreadsheets hosted in Google Drive to
|  give team easy way to collaborate, adding DeepL translation for reference.
| -utility to insert new english script back into game, modifying various pointers and
|  offsets in order to extend to multiple textboxes to fit all of our english text.
|
`---------------------------------------------------


.-----------------::[ Changelog ]::-----------------
|
| -> 202X-XX-XX (v1.0)
|      -Initial release.
|
`---------------------------------------------------


Find me on...
 -> SegaXtreme: https://segaxtreme.net/members/ubik.21655/
 -> Dreamcast-Talk: https://www.dreamcast-talk.com/forum/memberlist.php?mode=viewprofile&u=5766
 -> GitHub: https://github.com/DerekPascarella
 -> Twitter: https://twitter.com/DerekPascarella
 -> Reddit: https://www.reddit.com/user/ate4m/
 -> YouTube: https://www.youtube.com/channel/UCLLjIeHSQbBLEooQ83SrdfQ
</pre>
