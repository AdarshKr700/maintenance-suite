#  Bash System Maintenance Suite

##  Description
Simple Bash system maintenance suite for Linux Operating system.
It offers features listed below:
- Back up important directories
- Keep your system updated and clean
- Monitor logs for errors or critical events  
All actions are logged for easy auditing and troubleshooting.

This project was developed as **Assignment 5 (LinuxOS & LSP)** for the Capstone Project.

---

## Project Structure

```
maintenance-suite/
├── scripts/
│   ├── backup.sh
│   ├── update_and_cleanup.sh
│   ├── log_monitor.sh
│   ├── suite_menu.sh
│   └── lib.sh
├── config/
│   └── maintenance.conf
├── logs/
├── var_backups/
├── tests/
    └── basic_tests.bats

```

---

##  Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/AdarshKr700/maintenance-suite
   cd maintenance-suite
   ```

2. **Make scripts executable**
   ```bash
   chmod +x scripts/*.sh
   ```

3. **Set your desired path and beahviour**
   Edit `config/maintenance.conf`:
   ```bash
   nano config/maintenance.conf
   ```
   Example configuration:
   ```bash
   BACKUP_SRC="/etc"
   BACKUP_DEST="/home/adarsh/backups"
   LOGFILE="/home/adarsh/maintenance-suite/logs/maintenance-suite.log"
   KEEP_DAYS=14
   RETENTION_DAYS=30
   ALERT_EMAIL="adarsh@example.com"
   ```

4. **Run the suite**
   ```bash
   ./scripts/suite_menu.sh
   ```

---

##  Main Menu Overview

When you run `suite_menu.sh`, you’ll see this interactive menu:

![image](https://ik.imagekit.io/1usyzu9ab/Menu__TAAkjwTr.png?updatedAt=1762589147641)

---

##  Backup Module (`backup.sh`)

###  Description
Creates compressed `.tar.gz` archives of specified system directories.  
Removes older backups according to the retention period set in configuration

###  Features
- Compresses directories (using `tar -czf`)
- Logs every backup action with timestamps
- Automatically cleans old backups

### Example usage
```bash
./scripts/backup.sh
```
OR

`From Suite menu`

###  Sample Run

![image](https://ik.imagekit.io/1usyzu9ab/Backup_Krf3SNqb8.png?updatedAt=1762589376696)

![](https://ik.imagekit.io/1usyzu9ab/backup_List_6ksdFLVb0.png)


---

##  Update & Cleanup Module (`update_and_cleanup.sh`)

### Description
Automatically updates system packages using the appropriate package manager .

###  Features
- Detects and uses your system’s package manager (apt,dnf,yum,pacman)
- Runs updates, upgrades, and cleanup commands
- Logs all actions with timestamps and error codes

### Sample Run
![](https://ik.imagekit.io/1usyzu9ab/update_cleanup_5bDl6hObf.png)
---

## Log Monitor Module (`log_monitor.sh`)

### Description
Scans system logs (e.g. `/var/log/syslog` or `/var/log/messages`) for errors, warnings, or failures.  
Optionally sends alerts via email if configured via mailx/mailutils.

### Features
- Searches logs for keywords: `ERROR`, `CRITICAL`, `FAIL`, `panic`
- Logs all findings with timestamps
- Sends alert emails if configured (`mailx` required)

### Sample Run

![](https://ik.imagekit.io/1usyzu9ab/log_monitor_Y9SsIsCSl.png)

---


##  Scheduling with Cron

Can be easily automated using **cron**

Edit cron jobs:
```bash
crontab -e
```
And setup your cron job.

---

##  Testing

Run all basic tests (if Bats is installed):
```bash
bats tests/basic_tests.bats
```

Sample Run
![](https://ik.imagekit.io/1usyzu9ab/Tests_eCDQv2GOQ.png)

---

## Logs 

All scripts write logs to:
```
logs/maintenance-suite.log
```

Each line includes:
```
YYYY-MM-DD HH:MM:SS [LEVEL] Message
```

Sample:

![](https://ik.imagekit.io/1usyzu9ab/logs_saNwdp1c0.png)


