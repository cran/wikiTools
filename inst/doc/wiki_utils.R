## ----eval=FALSE---------------------------------------------------------------
#  install.packages("wikiTools")

## ----echo=TRUE----------------------------------------------------------------
library(wikiTools)

## ----echo=TRUE----------------------------------------------------------------
df <- w_SearchByLabel(string='Iranzo', langsorder='es|en')
df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', instanceof = 'Q5')
df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', instanceof = 'Q5|Q101352')
df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', instanceof = 'Q5',
                      Pproperty = 'P21|P569|P570')

## ----echo=TRUE----------------------------------------------------------------
df <- w_SearchByLabel(string='Iranzo', lang='en', langsorder='es|en', mode='startswith')
df <- w_SearchByLabel(string='Iranzo', lang='en', langsorder='es|en', instanceof = 'Q5',
                      mode='startswith')
df <- w_SearchByLabel(string='Iranzo', lang='en', langsorder='es|en',
                      instanceof = 'Q5|Q101352', mode='startswith')
df <- w_SearchByLabel(string='Iranzo', lang='en', langsorder='en', instanceof = 'Q5',
                      Pproperty = 'P21|P569|P570', mode='startswith')

## ----echo=TRUE----------------------------------------------------------------
df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', mode='inlabel')

## ----echo=TRUE----------------------------------------------------------------
df <- w_SearchByLabel(string='Iranzo', langsorder='zh|es', lang='zh', mode='inlabel')

## ----echo=TRUE----------------------------------------------------------------
df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', instanceof = 'Q5',
                      mode='inlabel')
df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', instanceof = 'Q5|Q101352',
                      mode='inlabel')
df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', instanceof = 'Q5',
                      Pproperty = 'P21|P569|P570', mode='inlabel')

## ----echo=TRUE----------------------------------------------------------------
df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', mode='inlabel')
l <- df$entity

## ----echo=TRUE----------------------------------------------------------------
df <- w_isInstanceOf(entity_list=l, instanceof='Q5')
# Not TRUE
df[!df$instanceof_Q5,]

## ----echo=TRUE----------------------------------------------------------------
df <- w_Wikipedias(entity_list=l)
df <- w_Wikipedias(entity_list=l, wikilangs='es|en|fr')
df <- w_Wikipedias(entity_list=l, wikilangs='es|en|fr', instanceof="Q5")

## ----echo=TRUE----------------------------------------------------------------
w_OccupationEntities(Qoc='Q2306091', mode='count') # Qoc for Sociologist
l  <- w_OccupationEntities(Qoc='Q2306091') # l=entities: vector

## ----echo=TRUE, eval=FALSE----------------------------------------------------
#  lw <- w_OccupationEntities(Qoc='Q2306091', mode='wikipedias') # lw=dataframe
#   # We can obtain the same information using previous function w_Wikipedias:
#   lw2 <- w_Wikipedias(entity_list=l, wikilangs='')
#   # Verifying:
#   all(lw['Q10320558','pages'] == lw2['Q10320558','pages'])
#   # Verifying:
#   all(sort(strsplit(lw['Q9061', 'pages'], '|', fixed = T)[[1]]) ==
#       sort(strsplit(lw2['Q9061', 'pages'], '|', fixed = T)[[1]]))

## ----echo=TRUE----------------------------------------------------------------
l2 <- append(l, c("Q115637688", "Q105660123"))  # Note: adding two new entities
v <- w_isValid(l2)
# Not valid
v[!v$valid,]

## ----echo=TRUE----------------------------------------------------------------
p <- w_Property(l, Pproperty = 'P21|P569|P214', langsorder = 'es|en')

## ----echo=TRUE----------------------------------------------------------------
mncars   <- w_IdentifiersOfAuthority(Pauthority="P4439", langsorder = 'es|en')
# 1286  [human, groups, etc.]
mncarsQ5 <- w_IdentifiersOfAuthority(Pauthority="P4439", langsorder = 'es|en',
                                     instanceof = 'Q5')  # 1280
# Entities are not 'human' (Q5) [see entityDescription column):
mncars[!(mncars$entity %in% mncarsQ5$entity),]  # not instance of Q5.

## ----echo=TRUE----------------------------------------------------------------
df1 <- w_EntityInfo(entity='Q134644', langsorder = 'es|en')
# Also a "tiny" version
df2 <- w_EntityInfo(entity='Q134644', langsorder = 'es|en', mode='tiny')
# Differences: fields non existing in the tiny row set as "--":
Aleixandre <- rbind(
  df1,
  data.frame(c(df2, sapply(setdiff(names(df1), names(df2)), function(x) "--")),
             row.names = 'tiny')
)
BenHur    <- w_EntityInfo(entity='Q180098', langsorder='es|en',
                          wikilangs = 'es|fr', mode='film')
Nosferatu <- w_EntityInfo(entity='Q151895', langsorder='es|en',
                          wikilangs = 'es|fr|en', mode='film')
# Nosferatu has a public video:
Nosferatu$video
# Combining data-frames:
films <- rbind(BenHur, Nosferatu)

