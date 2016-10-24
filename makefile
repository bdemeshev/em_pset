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

$(file_name).tex : $(file_name).Rnw chapters/*.Rnw emetrix_preamble.tex
	Rscript -e "library(knitr); knit('$(file_name).Rnw')"


clean:
	# with minus before rm make will ignore errors if file does not exist
	-rm $(file_name)-tikzDictionary $(file_name).tex
	-rm $(file_name).pdf
	-rm $(file_name).aux
	-rm $(file_name).idx
	-rm $(file_name).ind
	-rm $(file_name).out
	-rm $(file_name).fls
	-rm $(file_name).ilg
	-rm $(file_name).log
	-rm $(file_name).toc
	-rm figure/*.*

archive:
	zip em_pset_all.zip makefile $(file_name).tex $(file_name).Rnw $(file_name).pdf sols_010.tex sols_020.tex sols_030.tex sols_040.tex sols_050.tex sols_060.tex sols_070.tex sols_080.tex sols_090.tex sols_100.tex sols_110.tex sols_120.tex sols_130.tex sols_140.tex sols_150.tex sols_160.tex sols_200.tex sols_210.tex sols_220.tex sols_230.tex sols_240.tex chapters/*.Rnw install_all_packages.R emetrix_preamble.tex
