# ============================================================
# Project: CDISC Pilot Statistical Programming
# Study:   CDISCPILOT01
# Program: 01_explore_data_flow.R
#
# Purpose:
#   Explore the relationship between example Raw,
#   SDTM and ADaM datasets.
#
# Data flow:
#   Raw -> SDTM -> ADaM -> TFL
# ============================================================


# ------------------------------------------------------------
# 1. Load packages
# ------------------------------------------------------------

library(pharmaverseraw)
library(pharmaversesdtm)
library(pharmaverseadam)
library(dplyr)


# ------------------------------------------------------------
# 2. Load example datasets
# ------------------------------------------------------------

# Raw demographics
dm_raw <- pharmaverseraw::dm_raw
# SDTM Demographics
dm <- pharmaversesdtm::dm

# ADaM Subject-Level Analysis Dataset
adsl <- pharmaverseadam::adsl


# ------------------------------------------------------------
# 3. Basic dataset inspection
# ------------------------------------------------------------

dim(dm_raw)
dim(dm)
dim(adsl)

names(dm_raw)
names(dm)
names(adsl)


# ------------------------------------------------------------
# 4. View datasets
# ------------------------------------------------------------

View(dm_raw)
View(dm)
View(adsl)


# ------------------------------------------------------------
# 5. Confirm study identifiers
# ------------------------------------------------------------

unique(dm_raw$STUDY)

unique(dm$STUDYID)

unique(adsl$STUDYID)


# ------------------------------------------------------------
# 6. Examine selected Raw variables
# ------------------------------------------------------------

dm_raw %>%
  select(
    STUDY,
    PATNUM,
    IT.AGE,
    IT.SEX,
    IT.ETHNIC,
    IT.RACE,
    COUNTRY,
    PLANNED_ARM,
    ACTUAL_ARM
  ) %>%
  head(10)


# ------------------------------------------------------------
# 7. Examine selected SDTM DM variables
# ------------------------------------------------------------

dm %>%
  select(
    STUDYID,
    USUBJID,
    SUBJID,
    SITEID,
    AGE,
    AGEU,
    SEX,
    ETHNIC,
    RACE,
    COUNTRY,
    ARM,
    ACTARM
  ) %>%
  head(10)


# ------------------------------------------------------------
# 8. Examine selected ADaM ADSL variables
# ------------------------------------------------------------

adsl %>%
  select(
    STUDYID,
    USUBJID,
    AGE,
    SEX,
    RACE,
    TRT01P,
    TRT01A
  ) %>%
  head(10)


# ------------------------------------------------------------
# 9. Check record counts
# ------------------------------------------------------------

cat("Raw DM records :", nrow(dm_raw), "\n")
cat("SDTM DM records:", nrow(dm), "\n")
cat("ADSL records   :", nrow(adsl), "\n")


# ------------------------------------------------------------
# 10. Check subject uniqueness
# ------------------------------------------------------------

cat(
  "Unique subjects in SDTM DM:",
  n_distinct(dm$USUBJID),
  "\n"
)

cat(
  "Unique subjects in ADaM ADSL:",
  n_distinct(adsl$USUBJID),
  "\n"
)


# ------------------------------------------------------------
# 11. Planned treatment distribution
# ------------------------------------------------------------

table(dm$ARM, useNA = "ifany")

table(adsl$TRT01P, useNA = "ifany")
