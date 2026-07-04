# Project 09 - Monitoring: CloudWatch, Alarms & SNS

## What I built
A complete production monitoring loop on AWS: CloudWatch watching an 
EC2 instance's CPU, an alarm that trips above 70%, and SNS delivering 
an email notification the moment it fires. Then I deliberately maxed 
the CPU to prove the entire chain works live.

## The concept
This is my Project 01 Bash script, at production scale:
- My script collected a number (disk %) → CloudWatch collects metrics 
  automatically
- My script compared it to a threshold (if > 80) → a CloudWatch alarm 
  is that same if-statement as a managed service
- My script printed a warning → SNS actually notifies humans

Division of labor: CloudWatch detects the problem, SNS tells people 
about it.

## What I did
- Created an SNS topic and subscribed my email (with confirmation)
- Launched a test EC2 instance
- Created a CloudWatch alarm: CPU average > 70% for 1 datapoint 
  within 1 minute → notify the SNS topic
- SSH'd in and pinned both CPU cores using `yes > /dev/null &` 
  (one per core)
- Verified with `top` and `ps aux` — both burners at 99.5% CPU
- Watched the alarm flip from OK to In alarm and received the 
  email notification

## The troubleshooting story (the best part)
The alarm didn't fire at first. The graph showed a flat line at zero 
while the instance CPU was verifiably pinned at 100%. I worked it by 
elimination:

1. Were the CPU burner processes actually running? Verified with 
   `ps aux` — yes, both at 99.5%, 18+ minutes of accumulated CPU time
2. Was the alarm watching the wrong instance? Compared instance IDs — 
   they matched
3. Was metric data even flowing? Checked the CPUUtilization metric 
   directly in CloudWatch Metrics — it showed the 100% spike clearly

So data was flowing and the instance was right — which forced a 
closer read of the alarm's configuration. Found it: the alarm was 
watching **InstanceEBSThroughputExceededCheck**, not CPUUtilization. 
During setup, the metric checkbox landed on the wrong row in the 
Per-Instance Metrics list. Every other setting was correct — the 
alarm was just aimed at the wrong number, and disk throughput was 
legitimately zero.

Fixed the metric selection, and with the CPU already breached, the 
alarm flipped red within a minute and the email landed.

**Lesson:** monitoring that's silently watching the wrong thing is 
worse than no monitoring — it gives false confidence. When an alarm 
doesn't behave, read every field of its configuration, not just the 
ones you remember setting.

## Cleanup
Killed the CPU burners (`kill %1 %2`), terminated the test instance. 
Alarm and SNS topic retained.
