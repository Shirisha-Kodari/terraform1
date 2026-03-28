# s3 life cycle policy :
- Lifecycle policy is used to automatically manage objects over time
- Move files to cheaper storage after some days
- Delete old files automatically
# Why we use it?
✅ Reduce storage cost
✅ Clean up old data
✅ Automate retention
🔹 Real-Time Scenario
 * Suppose:
- Logs stored in S3
* You want:
- After 30 days → move to cheaper storage
- After 90 days → delete
# Lifecycle Policy Types 
1.Transition Rules
2.Move objects to:

- Standard → IA
IA → Glacier
- Expiration Rules
Delete objects after X days

* Explanation
Prefix → apply only to logs/ folder
After 30 days → move to Standard-IA
After 60 days → move to Glacier
After 90 days → delete
# Important Storage Classes
- STANDARD → default
- STANDARD_IA → cheaper, less access
- GLACIER → archive
- DEEP_ARCHIVE → very cheap, slow access

In my project, we used S3 lifecycle policies to optimize storage costs. For example, application logs stored in S3 were automatically transitioned to Standard-IA after 30 days and moved to Glacier after 60 days. Finally, they were deleted after 90 days. We implemented this using Terraform lifecycle configuration.