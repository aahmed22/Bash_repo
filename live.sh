1 #!/bin/bash
  2
  3 printer_name=$1
  4 jobs_not_completed=$(lpstat -W not-completed -o "$printer_name" | wc -l)
  5
  6 function tracker() {
  7         # stores the latest job that went to hell!!!
  8         recent_job=$(lpstat -W not-completed -o "$printer_name" | tail -1 | awk '{print $8}')
  9
 10         current_time=$(date '+%s') # Current time in seconds
 11
 12         rj_seconds=$(echo $recent_job | awk '{print ($1 * 3600) + ($2 * 60) + $3}')
 13
 14         holder=$(echo "$current_time - $rj_seconds" | bc)
 15
 16         # IF the most recent job has been in the queue for five minutes.
 17         # JAMES RELEASE THE HOUNDS!!! NOOOOOOO!! EXCELLENT... lol!
 18         # In case your wondering five minutes (300 sec), three minutes (180 sec).
 19         # GAME
 20         if [ $holder -ge 300 ]; then
 21                 printf "\tCRITICAL:\n\tPRINTER:$printer_name HAS FALLEN! (Jobs in queue: $jobs_not_completed)"
 22                 echo -e "\n\n" # RIP! RIP!
 23                 exit 2
 24         elif [ $holder -eq 180 ]; then
 25                 printf "WARNING: Please be advised. $printer_name (Jobs in queue: $jobs_not_completed)"
 26                 echo -e "\n"
 27                 exit 1
 28         else
 29                 echo "Standard Alert" #WE'RE STILL ALIVE! FOR NOW! COUNTDOWN BEGINS IN 3,2,1...
 30                 echo -e "\n"
 31                 exit 0
 32         fi
 33 }
 34
 35
 36 function initiate() {
 37
 38         echo -e "\tBEGIN PHASE1:"
 39         echo -e "\tCHECKING STATUS FOR $printer_name\n"
 40         echo $status
 41
 42         if [ $jobs_not_completed -gt 1 ]; then
 43                 echo -e "\tPHASE2: RUN DIAGNOSTICS REPORT!\n"
 44                 tracker
 45         else
 46                 echo -e "\tPRINTER IS RUNNING SUCCESSFULLY!\n"
 47                 exit $exitstatus
 48         fi
 49 }
 50
 51
 52 if [ "$printer_name" != "Xerox_Phaser_4510N" ] && [ "$printer_name" != "Xerox_WorkCentre_6505DN" ]; then
 53         echo -e "\tNICE TRY. WRONG PRINTER NAME. ABORT!\n"
 54         exit 3
 55 else
 56         echo -e "\tINITIATING STANDBY PHASE\n"
 57         initiate
 58 fi