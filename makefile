# makefile: Rnw -> tex -> pdf
# v 2.0
# .Rnw extension is automatically added
file_name = em1_pset_v2

$(file_name).pdf: $(file_name).tex
	echo "If fonts are missing download them via 'make fonts'"
	# create folder in case it does not exist
	-mkdir R_plots
	-mkdir solutions

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
	-rm $(file_name).tdo
	-rm .Rhistory
	-rm .Rapp.history
	-rm $(file_name).fdb_latexmk
	-rm $(file_name).idx
	-rm $(file_name).ind
	-rm $(file_name).out
	-rm $(file_name).fls
	-rm $(file_name).ilg
	-rm $(file_name).log
	-rm $(file_name).toc


archive:
	zip em_pset_all.zip makefile $(file_name).tex $(file_name).Rnw $(file_name).pdf solutions/*.tex chapters/*.Rnw R/*.R emetrix_preamble.tex title_bor_utf8_knitr_e pset_data.Rdata R_plots/*.tikz

.PHONY: fonts r_packages
fonts:
	-mkdir fonts
	curl -L -o fonts/fonts.tgz https://downloads.sourceforge.net/project/linuxlibertine/linuxlibertine/5.3.0/LinLibertineOTF_5.3.0_2012_07_02.tgz 
	tar -xC fonts/ -zf fonts/fonts.tgz
	echo "Fonts are downloaded into fonts/ folder"
	echo "On macos you may just drag and drop them into FontBook application to install"
	echo "On windows you may just copy font files into c:/windows/fonts"
	echo "On linux use system programs to register fonts"

r_packages:
	Rscript R/install_all_packages.R

