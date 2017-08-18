scriptdir := 'script'
outdir := 'build'
pdfdir := 'graph'

.PHONY: $(outdir) clean default

default: $(outdir) $(pdfdir) $(outdir)/metphoricity-ja.pdf $(outdir)/comprehensibility-ja.pdf $(outdir)/novelty-ja.pdf $(outdir)/metphoricity-en.pdf $(outdir)/comprehensibility-en.pdf $(outdir)/novelty-en.pdf

$(outdir):
	@mkdir -p $(outdir)

$(pdfdir):
	@mkdir -p $(pdfdir)

clean:
	@rm -rf $(outdir)

$(outdir)/metphoricity-ja.pdf $(outdir)/comprehensibility-ja.pdf $(outdir)/novelty-ja.pdf $(outdir)/metphoricity-en.pdf $(outdir)/comprehensibility-en.pdf $(outdir)/novelty-en.pdf: $(outdir)/mean-ja.csv $(outdir)/mean-en.csv $(outdir)/nouns-sorted-by-comprehensibility-ja.csv $(outdir)/verbs-sorted-by-comprehensibility-ja.csv $(outdir)/nouns-sorted-by-metaphoricity-ja.csv $(outdir)/verbs-sorted-by-metaphoricity-ja.csv $(outdir)/nouns-sorted-by-comprehensibility-en.csv $(outdir)/verbs-sorted-by-comprehensibility-en.csv $(outdir)/nouns-sorted-by-metaphoricity-en.csv $(outdir)/verbs-sorted-by-metaphoricity-en.csv
	@Rscript $(scriptdir)/heatmap.r $(outdir) $(pdfdir) 2>&1 > /dev/null

$(outdir)/mean-en.csv: $(outdir)/mean-ja.csv
	@bash $(scriptdir)/translation.sh $(outdir)/mean-ja.csv > $(outdir)/mean-en.csv

$(outdir)/mean-ja.csv $(outdir)/nouns-sorted-by-comprehensibility-ja.csv $(outdir)/verbs-sorted-by-comprehensibility-ja.csv $(outdir)/nouns-sorted-by-metaphoricity-ja.csv $(outdir)/verbs-sorted-by-metaphoricity-ja.csv:
	@bash $(scriptdir)/export.sh $(scriptdir)

$(outdir)/nouns-sorted-by-comprehensibility-en.csv: $(outdir)/nouns-sorted-by-comprehensibility-ja.csv
	@bash $(scriptdir)/translation.sh $(outdir)/nouns-sorted-by-comprehensibility-ja.csv \
		> $(outdir)/nouns-sorted-by-comprehensibility-en.csv

$(outdir)/verbs-sorted-by-comprehensibility-en.csv: $(outdir)/verbs-sorted-by-comprehensibility-ja.csv
	@bash $(scriptdir)/translation.sh $(outdir)/verbs-sorted-by-comprehensibility-ja.csv \
		> $(outdir)/verbs-sorted-by-comprehensibility-en.csv

$(outdir)/nouns-sorted-by-metaphoricity-en.csv: $(outdir)/nouns-sorted-by-metaphoricity-ja.csv
	@bash $(scriptdir)/translation.sh $(outdir)/nouns-sorted-by-metaphoricity-ja.csv \
		> $(outdir)/nouns-sorted-by-metaphoricity-en.csv

$(outdir)/verbs-sorted-by-metaphoricity-en.csv: $(outdir)/verbs-sorted-by-metaphoricity-ja.csv
	@bash $(scriptdir)/translation.sh $(outdir)/verbs-sorted-by-metaphoricity-ja.csv \
		> $(outdir)/verbs-sorted-by-metaphoricity-en.csv
