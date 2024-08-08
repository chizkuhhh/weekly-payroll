# Name: Simone Franceska Emanuelle M. Capio
# Language: R
# Paradigm(s): Functional Programming, Object-Oriented Programming

# set width to print more columns in console
options(width = 120)

# load libraries
library(dplyr)
library(readr)

# store main menu options in a vector
main_menu <- c("1 - Compute Payroll", "2 - Exit")

# store compute payroll days in a vector
days <- c("1 - Monday", "2 - Tuesday", "3 - Wednesday", "4 - Thursday",
          "5 - Friday", "6 - Saturday", "7 - Sunday", "8 - Exit")

# store days in a vector
days_check <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
                "Saturday", "Sunday")

# store times in a vector
times <- c("0000", "0100", "0200", "0300", "0400", "0500", "0600", "0700",
           "0800", "0900", "1000", "1100", "1200", "1300", "1400", "1500",
           "1600", "1700", "1800", "1900", "2000", "2100", "2200", "2300")

night_shift <- c("2200", "2300", "0000", "0100", "0200", "0300", "0400",
                 "0500", "0600")

# define data frame col types to suppress message when reading
rates_col_types <- cols(
  day = col_character(),
  rate = col_double()
)

ot_pay_col_types <- cols(
  day = col_character(),
  'non-night shift' = col_double(),
  'night shift' = col_double()
)

comp_col_types <- cols(
  day = col_character(),
  'daily rate' = col_double(),
  'in time' = col_character(),
  'out time' = col_character(),
  'day type' = col_character(),
  'hours overtime' = col_double(),
  'night shift overtime' = col_double(),
  'hours on nightshift' = col_double()
)

# function to read csv with col types
read_csv_with_types <- function(file, col_types) {
  return(read_csv(file, col_types = col_types))
}

# load data frames
rates <- read_csv_with_types('rates.csv', rates_col_types)
ot_pay <- read_csv_with_types('ot_pay.csv', ot_pay_col_types)
comp <- read_csv_with_types('computation.csv', comp_col_types)

# reset configs to default at start of program
reset_configs <- function(comp, days_check) {
  default <- data.frame(
    day = days_check,
    'daily rate' = c(500, 500, 500, 500, 500, 500, 500),
    'in time' = c('0900', '0900', '0900', '0900', '0900', '0900', '0900'),
    'out time' = c('0900', '0900', '0900', '0900', '0900', '0900', '0900'),
    'day type' = c('normal', 'normal', 'normal', 'normal', 'normal', 'rest day', 'rest day'),
    'hours overtime' = c(0, 0, 0, 0, 0, 0, 0),
    'night shift overtime' = c(0, 0, 0, 0, 0, 0, 0),
    'hours on nightshift' = c(0, 0, 0, 0, 0, 0, 0),
    check.names = FALSE
  )
  
  write_csv(default, 'computation.csv')
}

# count hours between in time and out time
count_hrs_bet <- function(in_time, out_time, times) {
  count <- -1
  
  # find in time index
  in_ind <-which(times == in_time)[1]
  
  start <- in_ind
  curr_time <- 1111
  
  while (curr_time != out_time) {
    # start from in time
    if (start > 24)
      start <- 1
    
    curr_time <- times[start]
    
    start <- start + 1
    count <- count + 1
  }
  
  return(count)
}

# count night shift hours
count_ns_hrs <- function(in_time, out_time, times, night_shift) {
  ns_count <- -1
  
  # find in time index from times
  in_ind <-which(times == in_time)[1]
  
  start <- in_ind
  curr_time <- 1111
  
  while (curr_time != out_time) {
    # start from in time
    if (start > 24)
      start <- 1
    
    curr_time <- times[start]
    
    start <- start + 1
    
    if (curr_time %in% night_shift)
      ns_count <- ns_count + 1
  }
  
  if (ns_count == -1)
    return(0)
  
  return(ns_count)
}

