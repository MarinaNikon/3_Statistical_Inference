#Assignment 3_Non Parametric tests I
#Marina Nikon

#BACKGROUND: 
#In a randomized control trial, 32 patients were divided into
#two groups: A and B. Group A received test drug whereas group B
#received placebo. The variable of interest was Numerical Pain 
#Rating Scale (NPRS) before treatment and after 3 days of treatment.
#(Higher number indicates more pain)

#QUESTIONS:
#1. Import NPRS DATA and name it as pain_nprs. Find median NPRS
#before and after treatment.
#2. Is post treatment NPRS score significantly less as compared
#to ‘before treatment’ NPRS score for Group A?
#3. Is post treatment NPRS score significantly less as compared
#to ‘before treatment’ NPRS score for Group B?
#4. Is the change in NPRS for group ‘A’ significantly different
#than group ‘B’? 5. Present change in NPRS for each group using box-whisker plot.


#Import NPRS DATA and name it as pain_nprs. 
pain_nprs<-read.csv(file.choose(), header = TRUE)
str(pain_nprs)
head(pain_nprs)
dim(pain_nprs)


#Find length NPRS before and after treatment.
length(pain_nprs$NPRS_before)
length(pain_nprs$NPRS_after)
#Interpretation: 32 for NPRS_before
# 32 for NPRS_after
#Both groups have the same number of patients, there is
# no missing data for NPRS before and after treatment


#Find median NPRS before and after treatment.
round(median(pain_nprs$NPRS_before), 2)
round(median(pain_nprs$NPRS_after), 2)
#Interpretation: 7 for NPRS_before
# 5 for NPRS_after
# The median pain score decreased from 7 to 5 after 
#treatment, it could be suggested that pain reduced  
#for the group in general


#Find mean NPRS before and after treatment.
round(mean(pain_nprs$NPRS_before), 2)
round(mean(pain_nprs$NPRS_after), 2)
#Interpretation: 6.97 for NPRS_before
# 5.03 for NPRS_after
# The mean pain score reduced after treatment,
#Could be assumed a decrease in pain



#Check for normality of the data.
#QQPlot to check the normality for NPRS_before and NPRS_after
qqnorm(pain_nprs$NPRS_before, main = "QQPlot (NPRS_before)", col="coral")
qqline(pain_nprs$NPRS_before, col="blue")
#Interpretation: The QQ Plot for the NPRS_before deviates from
# the theoretical line, indicating possible non-normality


qqnorm(pain_nprs$NPRS_after, main = "QQPlot (NPRS_after)", col="darkorchid")
qqline(pain_nprs$NPRS_after, col="blue")
#Interpretation: The QQ Plot for the NPRS_after deviates from
# the theoretical line, indicating possible non-normality


#Box-Whisker Plot for NPRS_before (overall)
boxplot(pain_nprs$NPRS_before, col = "lightyellow",
        main='Box-Whisker Plot for NPRS_before',
        xlab = "Groups", ylab = "NPRS_before")
#Interpretation: The box appears symmetric around the median,
#without significant variability in pain, no outliers


#Box-Whisker Plot for NPRS_after (overall)
boxplot(pain_nprs$NPRS_after, col = "green",
        main='Box-Whisker Plot for NPRS_after',
        xlab = "Groups", ylab = "NPRS_after")
#Interpretation: The median (around 5) is noticeably lower 
# than in Box Plot for NPRS_before (around 7), indicating  
# reduction in pain after treatment
#The missing upper whisker may indicate left skewness


#Shapiro-Wilk normality test for VAS_before
shapiro.test(pain_nprs$NPRS_before)
#Interpretation: p-value = 0.003973, less than 0.05, reject the 
#null hypothesis.  Distribution of VAS_before 
#can be assumed not normal

#Shapiro-Wilk normality test for VAS_after
shapiro.test(pain_nprs$NPRS_after)
#Interpretation: p-value = 0.0003072, less than 0.05, reject the 
#null hypothesis.  Distribution of VAS_after  
#can be assumed not normal


#Kolmogorov-Smirnof test to check  normality for VAS_before

#Install and use package 'nortest'
install.packages('nortest')
# Load the library
library(nortest)

#Kolmogorov-Smirnof test to check  normality for VAS_before
lillie.test(pain_nprs$NPRS_before)
#Interpretation: p-value = 9.467e-05, less than 0.05, reject the 
#null hypothesis.  Distribution of VAS_before 
#can be assumed not normal


#Kolmogorov-Smirnof test to check  normality for VAS_after
lillie.test(pain_nprs$NPRS_after)
#Interpretation: p-value = 0.0007124, less than 0.05, reject the 
#null hypothesis.  Distribution of NPRS_after 
#can be assumed not normal



#2. Is post treatment NPRS score significantly less as compared 
#to ‘before treatment’ NPRS score for Group A?

#Filter data for Group A
group_A <- subset(pain_nprs, Group == "A")

#Wilcoxon test for Group A
wilcox.test(group_A$NPRS_before, group_A$NPRS_after,
            paired= TRUE, alternative="less")
#Interpretation: p-value = 0.9998, greater than 0.05, do not  
#reject the null hypothesis. Can assume that post treatment NPRS 
#score is significantly less as compared to ‘before treatment’
# NPRS score for Group A


#3. Is post treatment NPRS score significantly less as 
#compared to ‘before treatment’ NPRS score for Group B?

#Filter data for Group B
group_B <- subset(pain_nprs, Group == "B")

#Wilcoxon test for Group B
wilcox.test(group_B$NPRS_before, group_B$NPRS_after,
            paired= TRUE, alternative="less")
#Interpretation: p-value = 0.9998, greater than 0.05, do not  
#reject the null hypothesis. Can assume that post treatment NPRS 
#score is significantly less as compared to ‘before treatment’
# NPRS score for Group A


#4. Is the change in NPRS for group ‘A’ significantly 
#different than group ‘B’? 

#Create a new variable for the change in NPRS
pain_nprs$NPRS_change <- pain_nprs$NPRS_before - pain_nprs$NPRS_after


#Kruskal-Wallis test for the NPRS change by group
kruskal.test(NPRS_change~Group, data=pain_nprs)
#Interpretation: p-value = 0.5553, greater than 0.05, do not  
#reject the null hypothesis. Can assume that there is
#no significant change in NPRS for group A and B


  
#5. Present change in NPRS for each group using box-whisker plot.
boxplot(NPRS_change~Group, data=pain_nprs, col=c("green", "yellow"),
        main = "Change in NPRS by Groups A and B",
        xlab="Group",
        ylab = "NPRS_change") 
#Interpretation: The median for Group A appears to be higher than 
#for group B, indicating better pain reduction in Group A.
#Group A has two outliers suggesting that some patients have
#changes different from others.
#Group A shows greater positive changes compared to Group B,
#suggesting the test drug is more effective than the placebo.




