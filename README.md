# 🚀 DevOps Infrastructure Automation Task

This project provides a fully automated, multi-architecture environment featuring **Jenkins**, **Zabbix**, and **HashiCorp Vault**. The entire stack is deployed using **Vagrant**, **Docker**, and **Ansible** with a focus on "Zero Manual Configuration."

---

## 🏗 Architecture Overview

The infrastructure is built on a **Debian 12** virtual machine that serves as a host for the following services:

* **Nginx Reverse Proxy**: Acts as a single entry point (Port 80), routing traffic to services based on domain names.
* **Jenkins (LTS)**: Automated CI/CD server with pre-installed Git plugins and an auto-created Admin user.
* **Zabbix 7.0**: Containerized monitoring solution with automated PostgreSQL database initialization.
* **HashiCorp Vault**: Secure secret management service.

---

## 📋 Prerequisites

Before you begin, ensure your system meets the following requirements:

### 1. Hardware & OS
* **Architecture**: Supported on both **ARM64** (Apple Silicon, Windows ARM) and **x86_64** (Intel/AMD).
* **RAM**: Minimum **8 GB** (4 GB is allocated to the VM).
* **Virtualization**: Must be enabled in BIOS/UEFI (VT-x or AMD-V).

### 2. Software Stack
* **Vagrant**: Version **2.3.0** or higher.
* **Hypervisor**: 
    * **macOS (ARM)**: VMware Desktop (Free for personal use).
    * **Windows (x64)**: Oracle VirtualBox 7.0+.
* **Vagrant Plugins** (Required for VMware users):
    `vagrant plugin install vagrant-vmware-desktop`

---

## ⚙️ 3. Automatic Network Configuration

To access services via domain names (e.g., `jenkins.local`) without manually editing system files or specifying ports, use the provided automation scripts. 

> [!IMPORTANT]
> These scripts automatically detect your architecture (ARM vs x64) and apply the correct IP mapping to your host's `hosts` file.

* **Windows**:
    1.  Right-click **`setup_hosts.bat`** and select **Run as Administrator**.
* **macOS / Linux**:
    1.  Open terminal in the project root.
    2.  Run: `chmod +x setup_hosts.sh && ./setup_hosts.sh`

---

## 🚀 4. Quick Start

1.  Clone this repository.
2.  Run the network setup script (see step 3).
3.  Deploy the infrastructure:
    ```bash
    # For Windows: Run terminal as Administrator
    vagrant up
    ```

---

## 🌐 Service Access

Once the deployment is complete, all services are accessible via the following local URLs:

| Service | URL | Credentials (Login/Pass) |
| :--- | :--- | :--- |
| **Jenkins** | [http://jenkins.local](http://jenkins.local) | `admin` / `admin` |
| **Zabbix** | [http://zabbix.local](http://zabbix.local) | `Admin` / `zabbix` |
| **Vault** | [http://vault.local:8200](http://vault.local:8200) | Root Token (`root`) |

---

## 🛠 Key Features & Automation
* **Hybrid Vagrantfile**: Intelligent logic to switch between VMware (ARM) and VirtualBox (x64) providers based on host hardware.
* **Jenkins "Ready-to-Job"**: Uses Groovy init scripts to bypass the Setup Wizard, create an admin, and auto-install Git plugins with all required dependencies.
* **Zabbix SQL Fix**: Automated SQL script execution via Ansible to ensure the Zabbix server correctly monitors its own host (Green ZBX status).
* **Nginx Proxying**: Centralized traffic management allows access to all tools on the default HTTP port 80.



---

---

## 📸 Screenshots & Proof of Concept

Below are the visual confirmations of the automated deployment and service health.

### 1. Zabbix Monitoring Dashboard
*Description: Main dashboard showing the green ZBX status and active monitoring of the host.*
![Zabbix Dashboard](images/zabbix_main.png)

---

### 2. Jenkins Automated Setup
*Description: Proof that the Setup Wizard was bypassed, the admin user was created, and Git plugins are active.*
![Jenkins Jobs](images/jenkins_setup.png)

---

### 3. HashiCorp Vault Status
*Description: Vault UI accessible via the reverse proxy on port 80/8200.*
![Vault UI](images/vault_status.png)

---

**Developed by Denys Nazarenko, 2026.**