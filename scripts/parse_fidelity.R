#!/usr/bin/env Rscript
# simple script that parses a fidelity transaction csv file looking for all 
# dividends received and then aggregating them.

args = commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  stop("Missing input file", call.=FALSE)
}

df <- read.csv(args[1],header = T)

# get only Action that are dividend received,
action.filter <- grep("*DIVIDEND RECEIVED*",df$Action)
# only interested in Symbol and amount
df <- df[action.filter,c('Symbol','Amount')]
# sum Amount based on Symbol
df.sum <- aggregate(Amount ~ Symbol, df, sum)
print(df.sum)