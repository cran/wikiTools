## ----eval=FALSE---------------------------------------------------------------
# install.packages("wikiTools")

## ----echo=TRUE----------------------------------------------------------------
library(wikiTools)

## ----eval=FALSE---------------------------------------------------------------
# df <- w_SearchByLabel(string='Iranzo', langsorder='es|en')
# df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', instanceof = 'Q5')
# df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', instanceof = 'Q5|Q101352')
# df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', instanceof = 'Q5',
#                       Pproperty = 'P21|P569|P570')

## ----eval=FALSE---------------------------------------------------------------
# df <- w_SearchByLabel(string='Iranzo', lang='en', langsorder='es|en', mode='startswith')
# df <- w_SearchByLabel(string='Iranzo', lang='en', langsorder='es|en', instanceof = 'Q5',
#                       mode='startswith')
# df <- w_SearchByLabel(string='Iranzo', lang='en', langsorder='es|en',
#                       instanceof = 'Q5|Q101352', mode='startswith')
# df <- w_SearchByLabel(string='Iranzo', lang='en', langsorder='en', instanceof = 'Q5',
#                       Pproperty = 'P21|P569|P570', mode='startswith')

## ----eval = FALSE-------------------------------------------------------------
# df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', mode='inlabel')

## ----eval=FALSE---------------------------------------------------------------
# df <- w_SearchByLabel(string='Iranzo', langsorder='zh|es', lang='zh', mode='inlabel')

## ----eval = FALSE-------------------------------------------------------------
# df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', instanceof = 'Q5',
#                       mode='inlabel')
# df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', instanceof = 'Q5|Q101352',
#                       mode='inlabel')
# df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', instanceof = 'Q5',
#                       Pproperty = 'P21|P569|P570', mode='inlabel')

## ----w_SearchByLabel, echo=TRUE-----------------------------------------------
df <- w_SearchByLabel(string='Iranzo', langsorder='es|en', mode='inlabel')
if(length(df)){
  l <- df$entity
}else{
  l <- c("Q45975643", "Q107379816", "Q61892699")
}

## ----w_isIntanceOf, echo=TRUE-------------------------------------------------
df <- w_isInstanceOf(entity_list=l, instanceof='Q5')
# Not TRUE
if(length(df)){
  df[!df$instanceof_Q5,]
}

## ----eval = FALSE-------------------------------------------------------------
# df <- w_Wikipedias(entity_list=l)
# df <- w_Wikipedias(entity_list=l, wikilangs='es|en|fr')
# df <- w_Wikipedias(entity_list=l, wikilangs='es|en|fr', instanceof="Q5")

## ----w_SearchByOccupation, eval = FALSE---------------------------------------
# w_SearchByOccupation(Qoc="Q2306091", mode='count') # "Q2306091" Qoc for Sociologist
# q <- w_SearchByOccupation(Qoc="Q2306091")

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# lw <- w_SearchByOccupation(Qoc='Q2306091', mode='wikipedias') # lw=dataframe
# # We can obtain the same information using previous function w_Wikipedias:
# lw2 <- w_Wikipedias(entity_list=l)
# # Verifying:
# all(lw['Q10320558','pages'] == lw2['Q10320558','pages'])
# # Verifying:
# all(sort(strsplit(lw['Q9061', 'pages'], '|', fixed = T)[[1]]) ==
#     sort(strsplit(lw2['Q9061', 'pages'], '|', fixed = T)[[1]]))

## ----w_isValid, echo=TRUE-----------------------------------------------------
l2 <- append(l, c("Q115637688", "Q105660123"))  # Note: adding two new entities
v <- w_isValid(l2)
if(length(v)){
  # Not valid
  v[!v$valid,]
}

## ----eval = FALSE-------------------------------------------------------------
# p <- w_Property(l, Pproperty = 'P21|P569|P214', langsorder = 'es|en')

## ----eval = FALSE-------------------------------------------------------------
# mncars   <- w_SearchByAuthority(Pauthority="P4439", langsorder = 'es|en')
# # 1286  [human, groups, etc.]
# mncarsQ5 <- w_SearchByAuthority(Pauthority="P4439", langsorder = 'es|en',
#                                      instanceof = 'Q5')  # 1280
# # Entities are not 'human' (Q5) [see entityDescription column):
# mncars   <- w_SearchByAuthority(Pauthority="P4439", langsorder = 'es|en')
# if(length(mncars) && length(mncarsQ5)){
#   mncars[!(mncars$entity %in% mncarsQ5$entity),]  # not instance of Q5.
# }

