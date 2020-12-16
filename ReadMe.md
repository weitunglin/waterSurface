# waterSurface
project for computer graphics

# How To Run?

## Compile the program
> make \

## execute the program
> ./app

## clean up executables
> make clean

# User Manual
## switch sine wave and heightmap
toggle by clicking "key 1"

## move camera position
"key w" goes forward
"key s" goes backward
"key a" goes left
"key d" goes right
"key q" goes up
"key e" goes down
"key left shift" doubles movements

## move camera angles
moves mouse while keep "mouse left button left" pressed

# Tech Document
This time, I use the skeleton by LearnOpenGL and some well-implemented classes
like Shader and Model, instead of FLTK.

I have a plane obj file created by blender, i use it as the plain water surface.

I first implement parameterlized sine wave, followed [this tutorial](https://catlikecoding.com/unity/tutorials/flow/waves/).

Then, i use the heightmap provided on dgmm. The hard part is the normal, i finally solved by using [this method](https://stackoverflow.com/questions/13983189/opengl-how-to-calculate-normals-in-a-terrain-height-grid).

After finished two type of waves, i try to implement the intereactive wave. But i haven't finish yet, just only doing frame buffer object.

# Windows Executable
助教不好意思，我會盡快把exe補上來，我還在windows研究怎麼編譯，抱歉，拜託不要算我遲交，我影片有展示我所有的功能，我也可以拿我的電腦去給你操作，隨時。
