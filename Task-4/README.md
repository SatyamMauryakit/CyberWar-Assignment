# Task 4 – Secure Monitoring Logs by Restricting Access

## Objective

Secure monitoring logs by:

- Creating a dedicated monitoring user
- Restricting access to the monitoring directory
- Allowing full access only to the monitoring user
- Preventing access to other users
- Verifying proper permission enforcement

This ensures better security and access management.

---

## Implementation Steps

### Step 1: Create dedicated user

```bash
sudo adduser monitoruser
```

Verify user creation:

```bash
getent passwd monitoruser
```

---

### Step 2: Create monitoring directory

```bash
sudo mkdir -p /opt/container-monitor/logs
```

This directory stores container monitoring logs.

---

### Step 3: Assign ownership to `monitoruser`

```bash
sudo chown -R monitoruser:monitoruser /opt/container-monitor
```

Verify ownership:

```bash
ls -ld /opt/container-monitor
```

Expected output should show owner/group as `monitoruser`:

```text
monitoruser monitoruser
```

---

### Step 4: Restrict permissions

Set strict permissions so only the owner can read/write/enter the directories:

```bash
sudo chmod -R 700 /opt/container-monitor
```

(Optional) If you want other users in the same group to have read-only access, use `750` instead of `700`.

---

## Verification Process

### Test 1: Access as `monitoruser`

```bash
sudo -iu monitoruser
cd /opt/container-monitor
ls -la
```

Expected result: access granted.

---

### Test 2: Access as another user

```bash
sudo -iu <otheruser>
cd /opt/container-monitor
```

Expected result: `Permission denied`.

---

## Final Outcome

- Dedicated user created: `monitoruser`
- Monitoring directory secured
- Ownership properly assigned
- Access restricted with `chmod 700`
- Verified permission enforcement

Only `monitoruser` can access the monitoring logs.