# Task 4 – Secure Monitoring Logs by Restricting Access

##  Objective

To secure monitoring logs by:
- Creating a dedicated monitoring user
- Restricting access to monitoring directory
- Allowing full access only to the monitoring user
- Preventing access to other users
- Verifying proper permission enforcement
This ensures better security and access management.

---

#  Implementation Steps

---

##  Step 1: Create Dedicated User

```bash
sudo adduser monitoruser
```

Verify user creation:

```bash
cut -d: -f1 /etc/passwd | grep monitoruser
```

---

##  Step 2: Create Monitoring Directory

```bash
sudo mkdir -p /opt/container-monitor/logs
```

This directory stores container monitoring logs.

---

## ✅ Step 3: Assign Ownership to monitoruser

```bash
sudo chown -R monitoruser:monitoruser /opt/container-monitor
```

Verify ownership:

```bash
ls -ld /opt/container-monitor
```

Expected output should show:

```
monitoruser monitoruser
```

---

## ✅ Step 4: Restrict Permissions

```bash
sudo chmod -R 700 /opt/container-monitor
```
---

# Verification Process

---

## ✔ Test 1: Access as monitoruser

```bash
su monitoruser
cd /opt/container-monitor
ls
```

Result: ✅ Access granted

---

## ❌ Test 2: Access as another user

```bash
cd /opt/container-monitor
```

Result: ❌ Permission denied

This confirms access restriction is working properly.

---

# Final Outcome

- Dedicated user created: `monitoruser`
- Monitoring directory secured
- Ownership properly assigned
- Access restricted using chmod 700
- Verified security enforcement

Only the monitoring user can access the monitoring logs.

