# FIT Backup ----------------------------------------------------------------------------------

## Download a list of repository names of organization in a json file
## Use for loop to download each repository by reading the clone url in the json file
## Upload files to GoogleDrive

# Library packages and set working directory --------------------------------------------------

# install.packages("rjson")
library("rjson")

#work_dir <- tempdir()
work_dir <- "C:/Users/bai.li/Desktop/FIT_backup"
token_num <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

header_info <- paste("token", token_num)

# Download a list of repo names in a json file ------------------------------------------------

# User's organization list

url_data_dir <- file.path(work_dir, "url_data.json")
download.file(
  url = "https://api.github.com/user/orgs",
  destfile = url_data_dir,
  headers = list(
    Authorization = header_info
  )
)

json_data <- rjson::fromJSON(file=url_data_dir)

user_organizations_url <- sapply(1:length(json_data), function(x){
  json_data[[x]]$repos_url
})

user_organizations_name <- sapply(1:length(json_data), function(x){
  json_data[[x]]$login
})

sapply(1:length(user_organizations_name), function(x){
  dir.create(file.path(work_dir, user_organizations_name[x]))
})

# Download public repos

for (org_id in 1:length(user_organizations_url)){
  file_path <- file.path(work_dir,
                         paste(user_organizations_name[org_id],
                               "-public.json",
                               sep=""))
  # Download repo list for an organization
  download.file(
    url = paste(user_organizations_url[org_id], "?type=public&per_page=100", sep=""),
    destfile = file_path,
    headers = list(
      Authorization = header_info
    )
  )
  
  
  json_data <- fromJSON(file=file_path)
  
  if (length(json_data) != 0) {
    repo_url <- sapply(1:length(json_data), function(x){
      json_data[[x]]$ssh_url
    })
    
    repo_name <- sapply(1:length(json_data), function(x){
      json_data[[x]]$name
    })
    
    
    for (repo_id in 1:length(repo_url)){
      file_path <- file.path(work_dir, user_organizations_name[org_id], repo_name[repo_id])
      
      shell(paste("git clone", repo_url[repo_id], file_path))
    }
  }
}

# Download private repos

for (org_id in 1:length(user_organizations_url)){
  file_path <- file.path(work_dir,
                         paste(user_organizations_name[org_id],
                               "-private.json",
                               sep=""))
  # Download repo list for an organization
  download.file(
    url = paste(user_organizations_url[org_id], "?type=private&per_page=100", sep=""),
    destfile = file_path,
    headers = list(
      Authorization = header_info
    )
  )
  
  json_data <- fromJSON(file=file_path)
  
  if (length(json_data) != 0) {
    repo_url <- sapply(1:length(json_data), function(x){
      json_data[[x]]$ssh_url
    })
    
    repo_name <- sapply(1:length(json_data), function(x){
      json_data[[x]]$name
    })
    
    
    for (repo_id in 1:length(repo_url)){
      file_path <- file.path(work_dir, user_organizations_name[org_id], repo_name[repo_id])
      
      shell(paste("git clone", repo_url[repo_id], file_path))
    }
  }
  
  
}

zip(zipfile="FITbackup" , files = work_dir)