## ----eval = FALSE-------------------------------------------------------------
# df <- w_EntityInfo(entity_list='Q134644', langsorder='es|en')
# df <- w_EntityInfo(entity_list='Q134644', langsorder='es|en', wikilangs='es|en|fr')
# df <- w_EntityInfo(c('Q270510', 'Q1675466', 'Q24871'), mode='film', langsorder='es|en', wikilangs='es|en|fr')
# # Search string 'van Beethoven' inlabel
# w <- w_SearchByLabel('van Beethoven', mode='inlabel', langsorder = '', instanceof = 'Q5')
# if(length(w)){
#   df <- w_EntityInfo(w$entity, langsorder='en', wikilangs='en|es|fr', debug='info')
# }
# # Search 3D films
# w <- w_SearchByInstanceof(instanceof='Q229390', langsorder = 'en|es', debug = 'info')
# if(length(w)){
#   df <- w_EntityInfo(w$entity, mode="film", langsorder='en', wikilangs='en', debug='info')
# }

## ----eval = FALSE-------------------------------------------------------------
# df <- m_Opensearch(string='Duque de Alba', project='es.wikipedia.org',
#                    profile="engine_autoselect", redirects="resolve")
# df <- m_Opensearch(string='Duque de Alba', project='es.wikipedia.org', profile="strict")
# df <- m_Opensearch(string='Duque de Alba', project='es.wikipedia.org', profile="fuzzy")

## ----eval = FALSE-------------------------------------------------------------
# df <- m_reqMediaWiki(c('Max Planck', URLdecode("a%CC%8C"), 'Max', 'Cervante', 'humanist'),
#                         mode='wikidataEntity', project='en.wikipedia.org')

## ----mreqMediaWiki, echo=TRUE-------------------------------------------------
a <- m_reqMediaWiki(c('Cervantes', 'Planck', 'Noexiste'), mode='redirects',
                    project='es.wikipedia.org')
a

## ----eval = FALSE-------------------------------------------------------------
# i <- m_reqMediaWiki(c('Max Planck', URLdecode("a%CC%8C"), 'Max', 'Cervante', 'humanist'),
#                   mode='pagePrimaryImage')
# 
# f <- m_reqMediaWiki(c('Max Planck', URLdecode("a%CC%8C"), 'Max', 'Cervante', 'humanist'),
#                   mode='pageFiles', exclude_ext = "svg|webp|xcf")

## ----eval = FALSE-------------------------------------------------------------
# v <-  m_Pageviews(article="Miguel de Cervantes", start="20230101", end="2026028",
#                    project="es.wikipedia.org", granularity="monthly")

## ----eval = FALSE-------------------------------------------------------------
# x <-  m_XtoolsInfo(article="Cervantes", infotype="articleinfo", project="es.wikipedia.org")
# xx <- m_XtoolsInfo(article="Cervantes", infotype="articleinfo", project="es.wikipedia.org",
#                    redirects=TRUE)
# 
# y <-  m_XtoolsInfo(article="Miguel de Cervantes", infotype="links", project="es.wikipedia.org")
# yy <- m_XtoolsInfo(article="Cervantes", infotype="links", project="es.wikipedia.org",
#                     redirects=TRUE)

## ----eval = FALSE-------------------------------------------------------------
# z  <- m_XtoolsInfo(article="Miguel de Cervantes", infotype="all", project="es.wikipedia.org")
# zz <- m_XtoolsInfo(article="Cervantes", infotype="all", project="es.wikipedia.org",
#                        redirects=TRUE)

## ----eval = FALSE-------------------------------------------------------------
# v_AutoSuggest('Iranzo')
# v_AutoSuggest('Esparza, María')
# v_AutoSuggest('Escobar, Modesto')
# # Note that four rows are returned, but only two different viafids.

## ----v_Search, echo=TRUE------------------------------------------------------
CQL_Query <- 'cql.any = "García Iranzo, Juan"'
r <- v_Search(CQL_Query)
# r contains complete VIAF records (sometimes seen as a "cluster record",
# which is unified by combining records from many libraries around the world)
v_Extract(r)

## ----echo=TRUE----------------------------------------------------------------
r <- v_Search("García Iranzo, Juan", mode="anyField")
v_Extract(r)

## ----eval = FALSE-------------------------------------------------------------
# CQL_Query <- 'local.names all "Figuerola"'
# r <- v_Search(CQL_Query)

## ----eval = FALSE-------------------------------------------------------------
# r2 <- v_Search("Figuerola", mode="allNames")
# cat(length(r), length(r2))

## ----eval = FALSE-------------------------------------------------------------
# CQL_Query <- 'local.names all "Bolero"'
# r3 <- v_Search(CQL_Query)

## ----echo=TRUE----------------------------------------------------------------
CQL_Query <- 'local.personalNames all "Modesto Escobar"'
r <- v_Search(CQL_Query)
v_Extract(r)

## ----eval = FALSE-------------------------------------------------------------
# r <- v_Search("Escobar Mercado, Modesto", mode='allmainHeadingEl')

## ----echo=TRUE----------------------------------------------------------------
CQL_Query <- 'local.title all "Los pronósticos electorales con encuestas"'
r <- v_Search(CQL_Query)
v_Extract(r)

