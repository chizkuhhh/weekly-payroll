# Weekly Payroll

Weekly Payroll is an R-based application that calculates weekly payroll for employees, considering varying day types, overtime, and night shift hours. It uses CSV files to manage daily rates, overtime pay, and computed payroll data.

## Features

- **Calculate weekly payroll**: Compute weekly salaries based on daily rates, work hours, overtime, and night shift hours.
- **Handle different day types**: Account for different pay rates based on weekdays, weekends, and holidays.
- **Overtime and night shift pay**: Calculate additional pay for overtime hours and night shifts.
- **Interactive payroll editing**: Edit and update payroll details interactively through the console.
- **CSV data storage**: Use CSV files to store and manage rates and payroll computations.

## Tech Stack

- **Programming Language**: R

## Project Files

- **`weekly_payroll.R`**: The main R script that performs payroll calculations and interacts with the user.
- **`rates.csv`**: CSV file storing daily pay rates for different day types.
- **`ot_pay.csv`**: CSV file storing overtime and night shift pay rates.
- **`computation.csv`**: CSV file storing daily payroll details, including rates, in/out times, and computed salaries.

## Project Setup

1. **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/weekly-payroll.git
    cd weekly-payroll
    ```
2. **Install necessary R packages**:
    - Ensure that the required R packages are installed by running:
    ```R
    install.packages(c("readr", "dplyr"))
    ```
3. **Run the R script**:
    - Open the `weekly_payroll.R` script in your preferred R environment (e.g., RStudio).
    - Execute the script to start the payroll computation process.

## How It Works

1. **Reset Configurations**:
    - The script begins by resetting all daily rates, in/out times, and day types to default values.

2. **Load CSV Files**:
    - The script reads data from `rates.csv`, `ot_pay.csv`, and `computation.csv` to retrieve pay rates and store computed details.

3. **Compute Payroll**:
    - The script processes employee work hours, applies the corresponding pay rates based on day types, calculates overtime and night shift pay, and updates the payroll details.

4. **Interactive Editing**:
    - Users can interactively edit daily rates, in/out times, and day types, and recalculate salaries.

5. **Output**:
    - The calculated weekly salary is displayed in the console and stored in `computation.csv`.

## Contact
For any inquiries, feel free to reach out to:
- Simone Franceska Emanuelle M. Capio - simone\_franceska\_capio@dlsu.edu.ph
