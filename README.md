# 🌐 Clean IP Finder

> Real-time IP scanner for finding clean and accessible IP addresses

[![GitHub](https://img.shields.io/badge/GitHub-@lavateam--IR-blue?style=flat&logo=github)](https://github.com/lavateam-IR)
[![Python](https://img.shields.io/badge/Python-3.6+-green?style=flat&logo=python)](https://python.org)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=flat)](LICENSE)

---

## 📖 English

### 📌 Description

**Clean IP Finder** is a powerful Python tool designed to find clean, accessible IP addresses in real-time. It scans multiple domains using various DNS servers and tests each IP to ensure it's working and accessible.

### ✨ Features

- 🔍 **Real-time scanning** - Always gets fresh IPs, no cached lists
- 🌐 **Multi-DNS support** - Uses Google (8.8.8.8), Cloudflare (1.1.1.1), and Quad9 (9.9.9.9)
- 🚀 **Multi-threaded** - Fast scanning with thread pool execution
- 🛡️ **Cloudflare detection** - Automatically skips Cloudflare IPs
- 🎨 **Colorful output** - Beautiful terminal interface with colors
- 💾 **Auto-save** - Saves working IPs to `clean_ips.txt`
- 📊 **Domain mapping** - Shows which IP belongs to which domain

### 📋 Requirements

- Python 3.6 or higher
- `dig` command (installed automatically if missing)
- Internet connection

### 🔧 Installation

```bash
# Clone the repository
git clone https://github.com/lavateam-IR/Clean-ip-finder.git
cd Clean-ip-finder

# Install Python dependencies
pip install requests colorama

# Make it executable (Linux/Mac)
chmod +x clean-ip.py

# Run it
python3 clean-ip.py
```

🚀 Quick Start

```bash
# One-line installation and run
curl -fsSL https://raw.githubusercontent.com/lavateam-IR/Clean-ip-finder/main/clean-ip.py -o clean-ip.py && python3 clean-ip.py
```

📂 Output

The tool creates a file called clean_ips.txt containing all working IP addresses:

```
142.250.185.78
142.250.185.110
149.154.167.99
104.244.42.193
```

🛠️ How It Works

1. DNS Resolution - Uses multiple DNS servers to resolve domain names
2. IP Filtering - Skips private IPs, Cloudflare IPs, and invalid addresses
3. Live Testing - Sends HTTP requests to test if IPs are actually working
4. Multi-threading - Scans multiple domains simultaneously for speed
5. Results Saving - Writes working IPs to clean_ips.txt

📊 Scanned Domains

The tool scans these popular domains by default:

· google.com
· youtube.com
· telegram.org
· instagram.com
· twitter.com
· aparat.com
· digikala.com
· github.com
· stackoverflow.com
· whatsapp.net

📝 Usage Examples

```bash
# Basic usage
python3 clean-ip.py

# With specific domains (edit the list in code)
python3 clean-ip.py

# View saved IPs
cat clean_ips.txt

# Copy IPs to clipboard (Linux)
cat clean_ips.txt | xclip -selection clipboard
```

🤝 Contributing

Contributions are welcome! Feel free to:

· Fork the repository
· Create a new branch
· Make your changes
· Submit a pull request

📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

👨‍💻 Author

LavaTeam-IR - GitHub

---

📖 فارسی

📌 توضیحات

Clean IP Finder یک ابزار قدرتمند پایتون برای پیدا کردن آیپی‌های تمیز و قابل دسترس در لحظه است. این ابزار با اسکن چندین دامنه با استفاده از سرورهای DNS مختلف و تست هر آیپی، آیپی‌های زنده و قابل استفاده را پیدا می‌کند.

✨ ویژگی‌ها

· 🔍 اسکن لحظه‌ای - همیشه آیپی‌های جدید دریافت می‌کند، بدون استفاده از لیست‌های کش شده
· 🌐 پشتیبانی از چند DNS - استفاده از گوگل (8.8.8.8)، کلودفلر (1.1.1.1) و Quad9 (9.9.9.9)
· 🚀 چند رشتگی - اسکن سریع با استفاده از ترد پول
· 🛡️ تشخیص کلودفلر - به‌طور خودکار آیپی‌های کلودفلر را رد می‌کند
· 🎨 خروجی رنگی - رابط ترمینال زیبا با رنگ‌بندی حرفه‌ای
· 💾 ذخیره خودکار - ذخیره آیپی‌های کارآمد در فایل clean_ips.txt
· 📊 نقشه‌برداری دامنه - نشان می‌دهد هر آیپی متعلق به کدام دامنه است

📋 پیش‌نیازها

· پایتون 3.6 یا بالاتر
· دستور dig (به‌طور خودکار نصب می‌شود اگر موجود نباشد)
· اتصال به اینترنت

🔧 نصب و راه‌اندازی

```bash
# کلون کردن ریپازیتوری
git clone https://github.com/lavateam-IR/Clean-ip-finder.git
cd Clean-ip-finder

# نصب وابستگی‌های پایتون
pip install requests colorama

# قابل اجرا کردن (لینوکس/مک)
chmod +x clean-ip.py

# اجرا
python3 clean-ip.py
```

🚀 شروع سریع

```bash
# نصب و اجرا با یک خط
curl -fsSL https://raw.githubusercontent.com/lavateam-IR/Clean-ip-finder/main/clean-ip.py -o clean-ip.py && python3 clean-ip.py
```

📂 خروجی

این ابزار یک فایل به نام clean_ips.txt ایجاد می‌کند که شامل تمام آیپی‌های کارآمد است:

```
142.250.185.78
142.250.185.110
149.154.167.99
104.244.42.193
```

🛠️ نحوه کارکرد

1. تفکیک DNS - استفاده از چندین سرور DNS برای یافتن آیپی‌های دامنه‌ها
2. فیلتر کردن آیپی - رد کردن آیپی‌های خصوصی، آیپی‌های کلودفلر و آدرس‌های نامعتبر
3. تست زنده - ارسال درخواست HTTP برای بررسی کارایی آیپی‌ها
4. چند رشتگی - اسکن همزمان چندین دامنه برای سرعت بیشتر
5. ذخیره نتایج - نوشتن آیپی‌های کارآمد در فایل clean_ips.txt

📊 دامنه‌های اسکن شده

ابزار به‌طور پیش‌فرض این دامنه‌های محبوب را اسکن می‌کند:

· google.com
· youtube.com
· telegram.org
· instagram.com
· twitter.com
· aparat.com
· digikala.com
· github.com
· stackoverflow.com
· whatsapp.net

📝 مثال‌های استفاده

```bash
# استفاده پایه
python3 clean-ip.py

# با دامنه‌های خاص (لیست را در کد ویرایش کنید)
python3 clean-ip.py

# مشاهده آیپی‌های ذخیره شده
cat clean_ips.txt

# کپی کردن آیپی‌ها در کلیپ‌بورد (لینوکس)
cat clean_ips.txt | xclip -selection clipboard
```

🤝 مشارکت

مشارکت شما خوش‌آمد است! می‌توانید:

· ریپازیتوری را فورک کنید
· یک برنچ جدید ایجاد کنید
· تغییرات خود را اعمال کنید
· یک پول‌ریکوئست ارسال کنید

📄 لایسنس

این پروژه تحت لایسنس MIT منتشر شده است - برای جزئیات بیشتر فایل LICENSE را ببینید.

👨‍💻 نویسنده

LavaTeam-IR - GitHub

---

🌟 Support

If you find this tool useful, please consider:

· ⭐ Starring the repository
· 🐛 Reporting issues
· 🔧 Contributing to the project

---

🔗 Links

· Repository: github.com/lavateam-IR/Clean-ip-finder
· Author: github.com/lavateam-IR

---

Made with ❤️ by LavaTeam-IR

