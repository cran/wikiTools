#### Modesto Escobar
# Sat Feb 27 23:56:26 2021 ------------------------------

#validUrl -----
#' Find if an URL link is valid.
#'
#' @param url A vector of URLs.
#' @param time The timeout (in seconds) to be used for each connection. Default = 2.
#' @details This function checks if a URL exists on the Internet.
#' @return A boolean value of TRUE or FALSE.
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @examples
#' validUrl(url="https://es.wikipedia.org/wiki/Weber,_Max", time=2)
#' @export
validUrl <- function(url, time=2){
  if(curl::has_internet()){
    con <- url(url)
    check <- suppressWarnings(try(open.connection(con,open="rt",timeout=time),silent=T)[1])
    suppressWarnings(try(close.connection(con),silent=T))
    ifelse(is.null(check),TRUE,FALSE)
  }else{
    message("No internet connection.")
    return(FALSE)
  }
}

# urltoHtml ----
#' Convert a Wikipedia URL to an HTML link
#' @param url Character vector of URLs.
#' @param text A vector with name of the correspondent title of the url (See details).
#' @details This function converts an available URL direction to the corresponding HTML link, i.e., "https://es.wikipedia.org/wiki/Socrates" changes into "\verb{<a href='https://es.wikipedia.org/wiki/Socrates' target='_blank'>Socrates</a>}".
#` It is possible to change the showing name of the link directly using the argument text. When not specified, it is extracted directly from the URL.
#' @return A character vector of HTML links for the given urls.
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @examples
#' ## When you have a single URL:
#' 
#' urltoHtml("https://es.wikipedia.org/wiki/Socrates", text = "Socrates")
#' 
#' ## It is possible to work with several items:
#' 
#' A <- c("https://es.wikipedia.org/wiki/Socrates", 
#'        "https://es.wikipedia.org/wiki/Plato", 
#'        "https://es.wikipedia.org/wiki/Aristotle")
#' urltoHtml (A, text = c("Socrates", "Plato", "Aristotle"))
#' 
#' ## And  you can also directly extract the info from nametoWikiURL():
#' 
#' urltoHtml(nametoWikiURL("Plato", "en"), "Plato" )
#' urltoHtml(nametoWikiURL(c("Plato", "Socrates", "Aristotle"), language="en"), 
#'           c("Plato", "Socrates", "Aristotle"))
#' @export
urltoHtml <- function(url, text=NULL) {
  if (is.null(text)) text <- sub("https?:/{0,2}","", url)
  paste0("<a href=\'",url, "\', target= \'_blank\'>", text, "</a>")
}

# urltoFrame----
#' Convert an URL link to an HTML iframe.
#' @param url Character vector of URLs.
#' @details This function converts an available URL direction to the corresponding HTML iframe, i.e., "https://es.wikipedia.org/wiki/Socrates" changes into "\verb{<a href='https://es.wikipedia.org/wiki/Socrates' target='_blank'>Socrates</a>}".
#' @return A character vector of HTML iframe for the given urls.
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @examples
#' ## When you have a single URL:
#' 
#' urltoFrame("https://es.wikipedia.org/wiki/Socrates")
#' 
#' ## It is possible to work with a vector of URL to obtain another vector of html frames:
#' 
#' A <- c("https://es.wikipedia.org/wiki/Socrates", 
#'        "https://es.wikipedia.org/wiki/Plato", 
#'        "https://es.wikipedia.org/wiki/Aristotle")
#' urltoHtml (A)
#' @export
urltoFrame <- function(url){
  paste0('<iframe src="',url, '" width="100%" height="100%" frameborder="0" marginwidth="0", margingheight="0"></iframe>')
}

