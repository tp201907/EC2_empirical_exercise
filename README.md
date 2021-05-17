This repository contains the data for the EC2 empirical exercise.  EC2 candidates are encouraged to clone this repository to access the data.

The data come from the 2019 Zimbabwe MICS6 survey.  For more details, see https://mics.unicef.org/surveys.

The MICS survey in Zimbabwe interviewed a little over 11,000 households, with more than 6,000 mothers and caregivers of children under 5 interviewed.  The data in this repository comes from the Mother/Caregiver interview for children under 5.  

# How to use this repository

The data for the Children under 5 interview can be found in the 01_rawdata folder.  The data is available in csv format, and is titled, "Zimbabwe_children_under5_interview.csv".  Only children age 3 or 4 are included.

Do not submit answers by pushing commits to this repo, as your fellow candidates will be able to see your work.

# Codebook



    interview_date  "Date of Interview"
    child_age_years "Child age in years"
    child_birthday "Child date of birth"
    EC6 "Can (name) identify or name at least ten letters of the alphabet?" "Yes=1/No=2/DK=8"
    EC7 "Can (name) read at least four simple, popular words?" "Yes=1/No=2/DK=8"
    EC8 "Does (name) know the name and recognize the symbol of all numbers from 1 to 10?" "Yes=1/No=2/DK=8"
    EC9 "Can (name) pick up a small object with two fingers, like a stick or a rock from the ground?" "Yes=1/No=2/DK=8"
    EC10 "Is (name) sometimes too sick to play?" "Yes=1/No=2/DK=8"
    EC11 "Does (name) follow simple directions on how to do something correctly?" "Yes=1/No=2/DK=8"
    EC12 "When given something to do, is (name) able to do it independently?" "Yes=1/No=2/DK=8"
    EC13 "Does (name) get along well with other children?" "Yes=1/No=2/DK=8"
    EC14 "Does (name) kick, bite, or hit other children or adults?" "Yes=1/No=2/DK=8"
    EC15 "Does (name) get distracted easily?" "Yes=1/No=2/DK=8"

# What is the exercise?

1. Please clone this repository.

2. Create a script (R, Stata, Python, whatever) that does the following and save the tables and figures in an Word, HTML, Excel, or text document:
  
    a. Read in the csv file, "Zimbabwe_children_under5_interview.csv".  
  
    b. Recode the responses so that Yes=1, No=0, and DK=0.  
  
    c. Calculate a table of summary statistics showing the percent correct for each of EC6, EC7, EC8, EC9, EC10, EC11, EC12, EC13, EC14, EC15 by child age in years 
  
    d. Calculate an index, by taking the arithmetic average of the 10 items (EC6, EC7, EC8, EC9, EC10, EC11, EC12, EC13, EC14, EC15).  
  
    e. Calculate the Cronbach's Alpha of the index and report it in a table along with the number of observations.  
  
    f. Plot the conditional mean of the created index on the child's **age in months** at the time of the interview.  You will need to take the difference between the interview date and the birth date.
    
    g. Repeat these plots for sub-indices based on reading (EC6 & EC7), math (EC8), Physical (EC9 & EC10), and Socio-emotional (EC11, EC12, EC13, EC14, EC15).
  
    h. Print a table of OLS regression results regressing index on the child's **age in months** at the time of the interview.  These regression results should contain at least the estimated coefficient on age, the standard error, the R squared, and the number of observations.

3. Using a script, pull data from Zimbabwe on stunting (SH.STA.STNT.ME.ZS) for the most recent year from the World Bank.  Use of APIs (including software packages that use World Bank API) are encouraged.  Also, pull data on stunting (SH.STA.STNT.ME.ZS) for the Lower middle income country aggregate and Sub-Saharan Africa aggregate.  Create a table containing the prevalence of stunting in Zimbabwe, Lower middle income countries, and Sub-saharan Africa countries.

4. Add a brief discussion (Around 1 paragraph and no more than 2 paragraphs) on how Zimbabwe's prevalence of stunting compares to other Lower middle income countries, and Sub-Saharan Africa countries.  And also discuss the results on early childhood development from the 2019 Zimbabwe MICS6 survey in this context.

5. Export tables and figures from the script to Word, HTML, Excel, or text document.  You can choose the format, but this will be submitted along with the script.

