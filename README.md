<h1>Nakoruru: The Gift She Gave Me</h1>
<img width="165" height="165" align="right" src="https://i.imgur.com/MDOLCgw.png">Download the English translation patch in DCP format for use with <a href="https://github.com/DerekPascarella/UniversalDreamcastPatcher">Universal Dreamcast Patcher</a> v1.3 or newer:
<ul>
 <li><a href="xxx">Nakoruru - The Gift She Gave Me (English v1.0).dcp</a></li>
</ul>
Download the English translation "Bonus Disc" (more information in the <a href="#bonus-disc">Bonus Disc</a> section):
<ul>
 <li><a href="xxx">Nakoruru - The Gift She Gave Me (English Translation Bonus Disc) [GDI].zip</a></li>
 <li><a href="xxx">Nakoruru - The Gift She Gave Me (English Translation Bonus Disc).cdi</a></li>
</ul>
<h2>Table of Contents</h2>

1. [Patching Instructions](#patching-instructions)
2. [Credits](#credits)
3. [Changelog](#changelog)
4. [About the Game](#about-the-game)
5. [What's Changed](#whats-changed)
6. [A Note on Emulators and ODEs](#a-note-on-emulators-and-odes)
7. [Controls](#controls)
8. [Mini-Games](#mini-games)
9. [Bonus Disc](#bonus-disc)
10. [VMU Applications](#vmu-applications)
11. [Disc Content](#disc-content)
12. [Disc and Box Art](#disc-and-box-art)
13. [Known Issues](#known-issues)
14. [Messages From the Team](#messages-from-the-team)

<h2>Patching Instructions</h2>
<img align="right" width="250" src="https://github.com/DerekPascarella/UniversalDreamcastPatcher/blob/main/screenshots/screenshot.png?raw=true">The DCP patch file shipped with this release is designed for use with <a href="https://github.com/DerekPascarella/UniversalDreamcastPatcher">Universal Dreamcast Patcher</a> v1.3 or newer.  Note that Universal Dreamcast Patcher supports both TOSEC-style GDI and Redump-style CUE disc images as source input.
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

<h2>Changelog</h2>
<ul>
 <li>Version 1.0 (202X-XX-XX)</li>
 <ul>
  <li>Initial release.</li>
 </ul>
</ul>

<h2>About the Game</h2>
Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec viverra orci. Quisque id mollis dui, eu imperdiet ligula. Fusce id risus vel elit pulvinar maximus. Aenean tincidunt neque et libero hendrerit, sit amet pulvinar nulla ornare. Cras semper egestas elit, sed posuere nunc.
<br><br>
Quisque ut risus ac risus dictum ultricies. Phasellus id mauris eget mauris pretium consectetur. Nullam ut placerat lectus, nec iaculis enim. Phasellus porttitor pellentesque arcu, laoreet placerat massa sollicitudin et. Integer vel justo at lorem dictum finibus. Nam posuere consequat est, sit amet faucibus magna varius at.

<h2>What's Changed</h2>
<img align="right" width="300" height="225" src="https://i.imgur.com/5QCKdKj.png">Below is a high-level list of changes implemented for this English translation patch.
<br><br>
<ul>
 <li>All 12,000+ lines of Japanese dialogue text have been translated.</li>
 <li>All menus, textures/images, bonus content, and mini-games have been translated, re-rendered, and rebuilt.</li>
  <ul>
   <li>Previously, the only English asset in this game was the "Press Start Button" text on the title screen.</li>
  </ul>
 <li>All VMU icons and applications have been translated (read more in <a href="https://www.dreamcast-talk.com/forum/viewtopic.php?f=52&t=14736&start=30#p161265">this Dreamcast-Talk.com forum post</a>).</li>
 <li>All VMU save and application metadata appear in English on the Dreamcast's BIOS menu save manager.</li>
 <li>The "Learn the Lyrics" mini-game previously functioned as a basic Kana lesson for players, and has been modified to teach the player the Ainu phonetics for Nakoruru's "secret song".</li>
 <li>A new font sheet was created, along with new SH4 assembly code to support narrower glyph tiles and all related modifications (read more in <a href="https://www.dreamcast-talk.com/forum/viewtopic.php?f=52&t=14736&start=40#p166415">this Dreamcast-Talk.com forum post</a>).</li>
 <li>Quiz mini-games completely overhauled and localized.</li>
  <ul>
   <li>Quiz mini-game questions completely rewritten as to give players the ability to answer them correctly, while also learning about Japanese and Ainu culture, food, and history (see <a href="#mini-games">Mini-Games</a> section).
   <li>Quiz mini-game timer removed to give players time to research answers for each question.</li>
  </ul>
 <li>Voiced acted dialogue audio persists across multiple dialogue boxes as to not be prematurely halted when English text consumes more than a single dialogue box (read more in <a href="https://www.dreamcast-talk.com/forum/viewtopic.php?f=52&t=14736&start=30#p163650">this Dreamcast-Talk.com forum post</a>).</li>
 <li>A brand-new Bonus Disc was created to provide players with a 100% fully-unlocked save, two playable songs from the game, and the first and only episode of the official "Nakoruru: The Gift She Gave Me" OVA.  All of this content is enjoyable directly from the bonus disc itself on real Dreamcast hardware (read more in <a href="https://www.dreamcast-talk.com/forum/viewtopic.php?f=52&t=14736&start=50#p166767">this Dreamcast-Talk.com forum post</a>).
</ul>

<h2>A Note on Emulators and ODEs</h2>
<img align="right" src="https://i.imgur.com/PbVgeuJ.jpg" width="180">Throughout the development of this translation patch, testing was performed across the spectrum of both emulators and ODEs, as well as optical disc.  Interestingly, this game (both in its original form and in its patched form) has one very mild issue when played via emulator or some ODEs, causing a texture flicker in between screen transitions.  When this occurs, the on-screen character(s) will flicker slightly before fading away with the scene transition.  It's the result of faster data-read speeds than developers originally intended when played via GD-ROM.
<br><br>
Please understand that this is in no way a game-breaking issue, and is strictly cosmetic.  Furthermore, those playing this game on an optical disc (i.e., a CDI burned to a CD-R) will not experience this texture flicker.
<br><br>
The solution to said problem is to artificially limit the speed at which data is read from the disc image in order to more closely mimic the performance of a GD-ROM.  While achievable on ODEs, I've yet to find such a setting in any emulators used during development and testing (Flycast, Demul, NullDC, and lxdream-nitro).  Below are the configurations needed to impose the required data-read limit.
<br><br>
<ul>
<li><b>GDEMU</b></li>
Add the <tt>read_limit</tt> parameter with a value of <tt>1250</tt> to the <tt>GDEMU.ini</tt> configuration file in the root of the SD card (<a href="https://github.com/DerekPascarella/NakoruruTheGiftSheGaveMe-EnglishPatchDreamcast/blob/main/ode_configs/GDEMU.ini">see example configuration file here</a>).
<br><br>
Note that the feature to limit data-read speeds was added to GDEMU firmware v5.20, thus only accessible to either those with an authentic GDEMU on v5.20 or newer, or the latest v5.20.x clones.  You can read more about the <tt>read_limit</tt> option on the <a href="https://gdemu.wordpress.com/operation/gdemu-operation/">GDEMU Operation</a> page.
<br><br>
It's important to mention that limiting speed at which data is read from the SD card will cause incompatibility with some Atomiswave conversions.  To mitigate this issue, I have been helping Deunan (the creator of GDEMU and other ODEs) test a new version of his firmware which will auto-detect "Nakoruru: The Gift She Gave Me" and impose the data-read limit without any additional configuration.  This auto-detection will be introduced in his next publicly available firmware update, and will also include the same fix for mild texture stuttering from one of my other English translation projects, "<a href="https://github.com/DerekPascarella/SakuraWarsColumns2-EnglishPatchDreamcast">Sakura Wars: Columns 2</a>".
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
<img align="right" src="https://i.imgur.com/TBXZHWm.jpg">This game supports not only the standard Dreamcast controller, but both the keyboard and mouse peripherals, too. Jump Pack support is also implemented for vibration during certain scenes, an option which can be turned off in the game's settings menu.
<br><br>
<ul>
<li><b>Controller</b></li>
<br>
<table>
<tr>
<td>
Proceed with dialogue, confirm selection</td>
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
Skip dialogue</td>
<td>
X button</td>
</tr>
<tr>
<td>
Auto-pilot dialogue progression</td>
<td>
L button</td>
</tr>
<tr>
<td>
Toggle dialogue box visibility</td>
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
Proceed with dialogue, confirm selection</td>
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
Skip dialogue</td>
<td>
PgDown key</td>
</tr>
<tr>
<td>
Auto-pilot dialogue progression</td>
<td>
F3 key</td>
</tr>
<tr>
<td>
Toggle dialogue box visibility</td>
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
Proceed with dialogue, confirm selection</td>
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
Skip dialogue</td>
<td>
<i>Unimplemented</i></td>
</tr>
<tr>
<td>
Auto-pilot dialogue progression</td>
<td>
<i>Unimplemented</i></td>
</tr>
<tr>
<td>
Toggle dialogue box visibility</td>
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

<h2>Mini-Games</h2>
There are eight separate mini-games scattered throughout this adventure.  One of these games challenges players with a host of quiz questions.  As mentioned in the <a href="#whats-changed">What's Changed</a> section, the timer for these questions has been removed for this translation patch.  Without removing the timer, answering any of the quiz questions correctly would be highly improbable.
<br><br>
As a bonus, a complete bank of questions and answers has been compiled and is <a href="QUIZ_ANSWER_BANK.md">available here</a>. Note that each of the three quizzes holds a bank of 30 questions, but only ten are selected at random.
<br><br>
<table style="border: none; border-collapse: collapse;">
<tr>
<td width="50%" align="center">
<img src="https://i.imgur.com/KbswMa4.png"></td>
<td width="50%" align="center">
<img src="https://i.imgur.com/raCB7Nt.png"></td>
</tr>
<tr>
<td width="50%" align="center">
<img src="https://i.imgur.com/09R5Ylr.png"></td>
<td width="50%" align="center">
<img src="https://i.imgur.com/rnF5OO9.png"></td>
</tr>
<tr>
<td width="50%" align="center">
<img src="https://i.imgur.com/sTpbLY8.png"></td>
<td width="50%" align="center">
<img src="https://i.imgur.com/0FasiBQ.png"></td>
<tr>
<td width="50%" align="center">
<img src="https://i.imgur.com/f2JlFDh.png"></td>
<td width="50%" align="center">
<img src="https://i.imgur.com/mjn1umh.png"></td>
</tr>
</table>

<h2>Bonus Disc</h2>
<img align="right" width="300" src="https://i.imgur.com/z4MCEf2.gif">When developing English translation patches for the SEGA Dreamcast, I often like to leverage the baked-in Dream Passport web browser (commonly found in Japanese games) to include bonus content.  In the case of "Nakoruru: The Gift She Gave Me", no such browser was bundled with, and accessible from, the game itself.  So, rather than spend a needlessly long period of time hacking one in, I opted to ship with this patch an entirely separate, standalone Bonus Disc.
<br><br>
Offered in both GDI and CDI formats, the Bonus disc treats players with the following extras:
<br><br>
<ul>
<li>A 100% fully-unlocked save file, granting players access to all of the game's built-in extra content (accessible from the "EXTRAS" option in the game's main menu).</li>
<li>A well-produced, 30-minute OVA (original video animation) produced in 2002 by ARMS featuring the same characters and setting as the game.  Note that the screensaver timer has been removed with an assembly hack so that the entirety of this video can be watched uninterrupted.</li>
<li>A beautiful rendition of "Miko no Densho Uta" ("Traditional Shrine Maiden's Song") performed by Nakoruru's voice actress, Harumi Ikoma.</li>
<li>The gorgeous song sung by Manari's voice actress, Ayako Kawasumi, when she finally works up the courage to sing in front of others in the game.</li>
</ul>
More can be read about the Bonus Disc in <a href="https://www.dreamcast-talk.com/forum/viewtopic.php?f=52&t=14736&start=50#p166767">this Dreamcast-Talk.com forum post</a>.

<h2>VMU Applications</h2>
<img align="right" width="150" src="https://i.imgur.com/m7KF3Pi.png">As part of this game's unlockable extra content, players have the ability to download one of four clock applications to their VMU.  Four of the main characters are each featured separately in these applications (Nakoruru, Manari, Rimururu, and Rera).
<br><br>
Once downloaded to a VMU, players can navigate to the game icon (♠), where they'll be presented with an animated icon of the selected character.  The current time will also be displayed.
<br><br>
Pressing the A button will display an option to hold both A and B buttons to reveal a quote from the character.  Pressing B again returns back to the current time.
<br><br>
More can be read about the process of reverse-engineering these VMU clock applications in <a href="https://www.dreamcast-talk.com/forum/viewtopic.php?f=52&t=14736&start=30#p161265">this Dreamcast-Talk.com forum post</a>.

<h2>Disc Content</h2>
<img align="right" width="200" height="162" src="https://i.imgur.com/lUwilNu.png">As is quite common with Dreamcast titles, the 35 MB single-density area of this game's GD-ROM contains bonus content. Accessible by players who insert their original game disc into their computer's CD-ROM drive, this content came in the form of six clock applications. These applications are 32-bit Windows binaries which have been tested all the way up to Windows 10.
<br><br>
While these small bonus programs originally displayed their menu in Japanese, they have been fully translated into English for this release.  To access the menu, simply right-click anywhere on the clock face.
<br><br>
Each clock application executable is available in the <a href="disc_content">disc_content</a> folder.

<h2>Disc and Box Art</h2>
<img width="165" height="165" align="right" src="https://i.imgur.com/MDOLCgw.png">By default, the Bonus Disc and main game itself both use brand new disc art 0GDTEX.PVR files, which look nice when displayed in GDMenu on GDEMU.  However, for those using <a href="https://github.com/mrneo240/GDMENUCardManager/wiki/Instructions">openMenu</a> on GDEMU who prefer box art, I've provided alternative versions for both disc images in the <a href="https://github.com/DerekPascarella/NakoruruTheGiftSheGaveMe-EnglishPatchDreamcast/tree/main/menu_art">menu_art</a> folder.
<br><br>
For GDMenu users who prefer box art, both the Bonus Disc and main game GDIs can be extracted and rebuilt to include that artwork instead.  One such tutorial on how to do so can be found <a href="https://www.youtube.com/watch?v=3_-9Ur3RvA0">here on YouTube</a>.
<br><br>
Because the MODE uses Redump checksums to match artwork to each game, neither the Bonus Disc nor the main game will be identified, and no artwork will be displayed.

<h2>Known Issues</h2>
<img align="right" width="300" height="225" src="https://i.imgur.com/nKu2rwU.png">From this project's onset, the goal has been to deliver a completely polished English translation patch free of any bugs or imperperfections. Thankfully, there are no game-breaking bugs to speak of whatsoever. However, there is one minor cosmetic/functional issue with this game's history feature.
<br><br>
Designed to allow players to scroll back through dialogue history, this one section of the game presented a slew of technical challenges. Although "Nakoruru: The Gift She Gave Me" leverages dozens of separate text-rendering functions for different parts of the game, all of them but one were reined in after a bit of effort. Unfortunately, even after months of assembly hacking attempts, the unique (and bizarre) history viewer is presently in a partially broken state.
<br><br>
Currently, the game will at least display the last 100 dialogue instances, which required a reallocation of RAM in order to fit the now twice-as-large text entries. However, each is cut off after 78 characters, rather than the new maximum of 156. Furthermore, each entry appears with improperly placed linebreaks. To help soften the visual appearance, text has been centered, rather than kept left-justified.
<br><br>
Note that the current implementation of the history feature does not represent the entirety of the progress I made in hacking it. Rather, it's a compromise that guarantees no game-breaking bugs.
<br><br>
As stated, this issue in no way causes crashing or any other form of breakage. That being said, there are plans to address and fully fix the history feature in a future release.
<br><br>
Bugs or typos found during gameplay can be reported by <a href="https://github.com/DerekPascarella/NakoruruTheGiftSheGaveMe-EnglishPatchDreamcast/issues?q=is%3Aissue+is%3Aopen">submitting a new issue</a> to this project page.

<h2>Messages From the Team</h2>

<b>Derek Pascarella (ateam):</b>
> In July of 2021, I began researching visual novels on the SEGA Dreamcast. Given that no titles from this genre were brought to the West during the console's lifecycle, I felt it important that one of the Dreamcast's best visual novels should be the focus of my next English translation patch project. I knew the process of analyzing, extracting, translating, hacking, rebuilding, and finally playtesting a game of that scale would be arduous and time-consuming. However, it takes tremendous passion and effort to accomplish anything good and worthwhile in life, and I was determined to see it through.
<br><br>
With this resolve at the forefront of my mind, I began spreading the word that I was looking to amass a team of translators and editors.  Thankfully, the wonderful people named in the <a href="#credits">Credits</a> section above answered the call.  The events that proceeded live on within me as experiences and memories that I wouldn't trade for all the money in the world.
<br><br>
From a technical perspective, "Nakoruru: The Gift She Gave Me" presented many, many challenges. Unlike previous English translation patches I've developed, this game required extensive Hitachi SH4 Assembly work to implement a multitude of changes and quality-of-life improvements. To get the job done, I spent countless hours combing through Hitachi's technical documentation to soak up as much as I could. By combining Ghidra, Cheat Engine, and the Demul emulator, I was able to devise a functional workflow for reverse-engineering, modifying, and testing.
<br><br>
Morning after morning, I woke up several hours before my alarm clock would normally sound off so that I could squeeze in as much time as possible to work on hacking this game. I thought about how to solve problems when I laid my head down on my pillow at night. I had eureka moments while sitting in traffic. In short, "Nakoruru: The Gift She Gave Me" consumed my nearly every waking moment. In that way, a target game serves as something of a cruel mistress to romhackers and translation patch developers. As bizarre as that may sound, several others in the scene agree with me.
<br><br>
Aside from cutting my teeth on more advanced forms of assembly hacking, this game also opened my eyes to the minority Ainu people of Japan. Admittedly, this is an ethnic group of which I had no previous knowledge. Its food, culture, and language were the source of much research carried about by my fantastic translation team. I myself even spent a fair bit of time aiding in said research, as well.
<br><br>
That said, I worked hard to ensure that players are taught about the Ainu in every way possible while playing this game. Special Ainu-language terminology is introduced a great number of times during the story, accompanied by an explanation in order to educate players. The same is true for the completely overhauled quiz mini-games (read more in the <a href="#mini-games">Mini-Games</a> section), which serve to reinforce, or introduce for the first time, nuggets of knowledge on Ainu food, history, culture, and language.
<br><br>
Ultimately, I feel that "Nakoruru: The Gift She Gave Me" offers its player a delightful, entertaining, heartfelt tale of friendship, family, love, and of course, growing up. I will forever cherish the friends I made along the way while bringing this game to you all in English for the first time. From the bottom of my heart, I hope everyone out there who gives this game a try finds in it something truly special, and something that leaves a lasting impact on them for years to come.

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
> I was made aware of "Nakoruru: The Gift She Gave Me" by my Dreamcast Junkyard colleague and friend, Mike. On a system that received over 100 visual novels, Nakoruru really stands out as a high-quality title in its genre, with intrigue only aided further by its association with SNK's beloved Samurai Shodown/Spirits franchise. Despite their niche appeal in the West, I do really enjoy playing visual novels. Naturally, this means that I also have an affinity for fan translation projects too, as without them, some of the best visual novels could never have been experienced by people like myself who cannot speak Japanese.
<br><br>
Through my writing for The Dreamcast Junkyard, I got to know fan translation scholar (and gentleman), Derek Pascarella. Through our conversations, I got to learn more about the assembly line process many fan translations utilise to get stuff done. As a fiction writer with editing experience, I told Derek that I'd be down to assist him with future projects. When he told me he was considering a fan translation of Nakoruru... well, I signed right up. My motivators? One: help a friend. Two: bring Nakoruru to the English-speaking Dreamcast community, and three... if I helped this translation project through to completion, I'd finally be able to play a game I'd been wanting to play for the longest time!
<br><br>
Some might wonder if taking on a project as big as Nakoruru for my first go as a lead editor was a real trial by fire, but... no. I've had the best team anyone could ask for. Everyone involved with this project has always been patient and quick to lend a hand if they could (busy life schedules permitting, of course). Thank you to Derek, Marshal and Duralumin for always helping me to figure out whatever line I'd been overthinking that day (turns out that sometimes overthinking can lead to great results).
<br><br>
As for Nakoruru... I have no hesitation when I say that regardless of my involvement with this project, I would have loved this game regardless. I knew I had a good feeling about Nakoruru, and it definitely paid off. If you're a fan of visual novels, the Dreamcast or Samurai Shodown (or even all three), please give it a try. Mikato's tale is not only beautiful and moving, but funny and wholesome too. A great all-rounder, with atmosphere in spades. I hope you all learn to love this story and its characters as much as me and my team have.
<br><br>
Finally, thank you to all the great minds in the Dreamcast scene who are constantly working to keep this amazing console's legacy alive... the dream never dies!
<br><br>
P.S. If you have to make a repro of this translation, at least send me one too! That shit would look sick on my shelf.

<b>Duralumin:</b>
> Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nec viverra orci. Quisque id mollis dui, eu imperdiet ligula. Fusce id risus vel elit pulvinar maximus. Aenean tincidunt neque et libero hendrerit, sit amet pulvinar nulla ornare. Cras semper egestas elit, sed posuere nunc.
<br><br>
Quisque ut risus ac risus dictum ultricies. Phasellus id mauris eget mauris pretium consectetur. Nullam ut placerat lectus, nec iaculis enim. Phasellus porttitor pellentesque arcu, laoreet placerat massa sollicitudin et. Integer vel justo at lorem dictum finibus. Nam posuere consequat est, sit amet faucibus magna varius at.
