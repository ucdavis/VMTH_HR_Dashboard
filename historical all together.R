











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



date_helper<-read_excel(here("date helper.xlsx"), sheet = 1)


date_helper$start[1]

ab1<-read_excel(here("absent jan 2020.xlsx"), sheet = 1)
ab2<-read_excel(here("absent feb 2020.xlsx"), sheet = 1)
ab3<-read_excel(here("absent mar 2020.xlsx"), sheet = 1)
ab4<-read_excel(here("absent apr 2020.xlsx"), sheet = 1)
ab5<-read_excel(here("absent may 2020.xlsx"), sheet = 1)
ab6<-read_excel(here("absent jun 2020.xlsx"), sheet = 1)
ab7<-read_excel(here("absent jul 2020.xlsx"), sheet = 1)
ab8<-read_excel(here("absent aug 2020.xlsx"), sheet = 1)
ab9<-read_excel(here("absent sep 2020.xlsx"), sheet = 1)
ab10<-read_excel(here("absent oct 2020.xlsx"), sheet = 1)
ab11<-read_excel(here("absent nov 2020.xlsx"), sheet = 1)
ab12<-read_excel(here("absent dec 2020.xlsx"), sheet = 1)



ab13<-read_excel(here("absent jan 2021.xlsx"), sheet = 1)
ab14<-read_excel(here("absent feb 2021.xlsx"), sheet = 1)
ab15<-read_excel(here("absent mar 2021.xlsx"), sheet = 1)
ab16<-read_excel(here("absent apr 2021.xlsx"), sheet = 1)
ab17<-read_excel(here("absent may 2021.xlsx"), sheet = 1)
ab18<-read_excel(here("absent jun 2021.xlsx"), sheet = 1)
ab19<-read_excel(here("absent jul 2021.xlsx"), sheet = 1)
ab20<-read_excel(here("absent aug 2021.xlsx"), sheet = 1)
ab21<-read_excel(here("absent sep 2021.xlsx"), sheet = 1)
ab22<-read_excel(here("absent oct 2021.xlsx"), sheet = 1)
ab23<-read_excel(here("absent nov 2021.xlsx"), sheet = 1)
ab24<-read_excel(here("absent dec 2021.xlsx"), sheet = 1)

ab25<-read_excel(here("absent jan 2022.xlsx"), sheet = 1)
ab26<-read_excel(here("absent feb 2022.xlsx"), sheet = 1)
ab27<-read_excel(here("absent mar 2022.xlsx"), sheet = 1)
ab28<-read_excel(here("absent apr 2022.xlsx"), sheet = 1)

names(ab13)<-names(ab1)
names(ab14)<-names(ab1)
names(ab15)<-names(ab1)
names(ab16)<-names(ab1)
names(ab17)<-names(ab1)
names(ab18)<-names(ab1)
names(ab19)<-names(ab1)
names(ab20)<-names(ab1)
names(ab21)<-names(ab1)
names(ab22)<-names(ab1)
names(ab23)<-names(ab1)
names(ab24)<-names(ab1)


names(ab25)<-names(ab1)
names(ab26)<-names(ab1)
names(ab27)<-names(ab1)
names(ab28)<-names(ab1)


ab<-rbind(ab1,ab2,ab3,ab4,ab5,ab6,ab7,ab8,ab9,ab10,ab11,ab12,ab13,ab14,
          ab15,ab16,ab17,ab18,ab19,ab20,ab21,ab22,ab23,ab24,ab25,ab26,ab27,ab28)

###ab<-ab1

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



g20<-as.Date("2020/01/01")
h20<-as.Date("2020/01/20")
ii20<-as.Date("2020/02/17")
j20<-as.Date("2020/03/27")
k20<-as.Date("2020/05/25")
m20<-as.Date("2020/07/03")
n20<-as.Date("2020/09/07")


holidays<-as.data.frame(rbind(g20,h20,ii20,j20,k20,m20,n20,a,b,c,d,e,f,g,h,ii,j,k,l,m,n,o,p,q,r,s,t,u,w,x))




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
  filter(`Timesheet Date` != g20) %>% 
  filter(`Timesheet Date` != h20) %>% 
  filter(`Timesheet Date` !=ii20) %>% 
  filter(`Timesheet Date` != j20) %>% 
  filter(`Timesheet Date` != k20) %>% 
  filter(`Timesheet Date` != m20) %>% 
  filter(`Timesheet Date` != n20) %>% 
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




### working on one department(TBD)

### client services

all_stats<-NULL

all_stuff_2<-NULL