# function to display a menu & return selected option
display_menu <- function(menu, comp, times) {
  comp <- read_csv_with_types('computation.csv', comp_col_types)
  
  if (length(menu) == 2) {
    cat("\n\nMain Menu\n")
    for (option in menu) {
      cat(option, "\n")
    }
  } else if (length(menu) == 8) {
    total_salary <- 0
    cat("\n\nCompute Payroll\n")
    for (i in 1:7) {
      # calculate daily salary
      salary <- daily_salary(i, comp, times)
      comp <- read_csv_with_types('computation.csv', comp_col_types)
      
      # print menu options
      cat("\n", menu[i], "\n")
      # display daily rate, in time, out time, day type, hrs ot, hrs ot night, daily salary
      display_comp <- comp %>%
        filter(day == days_check[i]) %>%
        select(-day)
      print(display_comp)
      
      total_salary <- total_salary + salary
      
      cat("Salary: ", sprintf("%.2f", salary), "\n")
    }
    
    cat("\n", menu[8], "\n")
    cat("\nTotal Weekly Salary: ", sprintf("%.2f", total_salary), "\n")
  }
   
  choice <- as.integer(readline("Select an option: "))
  return(choice)
}

# loop for compute payroll menu
comp_payroll_menu <- function(comp, times) {
  comp <- read_csv_with_types('computation.csv', comp_col_types)
  
  choice <- 0
  while (choice != 8) {
    choice <- display_menu(days, comp, times)
    
    if (choice == 1) {
      comp <- edit_day(choice, comp)
      write_csv(comp, 'computation.csv')
    } else if (choice == 2) {
      comp <- edit_day(choice, comp)
      write_csv(comp, 'computation.csv')
    } else if (choice == 3) {
      comp <- edit_day(choice, comp)
      write_csv(comp, 'computation.csv')
    } else if (choice == 4) {
      comp <- edit_day(choice, comp)
      write_csv(comp, 'computation.csv')
    } else if (choice == 5) {
      comp <- edit_day(choice, comp)
      write_csv(comp, 'computation.csv')
    } else if (choice == 6) {
      comp <- edit_day(choice, comp)
      write_csv(comp, 'computation.csv')
    } else if (choice == 7) {
      comp <- edit_day(choice, comp)
      write_csv(comp, 'computation.csv')
    } else if (choice == 8) {
      cat("Returning to Main Menu...\n")
    } else {
      cat("Invalid choice. Please select a valid option.\n")
    }
  }
}

# display and edit selected day for payroll computation
edit_day <- function(day_num, comp) {
  choice <- 0 
  new_val <- 0
  cat("Edit details for: ", days_check[day_num], "\n")
  display_comp <- comp %>%
    filter(day == days_check[day_num]) %>%
    select(-day)
  print(display_comp)
  
  while(choice != 5) {
    cat("1 - Daily Rate\n")
    cat("2 - In Time\n")
    cat("3 - Out Time\n")
    cat("4 - Day Type\n")
    cat("5 - Exit\n")
    choice <- as.integer(readline("Select an option: "))
    
    if (choice == 1) {
      new_val <- as.integer(readline("Input NEW Daily Rate: "))
      # assign new_val to comp[day_num, daily rate col]
      comp[day_num, 'daily rate'] <- new_val
    } else if (choice == 2) {
      new_val <- readline("Input NEW In Time: ")
      # assign new_val to comp[day_num, out time col]
      if (!new_val %in% times)
        cat("Invalid input. Please try again.\n")
      else
        comp[day_num, 'in time'] <- new_val
    } else if (choice == 3) {
      new_val <- readline("Input NEW Out Time: ")
      # assign new_val to comp[day_num, out time col]
      if (!new_val %in% times)
        cat("Invalid input. Please try again.\n")
      else
        comp[day_num, 'out time'] <- new_val
    } else if (choice == 4) {
      new_val <- readline("Input NEW Day Type: ")
      # assign new_val to comp[day_num, day type col]
      comp[day_num, 'day type'] <- new_val
    } else if (choice == 5) {
      write_csv(comp, 'computation.csv')
      comp <- read_csv('computation.csv')
      cat("Returning to Compute Payroll Menu...")
    } else {
      cat("Invalid choice. Please select a valid option\n")
    }
  }
  
  return(comp)
}

