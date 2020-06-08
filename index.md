---
title: "`slapnap`: Super LeArner Prediction of NAb Panels"
author: "David Benkeser, Brian D. Williamson, Craig A. Magaret, Sohail Nizam, Peter B. Gilbert"
date: "June 08, 2020"
bibliography: refs.bib
link-citations: true
---



# Welcome {-}

The [`slapnap`](https://hub.docker.com/r/slapnap/slapnap) container is a tool for using the Compile, Analyze and Tally NAb Panels (CATNAP) database to develop predictive models of HIV-1 neutralization sensitivity to one or several broadly neutralizing antibodies (bNAbs). 


\begin{center}\includegraphics[width=0.7\linewidth]{gp120} \end{center}
\begin{center}
Crystal structure of HIV-1 gp120 glycoprotein. Highlighted residues
indicating sites most-predictive of VRC01 neutralization resistance.
{[}@magaret2019prediction{]}
\end{center}

In its simplest form, `slapnap` can be used simply to access and format data from CATNAP in a way that is usable for machine learning analysis. However, the tool also offers fully automated and customizable machine learning analyses based on up to five different neutralization endpoints, complete with automated report generation to summarize results and identify the most predictive features. 

This document serves as the user manual for the `slapnap` container. Here, we describe everything needed to utilize `slapnap` and understand its output. The documentation is organized into the following sections:
	
* Section \@ref(sec:docker) provides a brief overview of Docker, including information on installing Docker and downloading the `slapnap` container.
* Section \@ref(sec:catnap) provides a brief overview of the CATNAP database and the specifics of how and when these data were accessed to build the `slapnap` container. 
* Section \@ref(sec:runningcontainer) provides a detailed description of how to make calls to `slapnap` and all options that are available at run time to customize its behavior. 
* Section \@ref(sec:examples) includes example calls to `slapnap` for accomplishing different tasks.
* Section \@ref(sec:methods) describes the methodology used by `slapnap` to generate and analyze data.
* Section \@ref(sec:report) describes the contents of the automated report generated by `slapnap`.
* Section \@ref(sec:data) provides a description of the analysis data set created by `slapnap`.

If you have any issues or questions about using `slapnap`, please [file an issue](https://github.com/benkeser/slapnap/issues) on GitHub. 