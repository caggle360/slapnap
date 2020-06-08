md:
	Rscript -e "rmarkdown::render('README.Rmd', output_file = 'README.md')"

shortrun:
	docker run -e "Nab=VRC07-523-LS;PGT121" -e reduce_covs=TRUE -e reduce_outcomes=TRUE -e reduce_library=TRUE slapnap/slapnap 

longrun:
	docker run -e "Nab=VRC07-523-LS;PGT121" slapnap/slapnap	

build:
	docker build -t slapnap/slapnap:latest . 

debugrun:
	docker run -e "Nab=VRC07-523-LS;PGT121" -e reduce_covs=TRUE -e reduce_library=TRUE -it \
		-v ~/Dropbox/Emory/AMP/slapnap/code:/home/lib \
		-v ~/Dropbox/Emory/AMP/slapnap/slfits:/home/slfits \
		slapnap/slapnap:latest bash