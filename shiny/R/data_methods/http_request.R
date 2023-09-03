##### THIS WHOLE FILE IS TBD codes #####

if(! require("httr")) install.packages("httr")
require("httr")

if(! require("jsonlite")) install.packages("jsonlite")
require("jsonlite")



# http_post <- function (endpoint, request_body, api_base, key) {
#   #print(request_body)
#   request_body_json <- toJSON(request_body, auto_unbox = TRUE)
#   print(paste(api_base,endpoint, sep=""))
#   
#   result <- POST(paste(api_base,endpoint, sep=""),
#                body = request_body_json,
#                add_headers(`Content-Type`="application/json",`api-key`= key))
#   #print(result)
#   #return("ok")
#   return (content(result))
#   # return(result)
# }

http_post <- function (endpoint, request_body, api_base, key) {
  h2 <- handle('')
  #print(request_body)
  request_body_json <- toJSON(request_body, auto_unbox = TRUE)
  request_body_json <- str_replace_all(request_body_json, "\"TRUE\"", "true")
  request_body_json <- str_replace_all(request_body_json, "\"FALSE\"", "false")
  # request_body_json <- toJSON(fromJSON(request_body_json), auto_unbox = TRUE)
  print(request_body_json)
  print(typeof(request_body_json))
  print(paste(api_base,endpoint, sep=""))
  
  result <- POST(paste(api_base,endpoint, sep=""),
                 body = request_body_json,
                 add_headers(`Content-Type`="application/json",`api-key`= key),
                 handle=h2)
  print(result)
  #return("ok")
  return (content(result))
  # return(result)
}

http_get <- function (endpoint, api_base, key) {
  call <- paste(api_base,endpoint, sep="")
  response <- GET(call, add_headers(`Content-Type`="application/json",`api-key`= key))
  response_text <- content(response, "text")
  response_json <- fromJSON(response_text, flatten = TRUE)
  # response_df <- as.data.frame(response_json)
  # View(response_df)
  return (response_json)
}
# http_get("indicator_taxonomies")

http_publish <- function (country, api_base, key) {
  # print(request_body)
  # request_body_json <- toJSON(request_body, auto_unbox = TRUE)
  callText<-paste(api_base, "publish-data?geo=", country, sep="")
  
  result <- GET(callText,
                 add_headers(`Content-Type`="application/json", `api-key`= key))
  

  print(callText)
  #return("ok")
  return (content(result))
  # return(result)
}


