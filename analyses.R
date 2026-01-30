## Analyze bibliometrics data for spatial synchrony

rm(list=ls())

library(stringr)
library(foreign)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#dat.raw<- readxl::read_excel("WOS_results_spatialSynchrony_20241125.xls", sheet=1)
dat.raw <- read.csv("WOS_results_spatialSynchrony_20241125.csv")

table(dat.raw$Source.Title)

dat <- dat.raw[dat.raw$Publication.Year >=2000 & dat.raw$Publication.Year <= 2024,] #set time range
dat <- dat[dat$Publication.Type=="J",] #journal articles only
dat$Source.Title[grepl("NEURO",dat$Source.Title)] 
dat <- dat[!grepl("NEURO",dat$Source.Title),] #exclude nueroscience


table(dat$Source.Title)

dat <- dat[dat$Source.Title != "ACS NANO",]
dat <- dat[dat$Source.Title != "AMERICAN JOURNAL OF PHYSIOLOGY-CELL PHYSIOLOGY",]
dat <- dat[dat$Source.Title != "ANESTHESIOLOGY",]
dat <- dat[dat$Source.Title != "APPLIED MATHEMATICS AND COMPUTATION",]
dat <- dat[dat$Source.Title != "ARTS IN PSYCHOTHERAPY",]
dat <- dat[dat$Source.Title != "AUTOMATICA",]
dat <- dat[dat$Source.Title != "BRAIN TOPOGRAPHY",]
dat <- dat[dat$Source.Title != "CELLS",]
dat <- dat[dat$Source.Title != "CHAOS",]
dat <- dat[dat$Source.Title != "CHAOS SOLITONS & FRACTALS",]
dat <- dat[dat$Source.Title != "DISCRETE AND CONTINUOUS DYNAMICAL SYSTEMS-SERIES B",]
dat <- dat[dat$Source.Title != "EPILEPSIA",]
dat <- dat[dat$Source.Title != "INTERNATIONAL JOURNAL OF ADVANCED ROBOTIC SYSTEMS",]
dat <- dat[dat$Source.Title != "INTERNATIONAL JOURNAL OF BIFURCATION AND CHAOS",]
dat <- dat[dat$Source.Title != "INTERNATIONAL JOURNAL OF COMPUTER APPLICATIONS IN TECHNOLOGY",]
#dat <- dat[dat$Source.Title != "JOURNAL OF MATHEMATICAL BIOLOGY",]
dat <- dat[dat$Source.Title != "JOURNAL OF SOCIAL AND PERSONAL RELATIONSHIPS",]
dat <- dat[dat$Source.Title != "SIAM JOURNAL ON APPLIED MATHEMATICS",]
dat <- dat[dat$Source.Title != "STOCHASTICS-AN INTERNATIONAL JOURNAL OF PROBABILITY AND STOCHASTIC PROCESSES",]
dat <- dat[dat$Source.Title != "ZHURNAL VYSSHEI NERVNOI DEYATELNOSTI IMENI I P PAVLOVA",]
dat <- dat[dat$Source.Title != "SIMULATION MODELLING PRACTICE AND THEORY",]
dat <- dat[dat$Source.Title != "PHYSICAL REVIEW E",]
dat <- dat[dat$Source.Title != "PHYSICA A-STATISTICAL MECHANICS AND ITS APPLICATIONS",]
dat <- dat[dat$Source.Title != "PHOTOGRAMMETRIC ENGINEERING AND REMOTE SENSING",]

sourceCount <- as.data.frame(table(dat$Source.Title))
