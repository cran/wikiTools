% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wikiTools.R
\name{nametoWikiFrame}
\alias{nametoWikiFrame}
\title{Convert names into a Wikipedia's iframe}
\usage{
nametoWikiFrame(name, language = "en")
}
\arguments{
\item{name}{A vector consisting of one or more Wikipedia's entry (i.e., topic or person).}

\item{language}{The language of the Wikipedia page version. This should consist of an ISO language code (default = "en").}
}
\value{
A character vector of Wikipedia's iframes.
}
\description{
Convert names into a Wikipedia's iframe
}
\details{
This function adds the Wikipedia's iframe to a entry or name, i.e., "Max Weber" converts into "<iframe src=\"https://es.m.wikipedia.org/wiki/Max_Weber\" width=\"100...". It also manages different the languages of Wikipedia through the abbreviated two-letter language parameter, i.e., "en" = "english".
}
\examples{
## When extracting a single item;
nametoWikiFrame("Computer", language = "en")

## When extracting two objetcs;
A <- c("Computer", "Operating system")
nametoWikiFrame(A)

## Same when three or more items;
B <- c("Socrates", "Plato", "Aristotle")
nametoWikiFrame(B)
}
\author{
Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See \url{https://sociocav.usal.es/blog/modesto-escobar/}
}
