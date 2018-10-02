# task: change every value in the "Minimum" column to eliminate 
# the commas inside the numbers and the quotes around the numbers.

# replaces one to two instances of commas within quotes
# requires brew install gnu-sed

echo -e "\ngsed -r 's/"\(\[\^\,\]\*\)\,\*\(\[\^\,\]\*\)\,\(\[\^\,\]\*\)"/\1\2\3/' tableofSNPs.csv > task.csv"
gsed -r 's/"([^,]*),*([^,]*),([^,]*)"/\1\2\3/' tableofSNPs.csv > task.csv



# check: make sure that every row has exactly 3 commas (because 4 columns).

# number of lines in tableofSNPs.csv

# echo -e "\nwc -l < tableofSNPs.csv"
# wc -l < tableofSNPs.csv # 3358 since last line does not have newline character

echo -e "\ngrep -c \"\" tableofSNPs.csv"
grep -c "" tableofSNPs.csv # 3359

# number of lines with exactly 3 commas

echo -e "\nsed -n 's/^[^,]*,[^,]*,[^,]*,[^,]*$/&/p' task.csv | wc -l"
sed -n 's/^[^,]*,[^,]*,[^,]*,[^,]*$/&/p' task.csv | wc -l | cut -f5 -d " " # 3359

# or

# number of lines with exactly 3 commas
# the first script branches out any line with 4 or more commas and
# then prints of what remains only those that match 10 commas.

# echo -e "\nsed -n -e 's/,//4;t' -e 's/,/&/3p' task.csv  | wc -l"
# sed -n -e 's/,//4;t' -e 's/,/&/3p' task.csv  | wc -l # 3359



# extra task: permute the nucleotides back and recover the original data 
# (under the assumption that all Ts to As and all As to Ts).

# first script replaces all instances of As to Xs,
# next script replaces all instances of Ts to As, and
# last script replaces all instances of Xs to Ts,

echo -e "\nsed -e 's/A/X/g' -e 's/T/A/g' -e 's/X/T/g' task.csv > extra_task.csv"
sed -e 's/A/X/g' -e 's/T/A/g' -e 's/X/T/g' task.csv > extra_task.csv



# check: permutation worked correctly on the data

# counts the number of non-matching lines from the files task.csv extra_task.csv 

echo -e "\ngrep -c -v -f task.csv extra_task.csv"
grep -c -v -f task.csv extra_task.csv # 2294

# first script removes all characters not As or not Ts
# next script removes blank lines, and
# last script counts the number of words

echo -e "\nsed -e 's/[^AT]//g' -e '/^$/d' task.csv | wc -w"
sed -e 's/[^AT]//g' -e '/^$/d' task.csv | wc -w | cut -f5 -d " " # 2294

echo -e "\nsed -e 's/[^AT]//g' -e '/^$/d' extra_task.csv | wc -w"
sed -e 's/[^AT]//g' -e '/^$/d' extra_task.csv | wc -w | cut -f5 -d " " # 2294

# or

# counts the number of lines that contain As or Ts

# echo -e "\ngrep -c \"[AT]\" task.csv"
# grep -c "[AT]" task.csv # 2294

# echo -e "\ngrep -c \"[AT]\" extra_task.csv"
# grep -c "[AT]" extra_task.csv # 2294

# more specifically

# first script removes all characters either not As or not Ts
# next script removes blank lines, and
# last script counts the number of words

# echo -e "\nsed -e 's/[^A]//g' -e '/^$/d' task.csv | wc -w"
# sed -e 's/[^A]//g' -e '/^$/d' task.csv | wc -w # 1148
# echo -e "\nsed -e 's/[^T]//g' -e '/^$/d' extra_task.csv | wc -w"
# sed -e 's/[^T]//g' -e '/^$/d' extra_task.csv | wc -w # 1148
# echo -e "\nsed -e 's/[^T]//g' -e '/^$/d' task.csv | wc -w"
# sed -e 's/[^T]//g' -e '/^$/d' task.csv | wc -w # 1146
# echo -e "\nsed -e 's/[^A]//g' -e '/^$/d' extra_task.csv | wc -w"
# sed -e 's/[^A]//g' -e '/^$/d' extra_task.csv | wc -w # 1146

# or

# counts the number of lines that contain either As or Ts in the files respectively

# echo -e "\ngrep -c \"A\" task.csv"
# grep -c "A" task.csv # 1148
# echo -e "\ngrep -c \"T\" extra_task.csv"
# grep -c "T" extra_task.csv # 1148
# echo -e "\ngrep -c \"T\" task.csv"
# grep -c "T" task.csv # 1146
# echo -e "\ngrep -c \"A\" extra_task.csv"
# grep -c "A" extra_task.csv # 1146