## ----echo=TRUE----------------------------------------------------------------
df <- m_Opensearch(string='Duque de Alba', project='es.wikipedia.org',
                   profile="engine_autoselect", redirects="resolve")
df <- m_Opensearch(string='Duque de Alba', project='es.wikipedia.org', profile="strict")
df <- m_Opensearch(string='Duque de Alba', project='es.wikipedia.org', profile="fuzzy")

## ----echo=TRUE----------------------------------------------------------------
df <- m_reqMediaWiki(c('Max Planck', URLdecode("a%CC%8C"), 'Max', 'Cervante', 'humanist'),
                        mode='wikidataEntity', project='en.wikipedia.org')

## ----echo=TRUE----------------------------------------------------------------
a <- m_reqMediaWiki(c('Cervantes', 'Planck', 'Noexiste'), mode='redirects',
                    project='es.wikipedia.org')
a

## ----echo=TRUE----------------------------------------------------------------
i <- m_reqMediaWiki(c('Max Planck', URLdecode("a%CC%8C"), 'Max', 'Cervante', 'humanist'),
                  mode='pagePrimaryImage')

f <- m_reqMediaWiki(c('Max Planck', URLdecode("a%CC%8C"), 'Max', 'Cervante', 'humanist'),
                  mode='pageFiles', exclude_ext = "svg|webp|xcf")

## ----echo=TRUE----------------------------------------------------------------
v <-  m_Pageviews(article="Cervantes", start="20230101", end="20230501",
                   project="es.wikipedia.org", granularity="monthly")
vv <- m_Pageviews(article="Cervantes", start="20230101", end="20230501",
                   project="es.wikipedia.org", granularity="monthly",
                   redirects=TRUE)

## ----echo=TRUE----------------------------------------------------------------
x <-  m_XtoolsInfo(article="Cervantes", infotype="articleinfo", project="es.wikipedia.org")
xx <- m_XtoolsInfo(article="Cervantes", infotype="articleinfo", project="es.wikipedia.org",
                   redirects=TRUE)

y <-  m_XtoolsInfo(article="Miguel de Cervantes", infotype="links", project="es.wikipedia.org")
yy <- m_XtoolsInfo(article="Cervantes", infotype="links", project="es.wikipedia.org",
                    redirects=TRUE)

## ----echo=TRUE----------------------------------------------------------------
z  <- m_XtoolsInfo(article="Miguel de Cervantes", infotype="all", project="es.wikipedia.org")
zz <- m_XtoolsInfo(article="Cervantes", infotype="all", project="es.wikipedia.org",
                       redirects=TRUE)

## ----echo=TRUE----------------------------------------------------------------
v_AutoSuggest('Iranzo')
v_AutoSuggest('Esparza, María')
v_AutoSuggest('Escobar, Modesto')
# Note that four rows are returned, but only two different viafids.

## ----echo=TRUE----------------------------------------------------------------
# Auxiliary function that extracts specific information from each record.
showVIAF <- function(r) {
  i <- 0
  for (j in r) {
    i <- i+1
    # Get viaf record
    viaf <- j$record$recordData
    viafid <- viaf$viafID
    cat(paste0("-----------\nRecord #",i,"\nSources:\n"))
    print(v_Extract(viaf, info='sources'))
    cat("Gender: ");       print(v_Extract(viaf, info='gender'))
    cat("Dates: ") ;       print(v_Extract(viaf, info='dates'))
    cat('Occupations: ');  print(v_Extract(viaf, info='occupations'))
    cat("Titles: ");       print(v_Extract(viaf, info='titles'))
    cat("Wikipedias: ");   print(v_Extract(viaf, info='wikipedias'))
  }
}

## ----echo=TRUE----------------------------------------------------------------
CQL_Query <- 'cql.any = "García Iranzo, Juan"'
r <- v_Search(CQL_Query)
# r contains complete VIAF records (sometimes seen as a "cluster record",
# which is unified by combining records from many libraries around the world)
showVIAF(r)

## ----echo=TRUE----------------------------------------------------------------
r <- v_Search("García Iranzo, Juan", mode="anyField")
showVIAF(r)

## ----echo=TRUE----------------------------------------------------------------
CQL_Query <- 'local.names all "Figuerola"'
r <- v_Search(CQL_Query)

## ----echo=TRUE----------------------------------------------------------------
r2 <- v_Search("Figuerola", mode="allNames")
cat(length(r), length(r2))

## ----echo=TRUE----------------------------------------------------------------
CQL_Query <- 'local.names all "Bolero"'
r <- v_Search(CQL_Query)

## ----echo=TRUE----------------------------------------------------------------
CQL_Query <- 'local.personalNames all "Modesto Escobar"'
r <- v_Search(CQL_Query)
showVIAF(r)

## ----echo=TRUE----------------------------------------------------------------
r <- v_Search("Escobar Mercado, Modesto", mode='allmainHeadingEl')

## ----echo=TRUE----------------------------------------------------------------
CQL_Query <- 'local.title all "Los pronósticos electorales con encuestas"'
r <- v_Search(CQL_Query)
showVIAF(r)

