# 4th Year CCS Courses & Solutions
This repository contains courses, worksheet solutions & labworks For NHSM 4th year in cryptography, coding and security. The contents of the courses may be hugely altered due to the quality of studies. This repo serves as a way for even next generations to be able to fill the missing courses unlike the last years where I did almost never finished them. The naming of modules is just an easier way for me to track them, feel free to rename them as you like.

# How can I change those documents ?
Notice that here, I used a template that I created the "@THR" packages. I am using Typst language for writing those courses. I would say it again and again, leave LaTeX and come to Typst, it's the future.

## Writing In Typst's Online Editor (Not Best)
In this case, you will have to deal with some paths, I highly recommend to use your local. To edit in the online editor, copy the `.typ` file you want to edit, also copy the contents of the template folder next to your file. Then all that remains is to change the paths of the files so that they are correctly working. Check this [project here](https://typst.app/project/rTI3Tsux6TazfyqRBUbieg), it shows how to make it work. You can just copy it and change the `Lecture.typ` by whatever file you need, and changing the first line as 
```diff
- #import "@THR/<package>:<ver>": *
+ #import "THR/<package>/<ver>/template.typ": *
```

## Writing In Your Local (Install Typst, Go Ahead)
Put the whole contents of the Template folder in the default Typst package folder, for example in Linux it would be `.local/share/typst/packages` or `C:\Users\<username>\AppData\Local\typst\packages`. Honestly, I don't know much about other OSs, I think it's the same thing in principle, you just need to put them somewhere Typst can load packages from and it would work, hopefully.

# Documentation Of The Template
Here I will describe briefly what the templates give.

## Base:1.0.0 Package
This package contains all the important parts of my template, it define the boxes for definitions, theorems ...etc, and also the chapters and sections display.

1. Titles:
    1. ```outlines```: returns an outline of all the document
    1. ```ctitle[title]```: centered unnumbered title
    1. ```chapter[title][description]```: chapter with a title and a main description
    1. ```section[title]```: section with a title
    1. ```subsection[title]```: subsection with a title
1. Boxes: The general formula for boxes is ```<box>([name: ""], [count: true], [ovcount: true])[...]``` where name is the name of the definition, theorem...etc, count is if it would be counted, and ovcount if it would show the overall counter, that is, the counter of the title along with which box it is.
    1. ```def```: Definition
	1. ```thm```: Theorem
	1. ```pro```: Proposition
	1. ```cor```: Corollary
	1. ```lem```: Lemma
    1. ```exr```: Exercise
	1. ```qst```: Question
	1. ```alg```: Algorithm
    1. ```ntt```: Notation
	1. ```nte```: Note
1. Blocks: Here are more simple types of blocks, which are just of the form ```<block>[...]```:
	1. ```prf```: Proof
	1. ```exm```: Example
	1. ```ooc```: Out-Of-Context
    1. ```code```: Code Block
1. Extras:
    1. ```follow-bar[...]```: Bar to indicate a separation with some description

## Course:1.0.0 & Document:1.0.0 Packages
Here are just two types of files that use ```Base:1.0.0```, for now they are not too much more than just simplification, hopefully in the future some better features for each of these would be added.