#cc ----
#' Converts a text separated by commas into a character vector.
#' @param text Text to be separated.
#' @param sep A character of separation. It must be a blank. If it is another character, trailing blanks are suppressed.
#' @details Returns inside the text are omitted.
#' @return A vector of the split segments of the text.
#' @examples
#' ## A text with three names separated with commas is converted into a vector of length 3.
#' cc("Pedro Almodovar, Diego Velazquez, Salvador Dali")
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @export
cc <- function(text, sep=",") {
  if(!sep==" ") {
    text <- gsub(paste0("[ ]*", sep,"[ ]*"), sep, text)
    text <- gsub("\\n[ ]*", "", text)
  }
  else text <- gsub("\\n","", text)
  strsplit(text,sep)[[1]]
}

#preName ----
#' Reverse the order of the first and last names of every element of a vector.
#' @param X A vector of names with format "name, prename".
#' @details This function reverses the order of the first and last names of the items: i.e., "Weber, Max" turns into "Max Weber".
#' @return Another vector with its elements changed.
#' @examples
#' ## To reconvert a single name:
#' preName("Weber, Max")

#' ## It is possible to work with several items, as in here:
#' A <- c("Weber, Max", "Descartes, Rene", "Locke, John")
#' preName(A)
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @export
preName <- function(X) {sub("(^.*),\\s*(.*$)","\\2 \\1", X)}



# nametoWikiURL----
#' Create the Wikipedia URL of a name or entry.
#' @param name A vector consisting of one or more Wikipedia's entry (i.e., topic or person).
#' @param language The language of the Wikipedia page version. This should consist of an ISO language code (default = "en").
#' @return A character vector of names' URLs.
#' @details This function adds the Wikipedia URL to a entry or name, i.e., "Max Weber" converts into "https://es.wikipedia.org/wiki/Max_Weber". It also manages different the languages of Wikipedia thru the abbreviated two-letter language parameter, i.e., "en" = "english".
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @examples
#' ## When extracting a single item;
#' nametoWikiURL("Computer", language = "en")
#'
#' ## When extracting two objetcs;
#' A <- c("Computer", "Operating system")
#' nametoWikiURL(A)
#'
#' ## Same when three or more items;
#' B <- c("Socrates", "Plato" , "Aristotle")
#' nametoWikiURL(B)
#' @export
nametoWikiURL <- function (name, language="en") {
  paste0("https://", language, ".wikipedia.org/wiki/", gsub(" ","_",name))
}

# nametoWikiHtml----
#' Create the Wikipedia link of a name or entry.
#' @param name A vector consisting of one or more Wikipedia's entry (i.e., topic or person).
#' @param language The language of the Wikipedia page version. This should consist of an ISO language code (default = "en").
#' @return A character vector of names' links.
#' @details This function adds the Wikipedia's html link to a entry or name, i.e., "Max Weber" converts into "\verb{<a href='https://es.wikipedia.org/wiki/Max_Weber' target='_blank'>Max Weber</a>}". It also manages different the languages of Wikipedia through the abbreviated two-letter language parameter, i.e., "en" = "english".
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @examples
#' ## When extracting a single item;
#' nametoWikiHtml("Computer", language = "en")
#' 
#' ## When extracting two objetcs;
#' A <- c("Computer", "Operating system")
#' nametoWikiHtml(A)

## Same when three or more items;
#' B <- c("Socrates", "Plato","Aristotle" )
#' nametoWikiHtml(B)
#' @export
nametoWikiHtml <- function(name, language="en"){
  paste0("<a href=\'https://", language, ".wikipedia.org/wiki/", gsub(" ","_",name), "', target=\'_blank\'>", name, "</a>")
}

