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
