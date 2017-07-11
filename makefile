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
	latexmk -xelatex -pdf $(file_name).tex

	# clean auxillary files
	latexmk -c $(file_name).tex

$(file_name).tex: $(file_name).Rnw chapters/*.Rnw emetrix_preamble.tex
	Rscript -e "library(knitr); knit('$(file_name).Rnw')"


clean:
	# with minus before rm make will ignore errors if file does not exist
	-rm $(file_name)-tikzDictionary
	-rm chapters/$(file_name)-tikzDictionary
	-rm $(file_name).tex
	-rm $(file_name).pdf
	-rm $(file_name).aux
	-rm $(file_name).idx
	-rm $(file_name).ind
	-rm $(file_name).out
	-rm $(file_name).fls
	-rm $(file_name).ilg
	-rm $(file_name).log
	-rm $(file_name).toc


archive:
	zip em_pset_all.zip makefile $(file_name).tex $(file_name).Rnw $(file_name).pdf solutions/*.tex chapters/*.Rnw R/*.R emetrix_preamble.tex title_bor_utf8_knitr_e pset_data.Rdata R_plots/*.tikz
