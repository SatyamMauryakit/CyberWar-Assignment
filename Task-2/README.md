# Task-2: Containerizing a Static Portfolio Website using Docker & Nginx

This task demonstrates how to containerize and serve a static portfolio website using **Docker** and **Nginx**.

---

## 1) Check Docker status

```bash
sudo systemctl status docker
docker ps
```

If Docker is not installed:

```bash
sudo apt-get update
sudo apt-get install docker.io -y
sudo usermod -aG docker $USER
newgrp docker
docker ps
```

---

## 2) Create a project directory

```bash
mkdir portfolio
cd portfolio
```

---

## 3) Create `index.html`

```bash
vim index.html
```

Add your static portfolio HTML content to this file.

---

## 4) Create `Dockerfile`

```bash
vim Dockerfile
```

**Dockerfile contents:**

```Dockerfile
FROM nginx:alpine

COPY index.html /usr/share/nginx/html/
```

---

## 5) Build the Docker image

```bash
docker build -t portfolio:latest .
```

Verify the image:

```bash
docker images
```

---

## 6) Run the Docker container

```bash
docker run -d -p 8000:80 --name portfolio-container portfolio:latest
```

### Port mapping explanation

- **8000** → EC2 server port
- **80** → container (Nginx) port

So traffic flows like this:

**EC2:8000 → Container:80**

---

## 7) Verify the container is running

```bash
docker ps
```

You should see something like:

```text
0.0.0.0:8000->80/tcp
```

---

## 8) Configure AWS Security Group inbound rules

Go to:

**EC2 → Security Groups → Inbound Rules**

Add rule:

| Type       | Port | Source    |
|------------|------|-----------|
| Custom TCP | 8000 | 0.0.0.0/0 |

Save changes.

---

## 9) Access the website

Open in your browser:

```text
http://<EC2-PUBLIC-IP>:8000/
```

Example:

```text
http://13.235.18.50:8000/
```

---

## Nginx default web root directory

```text
/usr/share/nginx/html
```

This is where Nginx serves static files from inside the container.
