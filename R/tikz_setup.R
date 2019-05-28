library(tikzDevice)

pckgs <- c(
  "\\usepackage{tikz}\n",
  "\\usepackage[active, tightpage, xetex]{preview}\n",
  "%\\usepackage[top=2cm, left=1.5cm, right=1.5cm, bottom=2cm]{geometry}\n",
  "\\PreviewEnvironment{pgfpicture}\n",
  "\\setlength\\PreviewBorder{0pt}\n",
  "\\usepackage{fontspec}\n",
  "\\usepackage{polyglossia}\n",
  "\\setmainlanguage{russian}\n",
  "\\setotherlanguages{english}\n",
  "\\setmainfont{Linux Libertine O}\n", 
  "\\newfontfamily{\\cyrillicfonttt}{Linux Libertine O}\n",
  "\\newfontfamily{\\cyrillicfont}{Linux Libertine O}\n",
  "\\newfontfamily{\\cyrillicfontsf}{Linux Libertine O}\n"
)

doc_decl <- "\\documentclass[tikz, 12pt]{standalone}\n"

options(tikzDocumentDeclaration = doc_decl)
options(tikzDefaultEngine = "xetex", tikzLatexPackages = pckgs)