# nametoWikiFrame----
#' Convert names into a Wikipedia's iframe
#' @param name A vector consisting of one or more Wikipedia's entry (i.e., topic or person).
#' @param language The language of the Wikipedia page version. This should consist of an ISO language code (default = "en").
#' @details This function adds the Wikipedia's iframe to a entry or name, i.e., "Max Weber" converts into "<iframe src=\"https://es.m.wikipedia.org/wiki/Max_Weber\" width=\"100...". It also manages different the languages of Wikipedia through the abbreviated two-letter language parameter, i.e., "en" = "english".
#' @return A character vector of Wikipedia's iframes.
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @examples
#' ## When extracting a single item;
#' nametoWikiFrame("Computer", language = "en")
#' 
#' ## When extracting two objetcs;
#' A <- c("Computer", "Operating system")
#' nametoWikiFrame(A)
#' 
#' ## Same when three or more items;
#' B <- c("Socrates", "Plato", "Aristotle")
#' nametoWikiFrame(B)
#' @export
nametoWikiFrame <- function(name, language="en") {
  paste0('<iframe src="https://',language,'.m.wikipedia.org/wiki/',gsub(" ","_",name),'" width="100%" height="100%" frameborder="0" marginwidth="0", margingheight="0"></iframe>')
}


# searchWiki----
#' Find if there is a Wikipedia page of a name(s) in the selected language. 
#'
#' @param name A vector consisting of one or more Wikipedia's entry (i.e., topic or person).
#' @param language The language of the Wikipedia page version. This should consist of an ISO language code.
#' @param all If all, all the languages are checked. If false, once a term is found, there is no search of others, so it's faster.
#' @param maxtime In case you want to apply a random waiting between consecutive searches.
#' @details This function checks any page or entry in order to find if it has a Wikipedia page in a given language. 
#' It manages the different the languages of Wikipedia thru the two-letters abbreviated language parameter, i.e, "en" = "english". It is possible to check multiple languages in order of preference; in this case, only the first available language will appear as TRUE.
#' @return A Boolean data frame of TRUE or FALSE.
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @examples
#' ## When you want to check an entry in a single language:
#' searchWiki("Manuel Vilas", language = "es")
#'
#' ## When you want to check an entry in several languages:
#' \dontrun{
#' searchWiki("Manuel Vilas", language = c( "en", "es", "fr", "it", "de", "pt", "ca"), all=TRUE)
#' }
## When you want to check several entries and languages:
#' \dontrun{
#' A<-c("Manuel Vilas", "Julia Navarro", "Rosa Montero")
#' searchWiki(A, language = c("en", "es", "fr", "it", "de", "pt", "ca"), all=FALSE)
#' }
#' @export
searchWiki <- function(name, language=c("en", "es", "fr", "it", "de", "pt", "ca"), all=FALSE, maxtime=0) {
  errores <- data.frame(es=logical(), en=logical(), fr=logical(), it=logical(), 
                        de=logical(), pt=logical(), ca=logical())[,language, drop=FALSE]
  for (I in name){
    errores[I,language] <- rep(FALSE, length(language))
    for (L in language){
      person <- gsub(" ", "_", I)
      url <-URLencode(paste("https://",L,".wikipedia.org/wiki/",person,sep=""))
      if (validUrl(url)) {
        errores[I,L] <- TRUE
        if (!all) break
      }
      Sys.sleep(runif(1, min=0, max=maxtime))
    }
  }
  return(errores)
}

# find_item ----
find_item <- function(name, language = "en", limit = 10){
    url <- "https://www.wikidata.org/w/api.php"
    if(curl::has_internet() && !httr::http_error(url)){
      response <- httr::GET(url = url,
        query=list(action = "wbsearchentities", type = "item",
        language = language, limit = limit, search = name, format = 'json'))
      httr::stop_for_status(response)
      response_text <- httr::content(x = response, as = "text")
      parsed_text <- jsonlite::fromJSON(txt = response_text, simplifyVector = FALSE)
      return(parsed_text$search)
    }else{
      message("No internet connection or data source broken.")
      return(NULL)
    }
}

