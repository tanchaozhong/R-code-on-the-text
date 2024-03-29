# Review results
# During each review, I need to remove useless papers that already identified.

setwd('XXXX')

#1. Using list to screen results####
#Objectives:
# 1) Remove publications that already been identified 'yes' or 'no'
# 2) Output the identified list - 'yes' and 'no'
# 3) Output the remaining list for further identification

#1 Input yes and no lists
  # File: Articles in MS.xlxs
  #   sheet: YES-articles
  #     Column: 'Article.Title'
  Yes.articles <- read.csv('YES.articles.csv',header=TRUE)
  Yes.list <- Yes.articles$Article.Title
  
  # File: Articles in MS.xlxs
  #   sheet: NO-articles
  #     Column: 'Article.Title'
  No.articles <- read.csv('NO.articles.csv',header=TRUE)
  No.list <- No.articles$Article.Title

#2 Input the derived table
name.regional <- 'XXX'
name.pre.screen <- paste(name.regional,'csv',sep='.')
data <- read.csv(name.pre.screen, header=TRUE)
pre.screen <- data$Article.Title

#3 Screen process
i=0; already.yes.articles.index <- NULL;already.no.articles.index <- NULL
no.list.occured <- NULL;yes.list.occured <- NULL
repeat{
  i=i+1
  pre.screen[i]
  # compare each titles in pre.screen with yes list
  j=0;
  repeat{
    j=j+1
    # If I found one match, we takeout the matched ones
    if (pre.screen[i] == Yes.list[j]) 
    {
      already.yes.articles.index <- c(already.yes.articles.index,i)
      yes.list.occured <- c(yes.list.occured,j)
      break
    }
    if(j==length(Yes.list))break
  }
  
  # compare with no list
  k=0
  repeat{
    k=k+1
    # If I found one match, we takeout the matched ones
    if (pre.screen[i] == No.list[k]) 
    {
      already.no.articles.index <- c(already.no.articles.index,i)
      no.list.occured <- c(no.list.occured,k)
      break
    }
    if(k==length(No.list))break
  }

  if(i==length(pre.screen))break
}


#4 which yes paper appeared in the yes and no list
already.yes.articles.index
already.no.articles.index

yes.list.occur.article <- Yes.articles[yes.list.occured,]
no.list.occur.article <- No.articles[no.list.occured,]

# How many yes paper are screened
length(already.yes.articles.index)

# How many no paper are screend
length(already.no.articles.index)


#5 Output the articles after screen
already.yes <- pre.screen[already.yes.articles.index]
#already.no <- pre.screen[already.no.articles.index]
after.screen <- rbind(data[already.yes.articles.index,]
                      ,data[already.no.articles.index,]
                      ,data[-c(already.yes.articles.index,already.no.articles.index),]
                      )

name.after.screen = paste(name.regional,'simplify','After.screen','csv',sep='.')
write.csv(after.screen,name.after.screen)

name.after.screen.yes  = paste(name.regional,'simplify','After.screen','yes','csv',sep='.')
name.after.screen.no  = paste(name.regional,'simplify','After.screen','no','csv',sep='.')

write.csv(yes.list.occur.article,name.after.screen.yes)
write.csv(no.list.occur.article,name.after.screen.no)
