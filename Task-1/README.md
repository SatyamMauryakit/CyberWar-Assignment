# Task 1: Server Setup and SSH Configuration

This document describes how I set up an AWS EC2 Ubuntu server and configured **SSH key-based authentication** (passwordless login).

## Overview

- **Goal:** Provision an Ubuntu EC2 instance and connect securely via SSH without using a password
- **Method:** Generate an SSH key pair locally and add the public key to the server’s `authorized_keys`

---

## Prerequisites

- AWS account with permission to launch EC2 instances
- Local machine with terminal access (Linux/macOS/Windows)
- OpenSSH installed (`ssh`, `ssh-keygen`)

---

## Step 1: Create an SSH Key Pair (Local Machine)

Generate a key pair:

```bash
ssh-keygen
```

This creates two files in `~/.ssh/`:

- `id_ed25519` — **private key** (keep this secret)
- `id_ed25519.pub` — **public key** (safe to share)

View and copy the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

---

## Step 2: Launch an EC2 Instance and Configure SSH

1. Launch a new **Ubuntu** EC2 instance in AWS.
2. On the server, add your public key to the SSH authorized keys file:

```bash
mkdir -p ~/.ssh
nano ~/.ssh/authorized_keys
```

3. Paste the copied public key into `~/.ssh/authorized_keys`, save, then set secure permissions:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

> SSH may refuse to work if these permissions are too open.

---

## Step 3: Test the SSH Connection

From your local machine, connect to the instance (replace the hostname with your instance DNS/IP):

```bash
ssh ubuntu@ec2-13-235-18-50.ap-south-1.compute.amazonaws.com
```

If configured correctly, you will be logged in **without being asked for a password**.

---

## Notes

- AWS EC2 uses **public/private key pairs** for secure access.
- The **private key** stays on your local machine.
- The **public key** is stored on the server in `~/.ssh/authorized_keys`.
- Key-based authentication is more secure than password-based authentication.
