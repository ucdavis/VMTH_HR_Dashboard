







library(openxlsx)
library(tidyverse)
library(readxl)
library(dplyr)
library(zoo)
library(here)
library(lubridate)


### read in data

here::here()

match<-read_excel(here("matching try.xlsx"), sheet = 1)

people<-read_excel(here("people.xlsx"), sheet = 1)






ab1<-read_excel(here("apr absent 22.xlsx"), sheet = 1)

###ab2<-read_excel(here("feb absent 22.xlsx"), sheet = 1)

###ab<-rbind(ab1,ab2)

ab<-ab1

dep<-read_excel(here("department matching.xlsx"), sheet = 1)



### combine data

people_dep<-as.data.frame(unique(people$`Department`))


july_dep<-as.data.frame(unique(ab$Department))

names(people_dep)<-'Department'

ab2<-ab %>% 
  filter(!(is.na(`Employee Name`)))

ab2$Department<-toupper(ab2$Department)

dep$Department<-toupper(dep$Department)

dep$new_department<-toupper(dep$new_department)

ab3<-left_join(ab2,dep)


dep$Department<-toupper(dep$Department)

people$Department<-toupper(people$Department)

pep2<-left_join(people,dep)

pep2$new_department[pep2$Department == 'FA HERD HEALTH']= 'LAM - Equine'

pep2$new_department[pep2$Department == 'LA ANESTHESIA']= 'LAM - Equine'

pep2$new_department[pep2$Department == 'EQUINE MEDICINE (FS)']= 'LAM - Equine'

pep2$new_department[pep2$Department == 'EQUINE DENTISTRY']= 'LAM - Equine'

pep3<-pep2 %>% 
  filter(!(is.na(new_department)))

### tidying


ab_salary6<-ab3
ab_salary6$day<-weekdays(ab_salary6$`Timesheet Date`)

### holidays

a<-as.Date("2020/11/11")
b<-as.Date("2020/11/26")
c<-as.Date("2020/11/27")
d<-as.Date("2020/12/24")
e<-as.Date("2020/12/25")
f<-as.Date("2020/12/31")
g<-as.Date("2021/01/01")
h<-as.Date("2021/01/18")
ii<-as.Date("2021/02/15")
j<-as.Date("2021/03/26")
k<-as.Date("2021/05/31")
l<-as.Date("2021/06/28")
m<-as.Date("2021/07/05")
n<-as.Date("2021/09/06")
o<-as.Date("2021/11/11")
p<-as.Date("2021/11/24")
q<-as.Date("2021/11/25")
r<-as.Date("2021/12/24")
s<-as.Date("2021/12/25")
t<-as.Date("2021/12/30")
u<-as.Date("2021/12/31")
v<-as.Date("2022/01/17")
w<-as.Date("2022/02/21")
x<-as.Date("2022/03/25")

holidays<-as.data.frame(rbind(a,b,c,d,e,f,g,h,ii,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x))




### take out people who work on weekends cause I will need to just get their schedule later

weekends<-c('Saturday','Sunday')

ab_salary7<-ab_salary6 %>% 
  filter(!(day %in% weekends)) %>% 
  select(!c(day))


ab_hour1<-ab_salary7 %>% 
  select(1,3,8,5,4)




colnames(ab_hour1) <- c("Employee Name" , "Timesheet Date", "TBD" ,  "hours","type")


absent_all<-rbind(ab_hour1)




### removing weekends and holidays from both final data frames

absent_all$day<-weekdays(absent_all$`Timesheet Date`)


