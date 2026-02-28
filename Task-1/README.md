Task 1: Server Setup and SSH Configuration

In this task, I set up an AWS EC2 Ubuntu server and connected it securely using SSH key authentication (without password).

Step 1: Create SSH Key Pair (On Local Machine)

First, I opened the terminal on my local system (Linux/Windows/Mac).

Then I generated an SSH key pair using this command:

ssh-keygen

After running this command, two files were created inside the .ssh folder:

id_ed25519 → Private Key

id_ed25519.pub → Public Key

To see the public key, I used:

cat ~/.ssh/id_ed25519.pub

Then I copied the public key.

Step 2: Launch EC2 Instance and Configure SSH

Next, I logged in to AWS and created a new Ubuntu EC2 instance.

For secure login, AWS uses key-based authentication.

After launching the instance:

I opened the .ssh/authorized_keys file inside the EC2 server.

I pasted my copied public key into this file.

Then I set the correct permissions for security:

chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

These permissions are important because SSH will not work if the permissions are incorrect.

Step 3: Test SSH Connection

Finally, I tested the connection from my local terminal using:

ssh ec2-13-235-18-50.ap-south-1.compute.amazonaws.com

After pressing Enter, I successfully logged in to the EC2 instance without entering a password.

This confirms that passwordless SSH login is working correctly.

Note

AWS provides secure access to EC2 instances using key pairs (public and private key).

The private key stays on the local machine.

The public key is stored on the server.

This method is more secure than using passwords.