# compute for the daily salary for a single day
daily_salary <- function(day_num, comp, times) {
  # rest days -> regular salary even if employee didn't work
  if (comp[day_num, 'in time'] == '0900' & comp[day_num, 'out time'] == '0900' && comp[day_num, 'day type'] == 'rest day') {
    # regular daily salary for that day
    return(comp$'daily rate'[day_num])
  }
  
  # non-rest day absent -> no pay
  if (comp[day_num, 'in time'] == '0900' & comp[day_num, 'out time'] == '0900') {
    # no daily salary for that day
    return(0)
  }
  
  # extract ot_rate and ns_ot_rate as numeric values
  ot_rate <- ot_pay %>%
    filter(day == as.character(comp[day_num, 'day type'])) %>%
    select('non-night shift') %>%
    as.numeric()
  
  ns_ot_rate <- ot_pay %>%
    filter(day == as.character(comp[day_num, 'day type'])) %>%
    select('night shift') %>%
    as.numeric()
  
  # extract salary_rate as a numeric value
  salary_rate <- rates %>%
    filter(day == as.character(comp[day_num, 'day type'])) %>%
    select('rate') %>%
    as.numeric()
  
  # hourly rate
  hourly_rate <- comp$'daily rate'[day_num] / 8
  ns_hours <- count_ns_hrs(comp$'in time'[day_num], comp$'out time'[day_num], times, night_shift)
  hours_worked <- count_hrs_bet(comp$'in time'[day_num], comp$'out time'[day_num], times)
  
  # calculate number of ot hours
  ot_hrs <- 0
  ns_ot_hrs <- 0
  if (hours_worked > 8) {
    ot_hrs <- hours_worked - 9
    if (ns_hours > 0 && hours_worked > 9) {
      ot_hrs <- ot_hrs - ns_hours
      ns_ot_hrs <- ns_hours
    }
  }
  
  # night shift differential
  ns_hours <- ns_hours - ns_ot_hrs
  nsd <- ns_hours * hourly_rate * 1.10
  
  # calculate ot_pay and ns_ot_pay as numeric values
  nonns_ot_pay <- 0
  ns_ot_pay <- 0
  
  if (ot_hrs > 0) {
    nonns_ot_pay <- ot_hrs * comp$'daily rate'[day_num] / 8 * ot_rate
  }
  
  if (ns_ot_hrs > 0) {
    ns_ot_pay <- ns_ot_hrs * comp$'daily rate'[day_num] / 8 * ns_ot_rate
  }
  
  # calculate regular_salary as a numeric value
  # hourly_rate * hrs worked * salary_rate
  regular_salary <- hourly_rate * (hours_worked - ot_hrs - ns_ot_hrs - 1) * salary_rate
  
  # update table values in comp
  comp[day_num, 'hours on nightshift'] <- ns_hours
  comp[day_num, 'hours overtime'] <- ot_hrs
  comp[day_num, 'night shift overtime'] <- ns_ot_hrs
  
  write_csv(comp, 'computation.csv')
  
  return(regular_salary + nsd + nonns_ot_pay + ns_ot_pay)
}

# main loop
choice <- 0
reset_configs(comp, days_check)
while(choice != 2) {
  choice <- display_menu(main_menu, comp, times)
  
  if (choice == 1) {
    comp_payroll_menu(comp, times)
  } else if (choice == 2) {
    cat("Exiting the program...\n")
  } else {
    cat("Invalid choice. Please select a valid option.\n")
  }
}
