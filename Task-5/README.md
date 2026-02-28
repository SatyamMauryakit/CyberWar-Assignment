# Task 5 – Firewall Configuration Using UFW

##  Objective

To configure a secure firewall on the Ubuntu server using UFW (Uncomplicated Firewall) by:

- Allowing SSH access only from a specific IP address
- Allowing HTTP traffic (port 80)
- Allowing application traffic on port 8000
- Verifying firewall rules

---

##  Concept Explanation

A firewall controls incoming and outgoing network traffic.

In this task:
- SSH access is restricted to a specific public IP address for security.
- HTTP (port 80) is allowed for web traffic.
- Port 8000 is allowed for the Docker web application.
- All other unauthorized traffic is blocked.

This improves server security and prevents unauthorized access.

---

#  Implementation Steps

---

## ✅ Step 1: Update Package List

```bash
sudo apt-get update
```

---

## ✅ Step 2: Install UFW

```bash
sudo apt install ufw -y
```

---

##  Step 3: Get Public IP Address

To allow SSH only from the current client machine, the public IP was identified using:

```bash
curl ifconfig.me
```

Example Output:

```
205.254.166.118 
```

---

## ✅ Step 4: Allow SSH Only from Specific IP

```bash
sudo ufw allow from 205.254.166.118 to any port 22
```

This ensures:
- Only the specified IP can access SSH.
- Other IP addresses are blocked from SSH access.

---

## ✅ Step 5: Allow HTTP Traffic (Port 80)

```bash
sudo ufw allow 80
```

Allows web traffic to the server.

---

## ✅ Step 6: Allow Application Port (8000)

```bash
sudo ufw allow 8000
```

Allows access to the Docker-based web application running on port 8000.

---

## ✅ Step 7: Enable UFW

```bash
sudo ufw enable
```

---

## ✅ Step 8: Verify Firewall Rules

```bash
sudo ufw status verbose
```

Expected Output Should Show:

- Port 22 allowed only from specific IP
- Port 80 allowed
- Port 8000 allowed
- Firewall status: active

---

#  Final Outcome

- UFW successfully installed and configured
- SSH restricted to specific IP address
- Web and application ports allowed
- Firewall status verified

Task 5 completed successfully.

