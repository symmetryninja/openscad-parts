# OpenSCAD parts

## WTF? (whats this for?)
This repo started out as a way to share code across my robotics projects and turned into something quite a lot more complex.

It came about because I typically model my robots all in one scad file and I use scripting to render multiple seperate parts. Included in all of my model files are the non-3d printed parts, components, servos, batteries etc, this helps me build things to the right scale - even though it's kinda nuts.

## Usage

1. Clone down the repo
2. Add the repo to the OpenSCAD path [instructions here](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries#Setting_OPENSCADPATH)
3. include the `sn_tools.scad` meta-import file like this:
```
include <sn_tools.scad>

// your awesome code here
```
4. Endlessly search through this tools code in the hope to find something useful
5. Use the code.

## A quick example

```c
// Lets say I want to create a centered cube:
cube_size = [20, 20, 20];
ccube(cube_size);

// Now I want to:1
// - put the cube at [30, 30, 30]
// - create a cube in the same place but down 15
// - mirror the cube on the XY & Z axis

cube_offset = [30, 30, 30];

mirrorX() mirrorY() mirrorZ()
translate(cube_offset)
ccube(cube_size);

// Next, I want to put 8 cubes of different sizes in a cube layout and hull the links between but not the whole thing
cube_sizes = [[10, 10, 10], [14, 14, 14], [12, 12, 12], [19, 19, 19], [12, 12, 12], [14, 14, 14], [15, 15, 15], [13, 13, 13], [17, 17, 17], ];
cube_offsets = [ [20, 20, 20], [20, -20, 20], [20, -20, -20], [20, 20, -20], [-20, 20, 20], [-20, -20, 20], [-20, 20, -20], [-20, -20, -20], ];

progressive_hull() {
    translate(cube_offsets[0]) ccube(cube_sizes[0]);
    translate(cube_offsets[1]) ccube(cube_sizes[1]);
    translate(cube_offsets[2]) ccube(cube_sizes[2]);
    translate(cube_offsets[3]) ccube(cube_sizes[3]);
    translate(cube_offsets[4]) ccube(cube_sizes[4]);
    translate(cube_offsets[5]) ccube(cube_sizes[5]);
    translate(cube_offsets[6]) ccube(cube_sizes[6]);
    translate(cube_offsets[7]) ccube(cube_sizes[7]);
    translate(cube_offsets[0]) ccube(cube_sizes[0]);
}

// lastly, a sphere multiplied in a cube layout with the links between them hulled

progressive_hull_at_locations(locations =cube_offsets) csphere(d=8);

```

## What most people will find interesting

| file/folder | purpose |
|-|-|
| `overrides.scad` | simplification and expansion of existing functionality e.g.: `translateX(n) = translate([n, 0, 0])` |
| `shapes.scad` | Centered, beveled and curved edged objects. `ccube() == cube(center=true)` |
| `quick_colours.scad` | Type `blue()` instead of `color("Blue")` |
| `screws.scad` | Modules that make screws that are good for extraction using difference |
| `strange-shapes.scad` | A quick experiment on building shapes that roll that look like they wouldn't, sphericon [like in this video](https://www.youtube.com/watch?v=wb29-ULRBaE) |

## Other files

| file/folder | purpose |
|-|-|
| `boards` | a collection of commonly used boards, in hacky OpenSCAD or in STL format |
| `components` | scad files to build electronic components for preview |
| `servos` | a collection of servos that i have used in robotics|
| `batteries.scad` | battereis and battery trays |
| `bezier.scad` | Open source/Public domain bezier calculation code |
| `clips.scad` | Parts that clip together |
| `curves.scad` | Helper functions for Arcs |
| `curves_math.scad` | Open source/Public domain Curves/Sagitta calculation code |
| `graph.scad` | Open source/Public domain advanced curves code |
| `graphics.scad` | A coded biohazard sign |
| `nuts.scad` | Rivnuts |
| `patterns.scad` | Some Kelvin Pod models for creating detailed Kelvin lattices |
| `power_supplies.scad` | A collection of power supply shapes I've used on robots |
| `publicDomainGearV1.1.scad` | Open source/Public domain Mesh and non-mesh gear code |
| `rotorbits.scad` | Models for the custom flyer componets called rotorbits |
| `shafts.scad` | Eyelit shafts |
| `sn_tools.scad` | a big file of imports |
| `Springs.scad` | Open source/Public domain code formaking springs and helicoils |
| `ShortCuts.scad` | Shortcuts for `Springs.scad` |
| `threads.scad` | Code for making threads, currently not working |
| `timing_belts.scad` | Open source/Public domain Code to make grippers for timing belts |

## License

I like beer, so buy me a beer if you want and I'm not responsible for how you use this code.

```
/* 
 * — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — 
 * “THE BEER-WARE LICENSE” (Revision 42):
 * <Spidey> wrote this file. As long as you retain this  
 * notice you can do whatever you want with this stuff. If we meet
 * some day, and you think this stuff is worth it, you can buy me
 * a beer in return.
 * — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — 
 * Amendment 1: The author(s) of this code accept absolutely no 
 * liability for any damage or general bad things that may come as 
 * part of its use. Any use of this software is deemed an agreement 
 * to absolve the author(s) of any liability, culpability, 
 * durability and any other “(*)ability” (good or bad).
 */
 ```