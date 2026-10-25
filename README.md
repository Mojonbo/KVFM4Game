# KVFM4
This KVFM4 Godot 4.7 Project is Mojonbo's proposal for organizing a group effort to make a game for the marathon in April 2027.
Assuming Godot is the engine of choice (Experience from Mojonbo, Tonic, Go1) we can proceed with this.

The baseline idea is that a handful of people with varying experience in coding and design will contribute to a single game to showcase on stream. Realistically, balancing equal contribution from everyone interested will be the biggest challenge. To make this project fun and efficient to work on for all, I propose a few points that should be decided on by all from the outset:
## Game idea should be accomodating to all contributor's skills
	- Broad idea can lead to quick development of most important scenes and overall scene organization
	- If contributors skills lean towards one aspect (e.g. 2D vs 3D graphics, 8-bit music vs ambient, dialogue heavy vs not), that should be accounted for at the start.
	- Spending time on ideas without a plan to get all the supporting assets would be a huge waste of time we'd like to avoid; e.g. if a particular boss encounter is proposed, make sure all aspects of it are covered (e.g. code, graphics, sounds) before beginning.
## Scale of the final game should be limited
	- E.g. Estimated 15-minute gameplay from a blind player would translate to ~200 person-hours of coding/2D graphics dev/sound dev/testing based on junior game jams
## Coordinate with Version control
	- I have no background in software dev so I'm trying not to get in over my head here
	- Ideally everyone will have a hand in something that appears in the final game (code, graphics files, sound files, text, etc), so we can use a git repo.
	- Assuming that it will be impossible to find time for 8+ people to take time out of their lives to work together for several hour/day stretches at a time, anyone should be able to push their contributions
	- I don't think reviewing before merging will need to be terribly complex or harsh, especially if work is divided up. Main priority is that changes to code, resources, and file imports don't generate errors.
	- [Godot git documentation here](https://github.com/godotengine/godot-git-plugin/wiki/Git-plugin-v3)
	- [Accessing Godot projects with GitDesktop video tutorial. Bit of a tough listen though](https://youtu.be/5H4A74FIEtg)

# Proposed Godot Project organization
Let's say after the game idea is generally settled on, we've got 2-4 people coding it, ~2 people doing sound, and a handful of people creating graphics, likely with overlap between these groups. As everyone works on their ideas without the entire gang being present, wouldn't it be nice for their contributions to fit seamlessly into the project without additional tinkering in the editor? e.g. replacing "placeholder_sprites.png" or "placeholder_sound.wav" in the file system shouldn't break objects that see those files as a dependency.

With an organized tree structure (the hierarchy of objects in Godot starting from Root), and smartly designed export variables and resources (code containers that objects use to import files), this could be accomplished without extra work in the editor every time there's a push update.

## Global asset folders
### autoloads
Autoloads are scenes (.tscn) or scripts (.gd) that are always loaded at game launch and made children of Root. They are added in Project Settings/Globals. Since these will always be loaded and can be referenced by any object, they should be made visible in this folder.
### resource_scripts
Resources are data containers that can be defined with a .gd script. The scripts go here to differentiate from .tres objects.
### Other global assets
These are all folders where STATIC, non-object files can be saved and referenced by any object (meaning a scene.tscn, script.gd, or resource.tres may reference but not modify these files).
**This is essentially where anyone who isn't working in the Godot Editor goes to add/modify assets.**
- globalassets_graphics_2d
- globalassets_graphics_3d
- globalassets_music
- globalassets_shaders
- globalassets_sounds
- fonts

## Individual Scene Folders
Even for a simple game, tree hierarchy will get complex quickly: Root will have all autoloads and main.tscn as children at launch, and main.tscn gets replaced with whatever you want the main game board to be.
For the example, run project from designated main (F5 on windows, or the play button in the upper right of the editor) and click on the remote tab in the editor.
It's clear a ton of different objects are already instantiated in a hierarchy under "ExampleCow".

I'm proposing that different states of the game (e.g. a top down board with controllable character, or a standalone menu screen, or a cutscene, etc) should be organized within their own folder- in this case, 01_scene. Whenever the game state changes, main.tscn is simply told to change_scene_to_file("stringpath_to_new_scene").

In a project of this scale, that may only be 2-3 total scenes. Still, this could serve as a handy way to break up parts of the game that different people are working on at once.

# Useful Links
- [Godot Docs 4.7 - Project organization best practices ](https://docs.godotengine.org/en/stable/tutorials/best_practices/project_organization.html#style-guide)
- [Godot Dialogue Manager add-on](https://github.com/nathanhoad/godot_dialogue_manager)
