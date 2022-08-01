<h1>Nakoruru: The Gift She Gave Me</h1>
<img width="165" height="165" align="right" src="https://i.imgur.com/MDOLCgw.png">Download the English translation patch in DCP format for use with <a href="https://github.com/DerekPascarella/UniversalDreamcastPatcher">Universal Dreamcast Patcher</a> v1.3 or newer:
<ul>
 <li><a href="xxx">Nakoruru - The Gift She Gave Me (English v1.0).dcp</a></li>
</ul>
Download the English translation "Bonus Disc" (more information below):
<ul>
 <li><a href="xxx">Nakoruru - The Gift She Gave Me (English Translation Bonus Disc) [GDI].zip</a></li>
 <li><a href="xxx">Nakoruru - The Gift She Gave Me (English Translation Bonus Disc).cdi</a></li>
</ul>
<h2>Table of Contents</h2>

1. [Patching Instructions](#patching-instructions)
2. [Credits](#credits)
3. [About the Game](#about-the-game)
4. [About the Project](#about-the-project)
5. [What's Changed](#whats-changed)
6. [A Note on Emulators and ODEs](#a-note-on-emulators-and-odes)
7. [Controls](#controls)
8. [Bonus Disc](#bonus-disc)
9. [VMU Applications](#vmu-applications)
10. [Disc Content](#disc-content)
11. [Disc and Box Art](#disc-and-box-art)
12. [Known Issues](#known-issues)
13. [Messages From the Team](#messages-from-the-team)

<h2>Patching Instructions</h2>
<img align="right" width="250" src="https://github.com/DerekPascarella/UniversalDreamcastPatcher/blob/main/screenshots/screenshot.png?raw=true">The DCP patch file shipped with this release is designed for use with <a href="https://github.com/DerekPascarella/UniversalDreamcastPatcher">Universal Dreamcast Patcher</a>.  Note that Universal Dreamcast Patcher supports both TOSEC-style GDI and Redump-style CUE disc images as source input.
<br><br>
<ol type="1">
 <li>Click "Select GDI or CUE" to open the source disc image.</li>
 <li>Click "Select Patch" to open the .DCP patch file.</li>
 <li>Click "Apply Patch" to generate the patched GDI.  The patched GDI will be generated in the folder from which the application is launched</li>
 <li>Click "Quit" to exit the application.</li>
</ol>

<h2>Credits</h2>
<ul>
 <li><b>Lead Developer / Project Lead:</b></li>
  <ul>
   <li>Derek Pascarella (ateam)</li>
  </ul>
 <br>
 <li><b>Lead Translators</b>:</li>
  <ul>
   <li>Marshal Wong</li>
   <li>Duralumin</li>
  </ul>
 <br>
 <li><b>Lead Editors:</b></li>
  <ul>
   <li>Lewis Cox (LewisJFC)</li>
   <li>Derek Pascarella (ateam)</li>
  </ul>
 <br>
 <li><b>Lead Graphic Artist</b>:</li>
  <ul>
   <li>Derek Pascarella (ateam)</li>
  </ul>
 <br>
 <li><b>Additional Translators:</b></li>
  <ul>
   <li>Piggy (witchpiggy)</li>
  </ul>
 <br>
 <li><b>Additional Graphic Artists</b>:</li>
  <ul>
   <li>Nico</li>
   <li>Danthrax4</li>
  </ul>
 <br>
  <li><b>Special Thanks:</b></li>
  <ul>
   <li>Lacquerware</li>
   <li>EsperKnight</li>
   <li>SnowyAria</li>
   <li>VincentNL</li>
   <li>cyo</li>
   <li>HaydenKow</li>
  </ul>
</ul>

<h2>About the Game</h2>
Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec viverra orci. Quisque id mollis dui, eu imperdiet ligula. Fusce id risus vel elit pulvinar maximus. Aenean tincidunt neque et libero hendrerit, sit amet pulvinar nulla ornare. Cras semper egestas elit, sed posuere nunc.
<br><br>
Quisque ut risus ac risus dictum ultricies. Phasellus id mauris eget mauris pretium consectetur. Nullam ut placerat lectus, nec iaculis enim. Phasellus porttitor pellentesque arcu, laoreet placerat massa sollicitudin et. Integer vel justo at lorem dictum finibus. Nam posuere consequat est, sit amet faucibus magna varius at.

<h2>About the Project</h2>
Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec viverra orci. Quisque id mollis dui, eu imperdiet ligula. Fusce id risus vel elit pulvinar maximus. Aenean tincidunt neque et libero hendrerit, sit amet pulvinar nulla ornare. Cras semper egestas elit, sed posuere nunc.
<br><br>
Quisque ut risus ac risus dictum ultricies. Phasellus id mauris eget mauris pretium consectetur. Nullam ut placerat lectus, nec iaculis enim. Phasellus porttitor pellentesque arcu, laoreet placerat massa sollicitudin et. Integer vel justo at lorem dictum finibus. Nam posuere consequat est, sit amet faucibus magna varius at.

<h2>What's Changed</h2>
Below is a high-level list of changes implemented for this English translation patch.
<br><br>
<ul>
 <li>All 12,000+ lines of Japanese dialog text have been translated.</li>
 <li>All menus, textures/images, and minigames have been translated, re-rendered, and rebuilt.</li>
  <ul>
   <li>Previously, the only English asset in this game was the "Press Start Button" text on the title.</li>
  </ul>
 <li>All VMU icons and applications have been translated.</li>
 <li>All VMU save and application metadata appear in English on the Dreamcast's BIOS menu save manager.</li>
 <li>The "Learn the Lyrics" minigame previously functioned as a basic Kana lesson for players, and has been modified to teach the player the Ainu phonetics for Nakoruru's "secret song".</li>
 <li>A new font sheet was created, along with new SH4 assembly code to support narrower glyph tiles and all related modifications.</li>
 <li>Quiz minigame timer removed to give players time to research answers for each question.</li>
 <li>Voiced acted dialog audio persists across multiple dialog boxes as to not be prematurely halted when English text consumes more than a single dialog box.</li>
</ul>

<h2>A Note on Emulators and ODEs</h2>
<img align="right" src="https://i.imgur.com/PbVgeuJ.jpg" width="180">Throughout the development of this translation patch, testing was performed across the spectrum of both emulators and ODEs, as well as optical disc.  Interestingly, this game (both in its original form and in its patched form) has one very mild issue when played via emulator or some ODEs, causing a texture flicker in between screen transitions.  When this occurs, the on-screen character(s) will flicker slightly before fading away with the scene transition.  It's the result of faster data-read speeds than developers originally intended when played via GD-ROM.  Please understand that this is in no way a game-breaking issue, and is strictly cosmetic.  Furthermore, those playing this game on an optical disc (i.e., a CDI burned to a CD-R) will not experience this texture flicker.
<br><br>
The solution to said problem is to artificially limit the speed at which data is read from the disc image in order to more closely mimic the performance of a GD-ROM.  While achievable on ODEs, I've yet to find such a setting in any emulators used during development and testing (Flycast, Demul, and NullDC).  Below are the configurations required to impose the required data-read limit.
<br><br>
<ul>
<li><b>GDEMU</b></li>
Add the <tt>read_limit</tt> parameter with a value of <tt>1250</tt> to the <tt>GDEMU.ini</tt> configuration file in the root of the SD card (<a href="https://github.com/DerekPascarella/NakoruruTheGiftSheGaveMe-EnglishPatchDreamcast/blob/main/ode_configs/GDEMU.ini">see example configuration file here</a>).
<br><br>
Note that the feature to limit data-read speeds was added to GDEMU firmware v5.20, thus only accessible to either those with an authentic GDEMU on v5.20 or newer, or the latest v5.20.x clones.  You can read more about the <tt>read_limit</tt> option on the <a href="https://gdemu.wordpress.com/operation/gdemu-operation/">GDEMU Operation</a> page.
<br><br>
It's important to mention that limiting speed at which data is read from the SD card will cause incompatibility with some Atomiswave conversions.  To mitigate this issue, I have been helping Deunan (the creator of GDEMU, as well as other ODEs) test a new version of his firmware which will auto-detect "Nakoruru: The Gift She Gave Me" and impose the data-read limit without any additional configuration.  This auto-detection will be introduced in his next publicly available firmware update, and will also include the same fix for mild texture stuttering from one of my other English translation projects, "<a href="https://github.com/DerekPascarella/SakuraWarsColumns2-EnglishPatchDreamcast">Sakura Wars: Columns 2</a>".
<br><br>
<li><b>MODE</b></li>
Inside the disc image folder, create a <tt>mode.cfg</tt> file containing the following entries:
<br><br>
<pre>
Flags=8
BlockDelay=4
</pre>
A pre-built version of this configuration file is available <a href="https://github.com/DerekPascarella/NakoruruTheGiftSheGaveMe-EnglishPatchDreamcast/blob/main/ode_configs/mode.cfg">here</a>.  To learn more about MODE configuration files, see the <a href="https://wiki.terraonion.com/index.php/Config_Files#MODE_-_Dreamcast_Config">Configuration Files</a> wiki.
<br><br>
<li><b>USB-GDROM</b></li>
No additional configuration is required.
</ul>

<h2>Controls</h2>
<img align="right" src="https://i.imgur.com/TBXZHWm.jpg">This game supports not only the standard Dreamcast controller, but both the keyboard and mouse peripherals, too.
<br><br>
<ul>
<li><b>Controller</b></li>
<br>
<table>
<tr>
<td>
Proceed with dialog, confirm selection</td>
<td>
A button</td>
</tr>
<tr>
<td>
Go back, exit menu</td>
<td>
B button</td>
</tr>
<tr>
<td>
Skip dialog</td>
<td>
X button</td>
</tr>
<tr>
<td>
Auto-pilot dialog progression</td>
<td>
L button</td>
</tr>
<tr>
<td>
Toggle dialog box visibility</td>
<td>
R button</td>
</tr>
<tr>
<td>
Pause menu</td>
<td>
Start button</td>
</tr>
</table>
<br>
<li><b>Keyboard</b></li>
<br>
<table>
<tr>
<td>
Proceed with dialog, confirm selection</td>
<td>
Enter/Space/X key</td>
</tr>
<tr>
<td>
Go back, exit menu</td>
<td>
Del/Esc/Z key</td>
</tr>
<tr>
<td>
Skip dialog</td>
<td>
PgDown key</td>
</tr>
<tr>
<td>
Auto-pilot dialog progression</td>
<td>
F3 key</td>
</tr>
<tr>
<td>
Toggle dialog box visibility</td>
<td>
F2 key</td>
</tr>
<tr>
<td>
Pause menu</td>
<td>
F1 key</td>
</tr>
</table>
<br>
<li><b>Mouse</b></li>
<br>
<table>
<tr>
<td>
Proceed with dialog, confirm selection</td>
<td>
Left click</td>
</tr>
<tr>
<td>
Go back, exit menu</td>
<td>
Right click</td>
</tr>
<tr>
<td>
Skip dialog</td>
<td>
<i>Unimplemented</i></td>
</tr>
<tr>
<td>
Auto-pilot dialog progression</td>
<td>
<i>Unimplemented</i></td>
</tr>
<tr>
<td>
Toggle dialog box visibility</td>
<td>
<i>Unimplemented</i></td>
</tr>
<tr>
<td>
Pause menu</td>
<td>
Click scroll wheel</td>
</tr>
</table>
</ul>

<h2>Bonus Disc</h2>
Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec viverra orci. Quisque id mollis dui, eu imperdiet ligula. Fusce id risus vel elit pulvinar maximus. Aenean tincidunt neque et libero hendrerit, sit amet pulvinar nulla ornare. Cras semper egestas elit, sed posuere nunc.
<br><br>
Quisque ut risus ac risus dictum ultricies. Phasellus id mauris eget mauris pretium consectetur. Nullam ut placerat lectus, nec iaculis enim. Phasellus porttitor pellentesque arcu, laoreet placerat massa sollicitudin et. Integer vel justo at lorem dictum finibus. Nam posuere consequat est, sit amet faucibus magna varius at.

<h2>VMU Applications</h2>
Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec viverra orci. Quisque id mollis dui, eu imperdiet ligula. Fusce id risus vel elit pulvinar maximus. Aenean tincidunt neque et libero hendrerit, sit amet pulvinar nulla ornare. Cras semper egestas elit, sed posuere nunc.
<br><br>
Quisque ut risus ac risus dictum ultricies. Phasellus id mauris eget mauris pretium consectetur. Nullam ut placerat lectus, nec iaculis enim. Phasellus porttitor pellentesque arcu, laoreet placerat massa sollicitudin et. Integer vel justo at lorem dictum finibus. Nam posuere consequat est, sit amet faucibus magna varius at.

<h2>Disc Content</h2>
Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec viverra orci. Quisque id mollis dui, eu imperdiet ligula. Fusce id risus vel elit pulvinar maximus. Aenean tincidunt neque et libero hendrerit, sit amet pulvinar nulla ornare. Cras semper egestas elit, sed posuere nunc.
<br><br>
Quisque ut risus ac risus dictum ultricies. Phasellus id mauris eget mauris pretium consectetur. Nullam ut placerat lectus, nec iaculis enim. Phasellus porttitor pellentesque arcu, laoreet placerat massa sollicitudin et. Integer vel justo at lorem dictum finibus. Nam posuere consequat est, sit amet faucibus magna varius at.

<h2>Disc and Box Art</h2>
Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec viverra orci. Quisque id mollis dui, eu imperdiet ligula. Fusce id risus vel elit pulvinar maximus. Aenean tincidunt neque et libero hendrerit, sit amet pulvinar nulla ornare. Cras semper egestas elit, sed posuere nunc.
<br><br>
Quisque ut risus ac risus dictum ultricies. Phasellus id mauris eget mauris pretium consectetur. Nullam ut placerat lectus, nec iaculis enim. Phasellus porttitor pellentesque arcu, laoreet placerat massa sollicitudin et. Integer vel justo at lorem dictum finibus. Nam posuere consequat est, sit amet faucibus magna varius at.

<h2>Known Issues</h2>
Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec viverra orci. Quisque id mollis dui, eu imperdiet ligula. Fusce id risus vel elit pulvinar maximus. Aenean tincidunt neque et libero hendrerit, sit amet pulvinar nulla ornare. Cras semper egestas elit, sed posuere nunc.
<br><br>
Quisque ut risus ac risus dictum ultricies. Phasellus id mauris eget mauris pretium consectetur. Nullam ut placerat lectus, nec iaculis enim. Phasellus porttitor pellentesque arcu, laoreet placerat massa sollicitudin et. Integer vel justo at lorem dictum finibus. Nam posuere consequat est, sit amet faucibus magna varius at.

<h2>Messages From the Team</h2>

<b>Derek Pascarella (ateam):</b>
> Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec viverra orci. Quisque id mollis dui, eu imperdiet ligula. Fusce id risus vel elit pulvinar maximus. Aenean tincidunt neque et libero hendrerit, sit amet pulvinar nulla ornare. Cras semper egestas elit, sed posuere nunc.
<br><br>
Quisque ut risus ac risus dictum ultricies. Phasellus id mauris eget mauris pretium consectetur. Nullam ut placerat lectus, nec iaculis enim. Phasellus porttitor pellentesque arcu, laoreet placerat massa sollicitudin et. Integer vel justo at lorem dictum finibus. Nam posuere consequat est, sit amet faucibus magna varius at.

<b>Marshal Wong:</b>
> Thanks for playing Nakoruru. This was my first involvement in a translation project and I hope you are/were touched by the story as I was.
<br><br>
There is the Chinese saying 塞翁失馬 (Sāi Wēng Shī Mǎ), which essentially mean that blessings and misfortunes can both be disguised. This describes how I ended up getting involved in this project. I had two DCHDMIs that I had bought to install, one for a friend and one for myself. I had beginners luck in installing the first one for my friend (blessing), but that made me overconfident in installing the second one. I screwed that one up bad enough (misfortune) that I joined the Classic Gaming Discord for help. I just happened to see Derek's post saying that he was putting together a team to translate Nakoruru, and, as the saying goes, the rest is history! 
<br><br>
This is for you, cyo: Thanks for fixing my shit soldering job.
<br><br>
Thank you to Derek for letting me join you in this translation journey. This took longer that we initially expected, but probably not as long as we thought it would eventually take. It's been a pleasure working with you and thanks for always being open to suggestions. I can only dream of reaching your assembly hacking skills.
<br><br>
Thanks to LewisJFC for you great edits and dealing with Mikato's inability to stay in the same tense. Keep up the great work on the Dreamcast Junkyard!
<br><br>
Thanks to my fellow translators, Piggy and Duralumin, for joining the fray. Piggy for all your SNK knowledge, of which I was sorely lacking. Duralumin for your translating experience. 
<br><br>
Looking forward to working and learning from you more on another project!

<b>Lewis Cox (LewisJFC):</b>
> Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec viverra orci. Quisque id mollis dui, eu imperdiet ligula. Fusce id risus vel elit pulvinar maximus. Aenean tincidunt neque et libero hendrerit, sit amet pulvinar nulla ornare. Cras semper egestas elit, sed posuere nunc.
<br><br>
Quisque ut risus ac risus dictum ultricies. Phasellus id mauris eget mauris pretium consectetur. Nullam ut placerat lectus, nec iaculis enim. Phasellus porttitor pellentesque arcu, laoreet placerat massa sollicitudin et. Integer vel justo at lorem dictum finibus. Nam posuere consequat est, sit amet faucibus magna varius at.

<b>Duralumin:</b>
> Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec viverra orci. Quisque id mollis dui, eu imperdiet ligula. Fusce id risus vel elit pulvinar maximus. Aenean tincidunt neque et libero hendrerit, sit amet pulvinar nulla ornare. Cras semper egestas elit, sed posuere nunc.
<br><br>
Quisque ut risus ac risus dictum ultricies. Phasellus id mauris eget mauris pretium consectetur. Nullam ut placerat lectus, nec iaculis enim. Phasellus porttitor pellentesque arcu, laoreet placerat massa sollicitudin et. Integer vel justo at lorem dictum finibus. Nam posuere consequat est, sit amet faucibus magna varius at.
