## Find citations in the paper##

text <- readClipboard(format=1, raw = FALSE) # input the content from the clipboard
head(text,5) # check the first 10 row
tail(text,5) # check the last 10 row

# record content between "( XX )"
a=0; ref.list.final <- NULL
repeat{
  a=a+1
  if( a > length(text) )break

  # Choose one to analysis
  { checklist <- strsplit(text[a],"") # split the string by space ""
    checklist <- checklist[[1]] # Attention!!! have to add [[1]]
  }

  # find "(" and ")"
  n <- length(checklist);i=0
  index.before <- NULL; index.after <- NULL
  repeat{
    i=i+1
    if (i>n) break
    if (checklist[i]=='(') index.before <- c(index.before,i)
    if (checklist[i]==')') index.after <- c(index.after,i)
    
  }

  ref.list <- NULL # In case index.before is NULL
  if (length(index.before) >0 ){

    # record the content from "(" and ")" 
    ref <- NULL;ref.list <- NULL
    for (j in ( 1:length(index.before) ) ) {
      ref <-checklist[(index.before[j]+1):(index.after[j]-1)]

      check <- ref; n <- length(check[check==';']) # Check if there is ";", i.e. multiple citations     
      name <- paste(ref,collapse ="") # combine all the letters

      # if there are multiple citation, saperate and arrange them into rowlines
      name.col <- NULL
        if (n>0){
          name.sep <- strsplit(name,';') # saperate them by ";"
          name.sep <- name.sep[[1]] # Attention!!! Have to do this
          for(q in 1:(n+1)){
            name.col <- rbind(name.col, name.sep[q]) # arrange them in to row lines
          }
          name <- name.col
        }
      ref.list <- rbind(ref.list,name)
      }
  }# Run if index.before is not NULL

  ref.list.final <- rbind(ref.list.final,ref.list) #Final reference list
}
ref.list.final

#write.csv(ref.list.final, "C:\\Users\\Tan\\Downloads\\reference list.csv") 

# remove citations without year

# This function is to check if the content include year
is.includ.year <- function(string){
  year <- NULL
  i=1000
  repeat{
    i=i+1
    if (i>2024) break
    year <- c(year,i)
  }
  
  string <- strsplit(string,' ') # sep the string by space, " "
  string <- string[[1]]
  
  b=0
  for (i in string){
    for (j in year) {if (i==j) b=b+1}
  }
  b
  if (b>0) return(TRUE)
  if (b==0) return(FALSE)
}
#string <- "Feld et al. 2016"
#string <- "Mann-Whitney U test, p < 0.01"
#is.includ.year(string)


list.select <- NULL
for (i in ref.list.final){
  if ( is.includ.year(i) == TRUE ) list.select <- c(list.select, i)
}
list.select

# remove content just includ one character
list.select2 <- NULL
for (i in list.select){
  i.check <- strsplit(i," ")
  i.check <- i.check[[1]]
  if ( length(i.check)>1 ) list.select2 <- c(list.select2, i)
}
list.select2
#write.csv(list.select2, "C:\\Users\\Tan\\Downloads\\list.select2.csv") 

# remove redundant

## indentify the redundant content

index.redundant <- function(checklist){
  # This function output the redundant index
  #
  list.index <- NULL
  for (i in checklist){
    n <- length(checklist[checklist==i]) # check if this one is redundant

    if (n>1){                                  # run this if the one is redundant
      index <- NULL
      for (j in 1:length(checklist)){       # check the redundance one by one
        if (checklist[j] == i) index <- c(index,j)
      } # check the redundance one by one
      index <- index[-1]
    }# run this if the one is redundant
    list.index <- c(list.index,index)
  }
  return(list.index)
}

redundant.list <- index.redundant(list.select2)
list.select3 <- list.select2[-redundant.list]

# Document in the excel
write.csv(list.select3, "C:\\Users\\Tan\\Downloads\\list.select3.csv") 