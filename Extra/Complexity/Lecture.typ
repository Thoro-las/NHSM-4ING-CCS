
#import "resources/commands.typ": *

#import "@THR/Course:1.0.0": *
#show: template.with(
  cover: (
    title: [Computation & \ Complexity Theory],
    writer: "HADIOUCHE Azouaou",
    disclaimer: [
      This course has contents from multiple books that are stated in the reference, and not necessarily follow the school courses.
    ],
  ),
)

#include "chapters/introduction.typ"

#include "chapters/chapter1.typ"
#include "chapters/chapter2.typ"
#include "chapters/chapter3.typ"

#include "chapters/references.typ"
