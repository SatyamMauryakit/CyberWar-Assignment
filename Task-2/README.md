Task-1 Containerizing a Static Portfolio Website using Docker & Nginx

1️⃣ Check Docker Status
sudo systemctl status docker
docker ps
If Docker is not installed:
sudo apt-get update
sudo apt-get install docker.io -y
sudo usermod -aG docker $USER
newgrp docker
docker ps
2️⃣ Create Project Directory
mkdir portfolio
cd portfolio
3️⃣ Create index.html
vim index.html

Add your static portfolio HTML content.

4️⃣ Create Dockerfile
vim Dockerfile
Dockerfile Content:
FROM nginx:alpine

COPY index.html /usr/share/nginx/htm
5️⃣ Build Docker Image
docker build -t portfolio:latest .

Verify image:

docker images
6️⃣ Run Docker Container
docker run -d -p 8000:80 --name portfolio-container portfolio:latest
Port Explanation

8000 → EC2 Server Port

80 → Container (Nginx) Port

This maps:

EC2 Port 8000 → Container Port 80
7️⃣ Verify Container
docker ps

You should see:

0.0.0.0:8000->80/tcp
8️⃣ Configure AWS Security Group

Go to:

EC2 → Security Groups → Inbound Rules

Add Rule:

Type	Port	Source
Custom TCP	8000	0.0.0.0/0

Save changes.

9️⃣ Access Website

Open browser:

http://13.235.18.50:8000/

📂 Nginx Default Directory
/usr/share/nginx/html

This is where Nginx serves static files from inside the containe
