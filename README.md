# Bitmap editor
Create your own bitmap with this console utility.

It accepts a .txt file as an input. There are several commands that you can specify in your file to create your bitmap.

The input consists of a file containing a sequence of commands, where a command is represented by a single capital letter at the beginning of the line.
Parameters of the command are separated by white spaces and they follow the command character.

Pixel coordinates are a pair of integers: a column number between 1 and 250, and a row number between 1 and 250.
Bitmaps starts at coordinates 1,1. Colours are specified by capital letters.

# Running

`>./bin/bitmap_editor ./examples/show.txt`

Install the dependecies:
`>bundle install`

To run the tests: 
`>bundle exec rspec`


# Commands

* I N M - Create a new M x N image with all pixels coloured white (O).
* C - Clears the table, setting all pixels to white (O).
* L X Y C - Colours the pixel (X,Y) with colour C.
* V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
* H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
* S - Show the contents of the current image

The following errors will appear when an incorrect command is passed:
* **Unrecognised command** if you are trying to use a command not specified in the previous list.
* **Invalid use of command** if more parameters than necessary are passed.
* **Invalid row number** if the row number specified exceeds the number of rows in the curren bitmap.
* **Invalid column number** if the column number specified exceeds the number of columns in the curren bitmap.
* **Invalid value** if the colour value is not a letter in the range A-Z.

# Example

Input File:
```
I 5 6
L 1 3 A
V 2 3 6 W
H 3 5 2 Z
S
```

Output:

```
OOOOO
OOZZZ
AWOOO
OWOOO
OWOOO
OWOOO
```

