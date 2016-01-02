# makefile: Rnw -> tex -> pdf
# v 2.0
# .Rnw extension is automatically added
file_name = em1_pset_v2

$(file_name).pdf: $(file_name).tex
	# protection against biber error
	# http://tex.stackexchange.com/questions/140814/
	rm -rf `biber --cache`

	# create pdf
	# will automatically run pdflatex/biber if necessary
	latexmk -pdf $(file_name).tex

	# clean auxillary files
	latexmk -c $(file_name).tex

$(file_name).tex : $(file_name).Rnw chapters/*.Rnw
	Rscript -e "library(knitr); knit('$(file_name).Rnw')"


clean:
	rm em1_pset_v2-tikzDictionary
	rm em1_pset_v2.tex
	rm em1_pset_v2.pdf
