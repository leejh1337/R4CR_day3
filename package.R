## 1. Github에 Repository 생성 
## 반드시 Public

library(usethis)
library(roxygen2)
library(remotes)
usethis::create_package(getwd())

## Ctrl + Shift + B (Build) = Save
## Build -------------------------

## Note: cloud상에서 만들경우 project 라는 이름으로 패키지를 만들게 됨

## 변경 불가 (5년 전 이슈)
## https://github.com/rstudio/rstudio/issues/1909

## 2. Data in Package
## mydata를 Environment에 저장
## 이름을 변경해도 괜찮음

mydata <- read.csv('https://github.com/zarathucorp/R4CR-content/raw/main/example_g1e.csv')

usethis::use_data(mydata) ## 앞 변수 이름과 동일

## /data directory 변경 확인

## Ctrl + Shift + B (Build) = Save
## Build -------------------------

rm(mydata)

project::mydata # project 라는 Package 의 mydata 라는 데이터 오브젝트

## 3. Data Manual 
## /R에 mydata.R 이라는 파일 생성 (오브젝트 이름과 동일)

file.create('R/mydata.R')

#
# #' @ 로 roxygen2
# #' 
# 'mydata'
# 

#' @title
#' NHIS dataset
#' @description
#' Dataset from National Health Insurance Service (Korea)
#' @format
#' \describe{
#'  \item{EXMD_BZ_YYYY}{Year}
#' }
#' @source
#' https://www.nhis.or.kr/nhis/index.do
"nhisdata"

## Ctrl + Shift + D (Document)
## man / mydata.Rd 확인

## Document ---------------------
## Build ------------------------

## 4. Function in Package

## /R에 생성

file.create("R/manual.R")
manual <- function(){
  print('https://nhiss.nhis.or.kr/bd/ab/bdaba006cv.do')
}

file.create("R/add.R")

add <- function(x, y){
  return(x, y)
}

#
# #' @export
# 

## Document ---------------------
## Build ------------------------

### Description

Package: nhis
Title: Example Dataset of NHIS for clinical research
Version: 0.0.1
Authors@R: 
  person("Jinhwan", "Kim", , "jinhwan@zarathu.com", role = c("aut", "cre"),
         comment = c(ORCID = "YOUR-ORCID-ID"))
Description: Dataset of NHIS
License: MIT + file LICENSEEncoding: UTF-8
Roxygen: list(markdown = TRUE)
RoxygenNote: 7.2.3
Depends: 
  R (>= 2.10)
LazyData: true




## 5. Publish

## tools -> version control (restart)

## git / staged / commit


## Github 설정 코드

usethis::use_git_config(
  user.name = "jhk0530", # 상관 없음
  user.email = "hwanistic@gmail.com" # github 이메일
)

credentials::credential_helper_set("store") # posit cloud

usethis::create_github_token() 

## 토큰 이름만 변경 + 기한 설정 . 이후 발급

credentials::set_github_pat() ## 복붙 & 세션 리스타트

## commit + push
## repo 확인

## 6. Use Package
## 오른쪽 아래 Packages에 project 있음. 

remove.packages("project") # 삭제, rsession restart

## project::mydata 자동완성 안됨

remotes::install_github('jhk0530/project') ## github에서 설치

library(project)

manual()

add(1, 2)

## Note
## project가 아닌 다른 이름. -> 로컬에서 해야 함. 이건 클라우드에서 수정 불가능
