
# SLAPNAP

> Super LeArner Predictions using NAb Panels

**Authors:** [David Benkeser](https://www.github.com/benkeser/), Craig
Magaret, Sohail Nizam, Bhavesh Borate, Brian Williamson, Peter Gilbert

[![Build
Status](https://travis-ci.com/benkeser/slapnap.svg?token=WgmsWkd2hyf88ZxhK8bp&branch=master)](https://travis-ci.com/benkeser/slapnap)
[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![MIT
license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)
<!-- [![DOI](https://zenodo.org/badge/75324341.svg)](https://zenodo.org/badge/latestdoi/75324341) -->

-----

## Description

`slapnap` is a Docker image for developing cross-validation-based
ensemble predictors of neutralization sensitivity/resistance using HIV
sequences from the [CATNAP database](http://www.hiv.lanl.gov/). The
image provides an automated tool for reading the data from the online
database, compiling analytic data sets, developing prediction models,
and summarizing results.

-----

## Usage

This GitHub repository contains the source code needed to build the
slapnap docker image. The repository is also set up for continuous
integration via Travis-CI, with built images found on
[DockerHub](https://cloud.docker.com/u/slapnap/repository/docker/slapnap/slapnap).
See the [Docker
website](https://docs.docker.com/docker-for-windows/install/) for
installation instructions.

From a terminal the image can be downloaded from DockerHub via the
command line.

``` bash
docker pull slapnap/slapnap
```

At run time, the user specifies which nAbs are of interest by setting an
environment variable named `nab` via the `-e` option of `docker run`.
This variable should be set to a semicolon-separated list of nAbs. A
list of possible Nabs included in the CATNAP database can be found
[here](https://www.hiv.lanl.gov/components/sequence/HIV/neutralization/main.comp).
Other options that can be specified using `-e` include:

  - `outcomes`: a semicolon-separated list of outcomes to include in the
    analysis (defaults to all possible outcomes,
    `ic50;ic80;iip;sens1;sens2`)
  - `learners`: a semicolon-separated list of machine learning
    algorithms to include in the ensemble learner (defaults to all
    possible learners \[random forests, boosted trees, lasso\],
    `rf;xgboost;lasso`)
  - `nfolds`: the number of folds to use in cross-validation (defaults
    to 5)
  - `importance_grp`: a semicolon-separated list of group-level
    biological importance measures to consider (options are none `""`,
    marginal `"marg"`, conditional `"cond"`, and both)
  - `importance_ind`: a semicolon-separated list of individual
    variable-level importance measures to consider (options are none
    `""`, learner-level `"pred"`, and biological marginal `"marg"` and
    conditional `"cond"`, or any combination)
  - `return`: a semicolon-separated list of the output to save in
    addition to the report (options are `"report"`, `"learner"` for the
    ensemble learner, `"data"` for the analysis dataset, `"figures"` for
    all figures from the report, and `"vimp"` for variable importance
    objects)

For a complete list of options, see the `Dockerfile`.

We will provide a reference to a detailed description of the SLAPNAP
workflow at some point in the future.

In the end, an HTML report is produced summarizing the analysis. This
report can be accessed on a local computer by mounting a local drive to
`/home/out/` (the directory in the Docker container where the report is
generated) via the `-v` option to `docker run`. See the [`docker run`
help page](https://docs.docker.com/engine/reference/run/) for more
details.

Here is an example for developing a predictor of sensitivity to a
combination of `VRC07-523-LS`, `PGT121`, and `PGDM1400`.

``` bash
docker run -e nab="VRC07-523-LS;PGT121;PGDM1400" \
           -v /path/to/directory:/home/out \
           slapnap/slapnap
```

If the `docker run` command successfully completes, an HTML report will
appear in `/path/to/directory`. Any errors or messages will also appear
in a nAb combination-specific `.log` file in `/path/to/directory`.

## Issues

If you encounter any bugs or have any specific feature requests, please
[file an issue](https://github.com/benkeser/slapnap/issues).

-----

## License

© 2019- David Benkeser

The contents of this repository are distributed under the MIT license:

    The MIT License (MIT)
    
    Copyright (c) 2019 David C. Benkeser
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.