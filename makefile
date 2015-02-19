# makefile
# for econometrics problem set

all: pset solutions

pset: em1_pset_v2.Rnw solutions_only/solutions.Rnw
	Rscript -e "library(knitr); knit('em1_pset_v2.Rnw')"
	latexmk -pdf em1_pset_v2.tex # create pdf
	latexmk -c em1_pset_v2.tex  # clean auxillary files

solutions: em1_pset_v2.tex solutions_only/solutions.tex
	# cd solutions_only/ # how can I change working folder???
	Rscript -e "library(knitr); knit('solutions_only/solutions.Rnw')"
	cp solutions.tex solutions_only/solutions.tex
	latexmk -pdf solutions_only/solutions.tex # create pdf
	latexmk -c solutions_only/solutions.tex  # clean auxillary files