for (p in 1:nrow(date_helper)){

for(i in my_vec2) {
  
  
  
  
  name11<-str_remove(i, "/")
  
  current_month_start_date<-as.Date(date_helper$start[p])
  
  current_month_end_date<-as.Date(date_helper$end[p])
  
  absent_client_services<-absent_all3 %>% 
    dplyr::filter(TBD == i)
  
  
  
  workdays<-as.data.frame(unique(absent_all3$`Timesheet Date`))
  
  colnames(workdays)<- 'date'
  
  
  
  
  jjj<-unique(absent_client_services$`Timesheet Date`)
  
  
  cs111<-absent_client_services %>% 
    group_by(`Timesheet Date`) %>% 
    summarise(n=n(), dur=sum(hours))
  
  cs111$month<-month(cs111$`Timesheet Date`)
  
  current_month<-month(Sys.Date())-1
  
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
  
  
  
  absent_client_services$month<-month(absent_client_services$`Timesheet Date`)
  
  
  cs_this_month_type<-absent_client_services %>% 
    filter(month == current_month)
  
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
  
  
  
  
  
  
  cs111$month<-month(cs111$`Timesheet Date`)
  
  current_month<-month(Sys.Date())-1
  
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
    filter(date2 != g20) %>% 
    filter(date2 != h20) %>% 
    filter(date2 != ii20) %>% 
    filter(date2 != j20) %>% 
    filter(date2 != k20) %>% 
    filter(date2 != m20) %>% 
    filter(date2 != n20) %>% 
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
  
  
  
  pep3$new_department<-toupper(pep3$new_department)
  
  count_cs<-pep3 %>% 
    filter(new_department == i)
  
  
  
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
  
  
 
  
  
  
  num_of_days<-nrow(workdays_now)
  
  avg_absent<-round(total_absent/num_of_days,2)
  
  avg_absent_p<-round(total_absent_p/num_of_days,2)
  
  stats<-cbind(total_absent_p, total_absent, avg_absent_p, avg_absent, absent_rate, absent_rate2,total_worked)
  
  stats2<-as.data.frame(stats)
  stats2$name<-i
  
  stats3<-stats2 %>% 
    select(8,1,2,3,4,5,6,7)
  
  date_now<-date_helper[p,1]
  
  stats4<-cbind(stats3,date_now)
  
  names(stats4)<-c('Department', 'Total_Absent_People', 'Total_Absent_Hours', 'Average_Absent_People', 'Average_Absent_Hours','Absent_Rate', 'sorter','total_worked','month')

  
  all_stats<-rbind(all_stats, stats4)
  
 
  
  
}

str(all_stats)


all_stats2<-all_stats[order(-as.numeric(all_stats$sorter)),]

all_stats3<-all_stats2 %>% 
  select(1,2,3,4,5,6,8,9)

a_match<-read_excel(here("matching for a tag.xlsx"), sheet = 1)

all_stats4<-inner_join(all_stats3, a_match)

all_stats5<-all_stats4 %>% 
  select(1,2,3,4,5,6,7,8)


all_stats5$Total_Absent_Hours<-as.numeric(all_stats5$Total_Absent_Hours)
all_stats5$total_worked<-as.numeric(all_stats5$total_worked)

all_absent_rate<-sum(all_stats5$Total_Absent_Hours)/sum(all_stats5$total_worked)

all_stuff<-cbind(all_absent_rate, p)

all_stuff_2<-rbind(all_stuff_2, all_stuff)

}


write.csv(all_stats5, paste("all_stats_historical_all_together" ,"2.csv", sep=""),row.names=FALSE)

all_stuff_3<-as.data.frame(all_stuff_2)

all_stuff_3$ab_rate<-round(all_stuff_3$all_absent_rate*100,2)

write.csv(all_stuff_3, 'all_stuff3.csv')


dat<-all_stats5

dat$n<-round(dat$Total_Absent_Hours/dat$total_worked,2)

dat$month1<-month(dat$month)

dat$year1<-year(dat$month)

vet<-all_stuff_3

vet$Department<-'VMTH'

vet$n<-round(vet$all_absent_rate,2)

months_using<-unique(dat$month)

months_using2<-sort(months_using)

vet$month<-months_using2

vet2<-vet %>% 
  select(c(Department,n,month))

dat2<-dat %>% 
  select(1,9,8)

dat22<-dat2[order(dat2$Department, dat2$month),]

dat23<-rbind(vet2,dat22)

dat23$n2<-paste(dat23$n*100,'%', sep="")

names(dat23)<-c('name','n','year','n2')



dat_hey<-dat %>% 
  select(1,6,8)

write.csv(dat23, 'dat23.csv')

dat3<-dat_hey %>% 
  pivot_wider(names_from = month, values_from = Absent_Rate)


dat4<-dat3 %>% 
  select(Department, sort(names(.)))

dat5<-dat4[order(dat4$Department),]

write.csv(dat5, paste("monthly" ,"table.csv", sep="_"),row.names=FALSE)
