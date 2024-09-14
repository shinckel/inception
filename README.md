# Inception
This project was developed for 42 school. For comprehensive information regarding the requirements, please consult the PDF file in the subject folder of the repository. Furthermore, I have provided my notes and a concise summary below.
``` diff
+ keywords: raycasting
+ top down 2D game into 3D
+ windows, colors, events, shapes 
```

## High-level Overview

This project is inspired by the world-famous Wolfenstein 3D game, developed by John Carmack and John Romero, which was the first FPS (first person shooter) ever. The goal is to make a dynamic view inside a maze, in which you’ll have to find your way.

### References:
[Make Your Own Raycaster Part 1](https://www.youtube.com/watch?v=gYRrGTC7GtA)<br />
[42 Docs - Cub3D](https://harm-smits.github.io/42docs/projects/cub3d)<br />
[Wolfenstein 3D game](http://users.atw.hu/wolf3d/)<br />
[Vectors | Chapter 1, Essence of linear algebra](https://www.youtube.com/watch?v=fNk_zzaMoSs)<br />
[Lec 1: Dot product | MIT 18.02 Multivariable Calculus, Fall 2007](https://www.youtube.com/watch?v=PxCxlsl_YwY&list=PLYzxBBT5iehMCyHxKZOg9EMETK3nLBbfC)

## Concepts

| Task | Prototype | Description |
|:----|:-----:|:--------:|
| **Raycasting** | `Raycasting is not the same as raytracing` | Raycasting can go very fast, because only a calculation has to be done for every vertical line of the screen. Later games such as Doom and Duke Nukem 3D also used raycasting, but much more advanced engines that allowed sloped walls, different heights, textured floors and ceilings, transparent walls, etc... `Raytracing` is a realistic rendering technique that supports reflections and shadows in true 3D scenes, and only recently computers became fast enough to do it in realtime for reasonably high resolutions and complex scenes. |
| **Sprites** | x | The sprites (enemies, objects and goodies) are 2D images. |
