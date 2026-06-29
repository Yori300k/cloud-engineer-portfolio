# Cloud Engineer Portfolio

Hands-on projects documenting my path into Cloud Engineering / DevOps — built from scratch, just labs and real code.

## Projects

### 01 - Linux & Bash Basics: System Health Check Script
A Bash script that checks disk usage and memory, and raises a warning if disk usage exceeds a configurable threshold.

**What it demonstrates:**
- Comfort with the Linux/Unix command line
- Parsing command output (`df`, `awk`, `sed`) to extract usable data
- Conditional logic for threshold-based alerting — the same core concept behind tools like AWS CloudWatch Alarms
- Git version control with incremental, documented commits

**To run it:**
```bash
chmod +x 01-linux-bash-basics/health_check.sh
./01-linux-bash-basics/health_check.sh
```

**Next steps for this project:** add logging to file, schedule via cron, send alerts via email/Slack instead of just printing.