absent_all3<-absent_all %>% 
  filter(`Timesheet Date` != a) %>% 
  filter(`Timesheet Date` != b) %>% 
  filter(`Timesheet Date` != c) %>% 
  filter(`Timesheet Date` != d) %>% 
  filter(`Timesheet Date` != e) %>% 
  filter(`Timesheet Date` != f) %>% 
  filter(`Timesheet Date` != g) %>% 
  filter(`Timesheet Date` != h) %>% 
  filter(`Timesheet Date` != ii) %>% 
  filter(`Timesheet Date` != j) %>%
  filter(`Timesheet Date` != k) %>% 
  filter(`Timesheet Date` != l) %>% 
  filter(`Timesheet Date` != m) %>% 
  filter(`Timesheet Date` != n) %>% 
  filter(`Timesheet Date` != o) %>% 
  filter(`Timesheet Date` != p) %>% 
  filter(`Timesheet Date` != q) %>% 
  filter(`Timesheet Date` != r) %>% 
  filter(`Timesheet Date` != s) %>% 
  filter(`Timesheet Date` != t) %>% 
  filter(`Timesheet Date` != u) %>% 
  filter(`Timesheet Date` != v) %>% 
  filter(`Timesheet Date` != w) %>% 
  filter(`Timesheet Date` != x) %>% 
  filter(!(day %in% weekends)) %>% 
  select(!c(day))




my_vecccccc<-unique(absent_all3$TBD)



my_vec2<- my_vec[!my_vec %in% c("CAPE",NA, "Administration", "Financial Services","BMS","Personnel")]

my_vec2<-my_vecccccc

my_vec2<-my_vec2[!my_vec2 %in% c(NA)]

write.csv(my_vec2,'myvec2.csv' )


### working on one department(TBD)

### client services

