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

## Key concepts this demonstrates
- Unix command line navigation and scripting
- Parsing command output (`df`, `awk`, `sed`) to extract usable data
- Conditional logic for threshold-based alerting — same concept behind CloudWatch Alarms
- Git version control with incremental, documented commits

## What I'd add next
- Write output to a timestamped log file
- Send a real alert via AWS SNS instead of just printing
- Schedule via cron to run automatically every 5 minutes
