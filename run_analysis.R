#Reading in the test and training data
test_data<-read.table("C:/Users/natek/Downloads/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
training_data<-read.table("C:/Users/natek/Downloads/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")

#reading in the subject ids
training_subjects<-read.table("C:/Users/natek/Downloads/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
test_subjects<-read.table("C:/Users/natek/Downloads/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

#combining subject ids
test_data<-cbind(test_subjects,test_data)
training_data<-cbind(training_subjects,training_data)

#merging test and training data
data<-rbind(test_data, training_data)

#Reading in and assigning the variable names
col_names<-read.table("C:/Users/natek/Downloads/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
col_names<-as.character(col_names$V2)
col_names<-c("subject", col_names)#adding a subject variable to name list
names(data)<-col_names#assigning names to the dataset


keep1<-grep("mean", col_names)#index of mean indicators
keep2<-grep("std", names(data))#index of std indicators
keep<-c(1,keep1,keep2)#combined index and keeping the subject variable
data_s<-data[,keep]#subsetting the data
drop<-grep("meanFreq",names(data_s))#getting rid of mean Frequency measures
data_s<-data_s[,-drop]

#descriptive variable names
names(data_s)<-sub("\\()","",names(data_s))#getting rid of the "()" in each name
#Other than that, the names seem fairly reasonable to me. 

#Creating the second tidy dataset using dplyr
data_two<-data_s %>% group_by(subject) %>% summarise_each(funs(mean))

#writing out both datasets
write.csv(data_s,"tidy fitness data.csv")
write.csv(data_two,"tidy fitness data by group.csv")





