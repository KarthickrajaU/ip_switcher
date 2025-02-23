# IPswitcher

## Automatic IP Changer (Time-Based)

**IPswitcher** is an automated tool for dynamically changing your IP address at preset intervals. This helps maintain anonymity and bypass restrictions while performing tasks like reconnaissance and exploitation in web application penetration testing.

By making your requests appear from dynamic IPs, **IPswitcher** ensures that website bot detectors, IPS (Intrusion Prevention Systems), and IDS (Intrusion Detection Systems) have a harder time blocking you. You can set your preferred time interval (default: 30 minutes) to switch IPs periodically.

### ⚠️ Disclaimer
**This tool is strictly for educational and research purposes only.** The developers are not responsible for any misuse.

---

## 📷 Screenshot
![IPswitcher](https://user-images.githubusercontent.com/74852121/170251754-7a5bbf7a-f69a-4b30-97c0-d833dfa3587d.png)

---

## 🔗 Git Repository
Clone the repository using the following command:
```sh
git clone https://github.com/KarthickrajaU/ip_switcher.git
```

---

## 📌 Requirements
Ensure you have the following dependencies installed:
- `curl`
- `xterm`
- `torify`

---

## ⚙️ Installation Guide
Follow these steps to install and configure **IPswitcher**:

1. Install the required dependencies:
   ```sh
   sudo apt-get install curl torify xterm
   ```
2. Give execution permissions to the script:
   ```sh
   chmod +x auto.sh
   ```
3. Copy **IPswitcher** to the `/usr/bin/` directory for global access:
   ```sh
   sudo cp ipswitcher /usr/bin/
   ```
4. Execute **IPswitcher** from anywhere in the terminal:
   ```sh
   ipswitcher
   ```

---

## 📹 WorkFlow Video
Watch this video to understand how **IPswitcher** works:
[![Watch the workflow video](https://user-images.githubusercontent.com/74852121/200110190-7f7fb7d0-61bc-40b1-b213-19c379be8c66.mp4)](https://user-images.githubusercontent.com/74852121/200110190-7f7fb7d0-61bc-40b1-b213-19c379be8c66.mp4)

---

## 🛠️ Contribution
We welcome contributions! If you'd like to improve **IPswitcher**, feel free to fork the repository, make changes, and submit a pull request.

---

### 🚀 Happy Hacking!
