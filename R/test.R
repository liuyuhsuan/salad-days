library(httr)
library(XML)
library(RCurl)

# get download page url path
subpathURL = "https://www.ptt.cc/bbs/movie/index"
startNo = 4649
endNo = 4667
alltitle = data.frame()
for(i in c(startNo:endNo))
{
  pathURL = paste(subpathURL, i, ".html", sep="")
  print(pathURL)
  tempDATA = getURL(pathURL)
  xmldoc = htmlParse(tempDATA, encoding="UTF-8")
  title = xpathApply(xmldoc, "//div[@class=\"title\"]", xmlValue)
  url = xpathApply(xmldoc, "//div[@class=\"title\"]/a//@href")
  date = xpathApply(xmldoc, "//div[@class=\"date\"]",xmlValue)
  result = tryCatch({
      alltitle = rbind(alltitle, data.frame(title))
      print(url)
  }, error = function(err){
    print(url)
  }
  )
}
