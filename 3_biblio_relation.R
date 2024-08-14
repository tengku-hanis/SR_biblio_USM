# Relationship-related metrics (science mapping)
# Tengku Muhd Hanis Mokhtar (https://tengkuhanis.netlify.app/)
# Jom Research (https://jomresearch.netlify.app/)
# Aug15, 2024

# Packages ----------------------------------------------------------------

library(bibliometrix)
library(tidyverse)
theme_set(theme_bw())

# Data --------------------------------------------------------------------

dat <- 
  convert2df(file = "wos.bib", dbsource = "wos", format = "bibtex")

dat2 <- 
  dat %>% 
  filter(DT %in% c("ARTICLE", "ARTICLE; PROCEEDINGS PAPER", "PROCEEDINGS PAPER", "REVIEW"))


# Relationship related metrics --------------------------------------------

# Details see ?biblioNetwork

## 1) Collaboration ----

#authors, universities, countries
MT <- metaTagExtraction(dat2, Field = "AU_CO", sep = ";")
country_collab <- biblioNetwork(MT, analysis = "collaboration",  network = "countries")

# Plot
set.seed(123)
country_net <- networkPlot(country_collab, n = 30, cluster = "none", #try "optimal"
                           Title = "Countries collaboration", type = "circle",
                           size.cex = T)
country_net$nodeDegree
country_net$cluster_res #if we have clusters

## 2) Co-citation ----
# For foundation/basic theme

#authors, references, sources
ref_cc <- biblioNetwork(dat2, analysis = "co-citation", network = "references", sep = ";")

set.seed(123)
networkPlot(ref_cc, n = 30, cluster = "none", 
            Title = "Co-citation of references", type = "circle",
            size.cex = T)

## 3) Coupling ----
# Latest development

#authors, references, sources, countries
auth_couple <- biblioNetwork(dat2, analysis = "coupling", network = "authors", sep = ";")

set.seed(123)
networkPlot(auth_couple, n = 30, cluster = "none", 
            Title = "Bibliographic coupling of the authors", type = "circle",
            size.cex = T)

## 4) Co-word analysis ----
# May indicate a trend or support for co-citation or coupling

#authors, sources, keywords, author_keywords, titles, abstracts
kw_co <- biblioNetwork(dat2, analysis = "co-occurrences", network = "keywords", sep = ";")

set.seed(123)
networkPlot(kw_co, n = 50, cluster = "optimal", 
            Title = "Keyword co-occurrences", type = "circle",
            size.cex = T)
