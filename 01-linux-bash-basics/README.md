## What this actually taught me

## Business problem this solves
When a disk quietly fills up at 2am, the app crashes, sales stop, and someone is getting dragged out of bed to fix it — and downtime runs about $5,600 a minute (Gartner). Catching it at 80% full costs nothing and nobody loses sleep.

The most important thing wasn't the script itself — it was learning that monitoring is just "check a number, decide if it's a problem, do something about it." That's all CloudWatch Alarms are. That's all PagerDuty is. Enterprise tools wrap that same logic in a nicer interface, but the concept is identical to this 20-line Bash script. Understanding the concept at this level means I'm not intimidated by the enterprise version — I already know what it's doing under the hood.

I also learned that `df | tail -1 | awk '{print $5}' | sed 's/%//'` isn't magic — it's just chaining small tools together, each one doing one thing. That "pipe output of one command into the next" pattern shows up constantly in DevOps work, whether you're parsing logs, extracting values from JSON, or filtering AWS CLI output## What this actually taught me

The most important thing wasn't the script itself — it was learning that monitoring is just "check a number, decide if it's a problem, do something about it." That's all CloudW$

$ne command into the next" pattern shows up constantly in DevOps work, whether you're parsing logs, extracting values from JSON, or filtering AWS CLI output.# Project 01 - Linu$
# Project 01 - Linux & Bash Scripting: System Health Check

## What I built
A Bash script that monitors disk usage, memory, and CPU processes on a Linux/Unix system. Evolved from a basic output script to one with threshold-based alerting logic.

## Why I built it
Every cloud engineer works in a Linux terminal daily. Before touching AWS or Terraform, I needed to prove I could navigate a Unix environment, write automation scripts, and think like an operator — not just a console-clicker. This script is the manual version of what tools like AWS CloudWatch do automatically in production.

## What it does
- Checks disk usage and compares against a configurable threshold (default 80%)
- Prints a WARNING if threshold is exceeded, OK if not
- Shows memory stats and top 5 CPU-consuming processes

## Real problems I ran into
- **Mac vs Linux differences:** `free -h` doesn't exist on Mac — had to use `vm_stat` instead. Small difference, but it taught me that cloud servers run Linux, not Mac, which is why EC2 instances matter
- **Git setup from scratch:** Configured Git for the first time, learned the difference between `git add`, `git commit`, and `git push`, and why commit messages matter for teammates reading history later
- **nano editor quirks:** Learned Ctrl+O → Enter → Ctrl+X the hard way

## What this actually taught me

The most important thing wasn't the script itself — it was learning that monitoring is just "check a number, decide if it's a problem, do something about it." That's all CloudW$

$ne command into the next" pattern shows up constantly in DevOps work, whether you're parsing logs, extracting values from JSON, or filtering AWS CLI output.# Project 01 - Linu$


## What I'd add next
- Write output to a timestamped log file
- Send a real alert via AWS SNS instead of just printing
- Schedule via cron to run automatically every 5 minutes