# getWikiInf ----
#' Create a data.frame with Q's and descriptions of a vector of names.
#' @param names A vector consisting of one or more Wikidata's entry (i.e., topic or person).
#' @param number Take the number occurrence in case there are several equal names in Wikidata.
#' @param language The language of the Wikipedia page version. This should consist of an ISO language code (default = "en").
#' @return A data frame with name, Q, label and description of the names.
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @examples
#' ## Obtaining information in English Wikidata
#' names <- c("William Shakespeare", "Pedro Almodovar")
#' information <- getWikiInf(names)
#'
#' ## Obtaining information in Spanish Wikidata
#' \dontrun{
#' informacion <- getWikiInf(names, language="es")
#' }
#' @export
#' @importFrom httr GET stop_for_status content
#' @importFrom jsonlite fromJSON
getWikiInf <- function(names, number=1, language="en"){
  get <-function(name, number, language){
    i <- find_item(name,language)
    if(length(i)>=number) {
      X <- c(name=name, Q=i[[number]]$id, 
             label=ifelse(is.null(i[[number]]$label),NaN, i[[number]]$label),
             description=ifelse(is.null(i[[number]]$description),NaN,i[[number]]$description))
    }
    else X <- c(name=name, Q=NaN, label=NaN, description=NaN)
    return(X)
  }
  D <- as.data.frame(t(sapply(names, get, number, language)))
  return(D)
}