all_stats<-NULL


  
  
  
  
  name11<-'VMTH'
  
  current_month_start_date<-as.Date("2022-04-04")
  
  current_month_end_date<-as.Date("2022-04-29")
  
  absent_client_services<-absent_all3
  
  
  
  workdays<-as.data.frame(unique(absent_all3$`Timesheet Date`))
  
  colnames(workdays)<- 'date'
  
  
  
  
  jjj<-unique(absent_client_services$`Timesheet Date`)
  
  
  cs111<-absent_client_services %>% 
    group_by(`Timesheet Date`) %>% 
    summarise(n=n(), dur=sum(hours))
  
  cs111$month<-month(cs111$`Timesheet Date`)
  
  
  current_month<-4
  ###current_month<-month(Sys.Date())-1
  
  cs_this_month<-cs111 %>% 
    filter(`Timesheet Date` >= current_month_start_date) %>% 
    filter(`Timesheet Date` <= current_month_end_date)
  
  cs_this_month$day<-weekdays(cs_this_month$`Timesheet Date`)
  
  cs_this_month_calc<-cs_this_month
  
  names(cs_this_month_calc)[1]<-'date'
  
  workdays_now<-workdays %>% 
    filter(date >= current_month_start_date) %>% 
    filter(date <= current_month_end_date)
  
  cs_this_month_calc2<-left_join(workdays_now, cs_this_month_calc)
  
  cs_this_month_calc2[is.na(cs_this_month_calc2)] <- 0
  
  cs_this_month_calc2$day<-weekdays(cs_this_month_calc2$date)
  
  cs_avg_ab_per_day<-cs_this_month_calc2 %>% 
    group_by(day) %>% 
    summarise(Absences = mean(n)) 
  
  colnames(cs_avg_ab_per_day)[1]<-'Day'
  
  target<-c('Monday','Tuesday','Wednesday','Thursday', 'Friday')
  
  cs_avg_ab_per_day2<-cs_avg_ab_per_day[match(target, cs_avg_ab_per_day$Day),]
  
  cs_avg_ab_per_day2$Absences<-round(cs_avg_ab_per_day2$Absences, 1)
  
  write.csv(cs_avg_ab_per_day2, paste("ab_per_day_", name11, ".csv", sep=""))
  
  absent_client_services$month<-month(absent_client_services$`Timesheet Date`)
  
  
  cs_this_month_type<-absent_client_services %>% 
    filter(`Timesheet Date` >= current_month_start_date) %>% 
    filter(`Timesheet Date` <= current_month_end_date)
  
  cs_this_month_type2 <- cs_this_month_type %>%
    mutate(
      type2 = case_when(
        grepl('FMLA', type) ~ "FMLA",
        grepl('Vacation', type) ~ "VACATION",
        grepl('LWP', type) ~ "LEAVE",
        grepl('Emergency', type) ~ "EMERGENCY",
        grepl('Sick', type) ~ "SICK",
        TRUE                      ~ 'OTHER'
      )
    )
  
  cs_this_month_type2$day<-weekdays(cs_this_month_type2$`Timesheet Date`)
  
  cs12<-cs_this_month_type2 %>% 
    group_by(type2) %>% 
    summarise(n=n(), dur=sum(hours))
  
  cs14<-cs_this_month_type2 %>% 
    group_by(type2, day) %>% 
    summarise(n=n(), dur=sum(hours))
  
  
  heat_join<-read_excel(here("heat join.xlsx"), sheet = 1)
  
  
  
  cs14_mon<-cs14 %>% 
    filter(day=='Monday')
  
  cs14_mon_2<-left_join(heat_join, cs14_mon)
  
  cs14_mon_2[is.na(cs14_mon_2$day),3] <- 'Monday'
  cs14_mon_2[is.na(cs14_mon_2$n),4] <- 0
  cs14_mon_2[is.na(cs14_mon_2$dur),5] <- 0
  
  cs14_tue<-cs14 %>% 
    filter(day=='Tuesday')
  
  cs14_tue_2<-left_join(heat_join, cs14_tue)
  
  cs14_tue_2[is.na(cs14_tue_2$day),3] <- 'Tuesday'
  cs14_tue_2[is.na(cs14_tue_2$n),4] <- 0
  cs14_tue_2[is.na(cs14_tue_2$dur),5] <- 0
  
  cs14_wed<-cs14 %>% 
    filter(day=='Wednesday')
  
  cs14_wed_2<-left_join(heat_join, cs14_wed)
  
  cs14_wed_2[is.na(cs14_wed_2$day),3] <- 'Wednesday'
  cs14_wed_2[is.na(cs14_wed_2$n),4] <- 0
  cs14_wed_2[is.na(cs14_wed_2$dur),5] <- 0
  
  cs14_thu<-cs14 %>% 
    filter(day=='Thursday')
  
  cs14_thu_2<-left_join(heat_join, cs14_thu)
  
  cs14_thu_2[is.na(cs14_thu_2$day),3] <- 'Thursday'
  cs14_thu_2[is.na(cs14_thu_2$n),4] <- 0
  cs14_thu_2[is.na(cs14_thu_2$dur),5] <- 0
  
  cs14_fri<-cs14 %>% 
    filter(day=='Friday')
  
  cs14_fri_2<-left_join(heat_join, cs14_fri)
  
  cs14_fri_2[is.na(cs14_fri_2$day),3] <- 'Friday'
  cs14_fri_2[is.na(cs14_fri_2$n),4] <- 0
  cs14_fri_2[is.na(cs14_fri_2$dur),5] <- 0
  
  cs14_all<-rbind(cs14_mon_2,cs14_tue_2, cs14_wed_2,cs14_thu_2,cs14_fri_2)
  
  cs14_all2<-cs14_all %>% 
    select(c(3,1,4))
  
  colnames(cs14_all2)<-c('Day',	'Type',	'Value')
  
  
  
  
  write.csv(cs14_all2, paste("heat_csv_", name11, ".csv", sep=""))
  
  cs111$month<-month(cs111$`Timesheet Date`)
  
  current_month<-4
  
  ###current_month<-month(Sys.Date())-1
  
  cs_this_month<-cs111 %>% 
    filter(`Timesheet Date` >= current_month_start_date) %>% 
    filter(`Timesheet Date` <= current_month_end_date)
  
  cs_this_month2<-cs_this_month
  
  cs_this_month2$weeka<-difftime(strptime(cs_this_month2$`Timesheet Date`, format = "%Y-%m-%d"),
                                 strptime('2022-05-01', format = "%Y-%m-%d"),units="weeks")
  
  cs_this_month2$weeka<-as.character(cs_this_month2$weeka)
  
  cs_this_month2$weekb<-sub("\\..*", "", cs_this_month2$weeka)
  
  cs_this_month2$week<-as.numeric(cs_this_month2$weekb)+1
  
  cs_this_month2$day<-weekdays(cs_this_month2$`Timesheet Date`)
  
  cs_this_month3<-cs_this_month2 %>% 
    select(c(8,7,2))
  
  
  
  
  day_scratch<- c('Monday')
  week_scratch1 <- c(1)
  week_scratch2 <- c(2)
  week_scratch3 <- c(3)
  week_scratch4 <- c(4)
  n_scratch <- c(0)
  
  
  scratch1 <- data.frame(day_scratch, week_scratch1, n_scratch)
  scratch2 <- data.frame(day_scratch, week_scratch2, n_scratch)
  scratch3 <- data.frame(day_scratch, week_scratch3, n_scratch)
  scratch4 <- data.frame(day_scratch, week_scratch4, n_scratch)
  
  names(scratch1)<-names(cs_this_month3)
  names(scratch2)<-names(cs_this_month3)
  names(scratch3)<-names(cs_this_month3)
  names(scratch4)<-names(cs_this_month3)
  
  
  
  if(1 %in% cs_this_month3$week){
    cs_this_month3b<-cs_this_month3
  } else {
    cs_this_month3b<-rbind(cs_this_month3, scratch1)
  }
  
  if(2 %in% cs_this_month3$week){
    cs_this_month3c<-cs_this_month3b
  } else {
    cs_this_month3c<-rbind(cs_this_month3b, scratch2)
  }
  
  if(3 %in% cs_this_month3$week){
    cs_this_month3d<-cs_this_month3c
  } else {
    cs_this_month3d<-rbind(cs_this_month3c, scratch3)
  }
  
  if(4 %in% cs_this_month3$week){
    cs_this_month3e<-cs_this_month3d
  } else {
    cs_this_month3e<-rbind(cs_this_month3d, scratch4)
  }
  
  
  
  
  
  
  
  
  day_scratch_big<- c('Monday','Tuesday','Wednesday','Thursday','Friday')
  week_scratch_big <- c(20,20,20,20,20)
  n_scratch_big <- c(0,0,0,0,0)
  
  scratch_big <- data.frame(day_scratch_big, week_scratch_big, n_scratch_big)
  
  names(scratch_big)<-names(cs_this_month3)
  
  cs_this_month3f<-rbind(cs_this_month3e,scratch_big)
  
  
  cs_this_month4 <- cs_this_month3f %>%
    pivot_wider(names_from = day, values_from = n)
  
  cs_this_month4<- cs_this_month4[order( cs_this_month4$week),]
  
  cs_this_month4<-cs_this_month4[-5,]
  
  cs_this_month4$week2<-current_month_start_date
  
  cs_this_month4$week2[2]<-current_month_start_date+days(7)
  cs_this_month4$week2[3]<-current_month_start_date+days(14)
  cs_this_month4$week2[4]<-current_month_start_date+days(21)
  
  cs_this_month5<-cs_this_month4 %>% 
    select(7,"Monday","Tuesday", "Wednesday","Thursday","Friday")
  
  cs_this_month5[is.na(cs_this_month5)] <- 0
  
  colnames(cs_this_month5)[1]<-'week'
  
  write.csv(cs_this_month5, paste("big_graph_", name11, ".csv", sep=""))
  
  
  
  cs_this_month6<- cs_this_month5 %>%
    pivot_longer(!week, names_to = "day", values_to = "count")
  
  
  cs_this_month6_a<-cs_this_month6 %>% 
    mutate(
      date2 = case_when(
        day == 'Monday'  ~ week,
        day == 'Tuesday'  ~ week + 1,
        day == 'Wednesday'  ~ week + 2,
        day == 'Thursday'  ~ week + 3,
        day == 'Friday'  ~ week + 4,
        TRUE                      ~ week
      )
    )
  
  cs_this_month6_a$date2<-as.Date(cs_this_month6_a$date2)
  
  cs_this_month6_b<-cs_this_month6_a %>% 
    filter(date2 != a) %>% 
    filter(date2 != b) %>% 
    filter(date2 != c) %>% 
    filter(date2 != d) %>% 
    filter(date2 != e) %>% 
    filter(date2 != f) %>% 
    filter(date2 != g) %>% 
    filter(date2 != h) %>% 
    filter(date2 != ii) %>% 
    filter(date2 != j) %>%
    filter(date2 != k) %>% 
    filter(date2 != l) %>% 
    filter(date2 != m) %>% 
    filter(date2 != n) %>% 
    filter(date2 != o) %>% 
    filter(date2 != p) %>% 
    filter(date2 != q) %>%
    filter(date2 != r) %>% 
    filter(date2 != s) %>% 
    filter(date2 != t) %>% 
    filter(date2 != v) %>% 
    filter(date2 != w) %>% 
    filter(date2 != x) %>% 
    filter(date2 != u) 
  
  cs_this_month7 <- cs_this_month6_b %>% 
    group_by(week) %>% 
    summarise(Absences = mean(count))
  
  colnames(cs_this_month7)<-c('Day', 'Absences')
  
  cs_this_month7$Absences<-round(cs_this_month7$Absences,1)
  
  write.csv(cs_this_month7, paste("ab_by_week_", name11, ".csv", sep=""))
  
  
  cs_this_month_type3<-cs_this_month_type2 %>% 
    group_by(type2) %>% 
    summarise(n=n())
  
  j<-sum(cs_this_month_type3$n)
  
  cs_this_month_type3$percent<-100*(cs_this_month_type3$n/j)
  
  cs_this_month_type4<-cs_this_month_type3 %>% 
    select(c(1,3))
  
  cs_this_month_type5 <- cs_this_month_type4[order(-cs_this_month_type4$percent),]
  
  colnames(cs_this_month_type5)<-c('Day', 'Absences')
  
  cs_this_month_type5$Absences<-round(cs_this_month_type5$Absences,0)
  
  write.csv(cs_this_month_type5, paste("ab_by_type_", name11, ".csv", sep=""))
  
  
  pep3$new_department<-toupper(pep3$new_department)
  
  count_cs<-pep3
  
  
  
  total_worked<-sum(count_cs$`Sum of FTE` *8 * nrow(workdays_now))
  
  total_absent<-sum(cs_this_month$dur)
  
  total_absent_p<-sum(cs_this_month$n)
  
  
  
  absent_rate<-paste(round(total_absent/total_worked*100, 0), "%", sep="")
  
  absent_rate2<-round(total_absent/total_worked, 2)
  
  
  cs_table <- cs_this_month[order(-cs_this_month$n, -cs_this_month$dur),]
  
  cs_table2<-cs_table[1:5,]
  
  cs_table3<-cs_table2 %>% 
    select(c(1,2,3))
  
  max_absent<-cs_table3[1,2]
  
  
  colnames(cs_table3)<-c('Day', 'Absences', 'Absent Hours')
  
  
  write.csv(cs_table3, paste("table1_", name11, ".csv", sep=""))
  
  
  
  num_of_days<-nrow(workdays_now)
  
  avg_absent<-round(total_absent/num_of_days,2)
  
  avg_absent_p<-round(total_absent_p/num_of_days,2)
  
  stats<-cbind(total_absent_p, total_absent, avg_absent_p, avg_absent, absent_rate, absent_rate2)
  
  stats2<-as.data.frame(stats)
  stats2$name<-'VMTH'
  
  stats3<-stats2 %>% 
    select(7,1,2,3,4,5,6)
  
  names(stats3)<-c('Department', 'Total Absent People', 'Total Absent Hours', 'Average Absent People', 'Average Absent Hours','Absent Rate', 'sorter')
  
  stats3$`Total Absent People`<-paste(stats3$`Total Absent People`, 'people')
  
  stats3$`Average Absent People`<-paste(stats3$`Average Absent People`, 'people')
  
  stats3$`Total Absent Hours`<-paste(stats3$`Total Absent Hours`, 'hours')
  
  stats3$`Average Absent Hours`<-paste(stats3$`Average Absent Hours`, 'hours')
  
  all_stats<-rbind(all_stats, stats3)
  
  write.csv(stats, paste("stats_", name11, ".csv", sep=""))
  
  write.csv(max_absent, paste("big_graph_", name11, "2.csv", sep=""))
  
  