# getWikiData ----
#' Create a data.frame with Wikidata of a vector of names.
#' @param names A vector consisting of one or more Wikidata's entry (i.e., topic or person).
#' @param language The language of the Wikipedia page version. This should consist of an ISO language code (default = "en").
#' @param csv A file name to save the results, in which case the only return is a message with the name of the saved file.
#' @return A data frame with personal information of the names or a csv file with the information separated by semicolons.
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @examples
#' ## Obtaining information in English Wikidata
#' \dontrun{
#' names <- c("William Shakespeare", "Pedro Almodovar")
#' info <- getWikiData(names)
#' ## Obtaining information in Spanish Wikidata
#' d <- getWikiData(names, language="es")
#' }
#' @export
#' @importFrom utils write.csv2
getWikiData <- function(names, language="en", csv=NULL) {
  petition <-function(q){
    chaine <- paste0('SELECT ?entityLabel ?entityDescription ?sexLabel ?birthdate ?birthplaceLabel ?birthcountryLabel ?deathdate ?deathplaceLabel ?deathcountryLabel
     (GROUP_CONCAT(DISTINCT ?pic;separator="|")     as ?pics)
     (GROUP_CONCAT(DISTINCT ?ocLabel;separator="|") as ?occupation)
     (GROUP_CONCAT(DISTINCT ?moLabel;separator="|") as ?movement)
     (GROUP_CONCAT(DISTINCT ?geLabel;separator="|") as ?genres)
     (GROUP_CONCAT(DISTINCT ?inLabel;separator="|") as ?influencedby)
     (GROUP_CONCAT(DISTINCT ?in;separator="|")      as ?influencedbyQ)
     (GROUP_CONCAT(DISTINCT ?noLabel;separator="|") as ?notablework)
     (GROUP_CONCAT(DISTINCT ?no;separator="|")      as ?notableworkQ)
     WHERE {
     BIND(wd:',q,' AS ?entity)
    SERVICE wikibase:label {bd:serviceParam wikibase:language"', language, '"}
    {
      SELECT ?birthdate (COUNT(?refP569) AS ?cP569)
      WHERE {
        OPTIONAL {wd:',q,' wdt:P569 ?birthdate.}
        OPTIONAL {wd:',q,' p:P569 [ps:P569 ?birthdate; prov:wasDerivedFrom [(pr:P248|pr:P854|pr:P143) ?refP569]].}
      } GROUP BY ?birthdate ORDER BY DESC(?cP569) LIMIT 1
    }
    {
      SELECT ?birthplace ?birthcountry ?starttime1 (COUNT(?refP19) AS ?cP19)
      WHERE {
        OPTIONAL {wd:',q,' wdt:P19 ?birthplace.
                 ?birthplace p:P17 [ps:P17 ?birthcountry; pq:P580* ?starttime1; ].}
        OPTIONAL {wd:',q,' p:P19 [ps:P19 ?birthplace; prov:wasDerivedFrom [(pr:P248|pr:P854|pr:P143) ?refP19]].}
      } GROUP BY ?birthplace ?birthcountry ?starttime1 ORDER BY DESC(?cP19) DESC(?starttime1) LIMIT 1
    }
    {
      SELECT ?deathdate (COUNT(?refP570) AS ?cP570)
      WHERE {
        OPTIONAL {wd:',q,' wdt:P570 ?deathdate.}
        OPTIONAL {wd:',q,' p:P570 [ps:P570 ?deathdate; prov:wasDerivedFrom [(pr:P248|pr:P854|pr:P143) ?refP570]].}
      } GROUP BY ?deathdate ORDER BY DESC(?cP570) LIMIT 1
    }
    {
      SELECT ?deathplace ?deathcountry ?starttime2 (COUNT(?refP20) AS ?cP20)
      WHERE {
        OPTIONAL {wd:',q,' wdt:P20 ?deathplace.
                 ?deathplace p:P17 [ps:P17 ?deathcountry; pq:P580* ?starttime2; ].}
        OPTIONAL {wd:',q,' p:P20 [ps:P20 ?deathplace; prov:wasDerivedFrom [(pr:P248|pr:P854|pr:P143) ?refP20]].}
      } GROUP BY ?deathplace ?deathcountry ?starttime2 ORDER BY DESC(?cP20) DESC(?starttime2) LIMIT 1
    }
    OPTIONAL {?entity wdt:P21  ?sex.}
    OPTIONAl {?entity wdt:P18  ?pic.} 
    OPTIONAL {?entity wdt:P106 ?oc. ?oc rdfs:label ?ocLabel. FILTER(LANG(?ocLabel) = "', language, '")}
    OPTIONAL {?entity wdt:P135 ?mo. ?mo rdfs:label ?moLabel. FILTER(LANG(?moLabel) = "', language, '")} 
    OPTIONAL {?entity wdt:P136 ?ge. ?ge rdfs:label ?geLabel. FILTER(LANG(?geLabel) = "', language, '")}
    OPTIONAL {?entity wdt:P737 ?in. ?in rdfs:label ?inLabel. FILTER(LANG(?inLabel) = "', language, '")}
    OPTIONAL {?entity wdt:P800 ?no. ?no rdfs:label ?noLabel. FILTER(LANG(?noLabel) = "', language, '")}
    }
   GROUP BY ?entityLabel ?entityDescription ?sexLabel ?birthdate ?birthplaceLabel ?birthcountryLabel ?deathdate ?deathplaceLabel ?deathcountryLabel 
')
    return(chaine)
  }
  
  getWiki <-function(nombre){
    emptyX <- data.frame(Q=NA, entityLabel=nombre, entityDescription =NA, sexLabel=NA, 
                         birthdate=NA, birthplaceLabel=NA, birthcountryLabel=NA,
                         deathdate=NA, deathplaceLabel=NA, deathcountryLabel=NA,
                         pics=NA, occupation=NA, movement=NA, genres=NA, 
                         influencedby=NA, influencebyQ=NA, notablework=NA, notableworkQ=NA,
                         stringsAsFactors = FALSE)
    i <- find_item(nombre, language=language, limit=1)
    if(length(i)>0) {
      Q <- i[[1]]$id
      X <- w_query(petition(Q), format="csv", method='POST', limitRequester=TRUE)
      if(is.null(dim(X))){
        X <- emptyX
      }else{
        X <- cbind(Q, X[1, ])
        bcb <- !is.na(X$birthdate) && substring(X$birthdate,1,1)=="-"
        bcd <- !is.na(X$deathdate) && substring(X$deathdate,1,1)=="-"
        X$birthdate <- sub("^-","",X$birthdate)
        X$deathdate <- sub("^-","",X$deathdate)
        X$birthdate <- as.numeric(format(as.POSIXct(X$birthdate, origin="1960-01-01", optional=TRUE), "%Y"))
        X$deathdate <- as.numeric(format(as.POSIXct(X$deathdate, origin="1960-01-01", optional=TRUE), "%Y"))
        if(bcb) X$birthdate <- -X$birthdate
        if(bcd) X$deathdate <- -X$deathdate
      }
    }else{
      X <- emptyX
    }
    return(X)
  }


  transM <- function(X) {
    dimensions <- dim(X)
    x <- unlist(X)
    m <- as.data.frame(matrix(x, nrow=dimensions[2], ncol=dimensions[1], byrow=TRUE), stringsAsFactors=FALSE)
    colnames(m) <- rownames(X)
    return(m)
  }

X <- sapply(names,getWiki)
if(is.null(csv)) return(transM(X)) 
else {
  if(filext(csv)=="") csv <- paste0(csv,".csv")
  write.csv2(transM(X), file=csv, row.names=FALSE)
  print(paste0("The file ", csv, " has been saved."))
  }
}


#filext ----

#' Extract the extension of a file
#'
#' @param fn Character vector with the files whose extensions are to be extracted.
#' @details This function extracts the extension of a vector of file names. 
#' @return A character vector of extension names.
#' @examples
#' ## For a single item:
#' filext("Albert Einstein.jpg")

#' ## You can do the same for a vector:
#' filext(c("Hillary Duff.png", "Britney Spears.jpg", "Avril Lavigne.tiff"))
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @export
filext <- function (fn) {
  extract <-function(X){
   splitted    <- strsplit(x=X, split='/')[[1]]   
   fn          <- splitted [length(splitted)]
   ext         <- ''
   splitted    <- strsplit(x=fn, split='\\.')[[1]]
   l           <-length (splitted)
   if (l > 1 && sum(splitted[1:(l-1)] != ''))  ext <-splitted [l] 
   ext
  }
  sapply(fn, extract)
}


# getFiles ----
#' Downloads a list of files in a specified path of the computer, and return a vector of the no-found names (if any).
#' @param lista A list or data frame of files' URLs to be download (See details).
#' @param path Directory where to export the files.
#' @param ext Select desired extension of the files. Default= NULL.
#' @details This function allows download a file of files directly into your directory. 
#' This function needs a preexistent data frame of names and pictures' URL. It must be a list (or data.frame) with two values: "name" (specifying the names of the files) and "url" (containing the urls to the files to download).. 
#' All the errors are reported as outcomes (NULL= no errors). The files are donwload into your chosen directory.
#' @return It returns a vector of errors, if any. All pictures are download into the selected directory (NULL= no errors).
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @examples 
#' ## Not run: 
#' 
#' ## In case you want to download a file directly from an URL:
#' 
#' # dta <- data.frame(name = "Data", url = "https://sociocav.usal.es/me/Stata/example.dta")
#' # getFiles(dta, path = "./")
#' 
#' ##  You can can also combine this function with getWikiData (among others).
#' ## In case you want to download a picture of a person:
#' 
#' # A <- data.frame(name= getWikiData("Rembrandt")$label, url=getWikiData("Rembrandt")$pics)
#' # getFiles(A, path = "./", ext = "png")
#' 
#' ## Or the pics of multiple authors: 
#' 
#' # B <- getWikiData(c("Monet", "Renoir", "Caillebotte"))
#' # data <- data.frame(name = B$label, url = B$pics)
#' # getFiles(data, path = "./", ext = NULL)
#' 
#' ## End(Not run)
#' @export
getFiles <- function(lista, path="./", ext=NULL) {
  errores <- NULL
  path <- ifelse(substr(path,nchar(path),nchar(path))!="/",paste0(path,"/"),path)
  lista <- as.data.frame(lista)
  for (case in 1:nrow(lista)) {
    name <- lista[case,1]; url <- lista[case,2]
    if(is.null(ext)) ext <- filext(url) 
    file=paste0(path,sub("/","-",name),".",ext)
    if(!is.na(url) & !file.exists(file)) {
      E <- suppressWarnings(tryCatch(download.file(url, destfile=file, quiet=TRUE, mode="wb"),error = function(e) name))
      if (E!=0) errores <- c(errores, E)
    } 
  }
  return(errores)
}

# getWikiFiles---- 
#' Downloads a list of Wikipedia pages in a specified path of the computer, and return a vector of the no-found names (if any).
#' @param X A vector of Wikipedia's entry).
#' @param language The language of the Wikipedia page version. This should consist of an ISO language code (default = "en").
#' @param directory Directory where to export the files to.
#' @param maxtime In case you want to apply a random waiting between consecutive searches.
#' @details This function allows download a set of Wikipedia pages into a directory of the local computer. 
#' All the errors (not found pages) are reported as outcomes (NULL= no errors). The files are donwload into your chosen directory.
#' @return It returns a vector of errors, if any. All pictures are download into the selected directory (NULL= no errors).
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @examples 
#' ## Not run: 
#' 
#' ## In case you want to download the Wikipage of a person:
#' 
#' # getWikiFiles("Rembrandt", dir = "./")
#' 
#' ## Or the pics of multiple authors: 
#' 
#' # B <- c("Monet", "Renoir", "Caillebotte")
#' # getWikiFiles(B, dir = "./", language="fr")
#' 
#' ## End(Not run)
#' @export
#' @importFrom utils download.file URLencode
#' @importFrom stats runif
getWikiFiles <- function(X, language=c("es", "en", "fr"), directory="./", maxtime=0) {
  if(substring(directory,nchar(directory))!="/" & substring(directory,nchar(directory))!="\\") directory=paste0(directory,"/")
  errores <- NULL
  for (I in X){
    person <- gsub(" ", "_", I)
    url <-paste("https://",language[1],".wikipedia.org/wiki/",person,sep="")
    file <- paste0(directory, person,".html")
    E <- suppressWarnings(tryCatch(download.file(url,destfile=file, quiet=TRUE),error = function(e) person))
    if (E!=0) errores <- c(errores, E)
    Sys.sleep(runif(1, min=0, max=maxtime))
  }
  return(errores)
}

#extractWiki----
#' Extract the first paragraph of a Wikipedia article with a maximum of characters.
#' @param names A vector of names, whose entries have to be extracted.
#' @param language A vector of Wikipedia's languages to look for. If the article is not found in the language of the first element, it search for the followings,.
#' @param plain If TRUE, the results are delivered in plain format.
#' @param maximum Number maximum of characters to be included when the paragraph is too large.
#' @examples
#' \dontrun{
#' ## Obtaining information in English Wikidata
#' names <- c("William Shakespeare", "Pedro Almodovar")
#' info <- getWikiInf(names)
#' info$text <- extractWiki(info$label)
#' }
#' @return a character vector with html formatted (or plain text) Wikipedia paragraphs.
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca. See <https://sociocav.usal.es/blog/modesto-escobar/>
#' @importFrom jsonlite fromJSON
#' @export
extractWiki <- function(names, language=c("en", "es", "fr", "de", "it"), plain=FALSE, maximum=1000) {
  extract <- function(name, language=c("en", "es"), plain=FALSE, maximum=1000) {
    name <- URLencode(name)
    json <- list(query=list(pages=-1))
    explain <- ifelse(plain, "&explaintext", "")
    for(I in 1:length(language)) {
      json <- tryCatch({
        jsonlite::fromJSON(paste0("https://", language[I], ".wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro", explain,"&redirects=1&titles=",name))
      }, error=function(x){
        message("No internet connection or data source broken.")
      })
      if(length(json) && names(json$query$pages)!="-1") break
    }
    ascii <- json[["query"]][["pages"]][[1]][["extract"]]
    ascii <- gsub("\\[.*?\\]","", ascii)
    if(!plain) ascii <- gsub("(.{150}</p>).*","\\1", ascii)
    else if(nchar(ascii)>maximum) ascii <- paste0(substr(ascii, 1, maximum), "...")
    return(ascii)
  }
  return(sapply(names, extract, language=language, plain=plain, maximum=maximum))
}

#' Convert names of a wikiTools data frame to English or Spanish
#'
#' @param dbase dataframe obtained by a wikiTools function .
#' @param fields names of the dataframe to be translated (default: names of dbase).
#' @param language default: "en". Also accept "es".
#' @return the input dataframe with changed names
#' @author Modesto Escobar, Department of Sociology and Communication, University of Salamanca
#' @export


selectLang <- function(dbase, fields=names(dbase), language="en") {
  names <- c("entity", "status", "labellang", "label", "descriptionlang", "description", "instanceofQ", "instanceof", "sexQ", "sex", 
             "bdate", "byear", "bplaceQ", "bplace", "bplaceLat", "bplaceLon", "bcountryQ", "bcountry", 
             "ddate", "dyear", "dplaceQ", "dplace", "dplaceLat", "dplaceLon", "dcountryQ", "dcountry", 
             "occupationQ", "occupation", "notableworkQ", "notablework", "educatedatQ", "educatedat", 
             "fieldofworkQ", "fieldofwork", "movementQ", "movement", "genreQ", "genre", "influencedbyQ", "influencedby", 
             "memberofQ", "memberof", "awardQ", "award", 
             "viafid", "bneid", "mncarsid", "histhispid", "locid", "pic", "wikipedias")
  en <- c("Entity", "Status", "labellang", "Name", "descriptionlang", "Description", "instanceofQ", "instanceof", "sexQ", "Sex", 
          "Birth date", "Birth year", "bplaceQ", "Birth place", "bLat", "bLon", "bcountryQ", "Birth country", 
          "Death date", "Death year", "dplaceQ", "Death place", "dLat", "dLon", "dcountryQ", "Death country", 
          "occupationQ", "Occupation", "notableworkQ", "Notable work", "educatedatQ", "Educated at", 
          "fieldofworkQ", "Field of work", "movementQ", "Movement", "genreQ", "Genre", "influencedbyQ", "Influenced by", 
          "memberofQ", "Member of", "awardQ", "Award", 
          "VIAF", "BNE", "MNCARS", "RAH", "LOC" ,"img", "wikis")
  es <- c("Entidad", "Estatus", "Lengua", "Nombre", "l_Descripcion", "Descripci\u00f3n", "q_Instancia", "Instancia", "q_Genero", "G\u00e9nero", 
          "Fecha nacimiento", "A\u00f1o nacimiento", "q_Lugar nacimiento", "Lugar nacimiento", "bLat", "dLon", "q_Pais_nacimiento", "Pa\u00eds nacimiento", 
          "Fecha defunci\u00f3n", "A\u00f1o defunci\u00f3n", "q_Lugar defuncion", "Lugar defunci\u00f3n", "dLat", "dLon", "q_Pais defuncion", "Pa\u00eds defunci\u00f3n", 
          "q_Ocupacion", "Ocupaci\u00f3n", "q_Obras", "Obras", "q_Educado", "Educado en", 
          "q_Campos", "Campos", "q_Movimientos", "Movimientos", "q_Generos", "G\u00e9neros", "q_Influido por", "Influido por", 
          "q_Miembro de", "Miembro de", "q_Premios", "Premios", 
          "VIAF", "BNE", "MNCARS", "RAH", "LOC", "img", "wikis")
  rest <- setdiff(names(dbase), names)
  lbase <- data.frame(en=en, es=es)
  row.names(lbase) <- names
  fields <- intersect(fields, names)
  campos <- lbase[fields, language]
  nueva <- dbase[, intersect(fields, names)]
  names(nueva) <- campos
  nueva <- cbind(nueva, dbase[, rest])
  return(nueva)
}
