# MongoDB Docker - Complete Setup Guide

Production-ready MongoDB setup with persistent storage and easy multi-device deployment.

---

## 🚀 Quick Start (3 Steps)

### Step 1: Edit Credentials

Open `.env` file and change passwords:

```env
MONGO_ROOT_PASSWORD=YourSecurePassword123!
EXPRESS_PASSWORD=YourSecurePassword123!
```

### Step 2: Start Services

**Windows:** Double-click `start.bat`
**Linux/Mac:** Run `docker-compose up -d`

### Step 3: Access

-   **Mongo Express (Web UI):** http://localhost:8081
-   **MongoDB:** localhost:27017
-   **Username:** admin
-   **Password:** (from .env file)

---

## 📋 Features

✅ MongoDB 7.0 with authentication
✅ Mongo Express web UI
✅ Persistent Docker volumes
✅ Health checks & auto-restart
✅ Resource limits
✅ Auto-initialization

---

## 💻 Essential Commands

### Start/Stop

```bash
docker-compose up -d        # Start MongoDB
docker-compose down         # Stop MongoDB
docker-compose ps           # Check status
docker-compose logs -f      # View logs
```

### Connect to MongoDB Shell

```bash
docker exec -it mongodb mongosh -u admin -p YOUR_PASSWORD --authenticationDatabase admin

# Inside shell (>):
show databases              # List databases
use myapp                   # Switch database
show collections            # List collections
db.users.find()             # Find all documents
db.users.insertOne({name:"John", email:"john@example.com"})  # Insert
db.users.updateOne({name:"John"}, {$set:{email:"new@example.com"}})  # Update
db.users.deleteOne({name:"John"})  # Delete
exit                        # Exit
```

### Backup & Restore

```bash
backup.bat                  # Backup (Windows)
./backup.sh                 # Backup (Linux/Mac)
restore.bat backup/path     # Restore (Windows)
```

---

## 🔌 Connection Examples

### Node.js / Express

```javascript
const { MongoClient } = require("mongodb")

const uri = "mongodb://admin:YOUR_PASSWORD@localhost:27017/myapp?authSource=admin"
const client = new MongoClient(uri)

async function connect() {
    await client.connect()
    const db = client.db("myapp")
    const users = await db.collection("users").find().toArray()
    console.log(users)
    await client.close()
}

connect()
```

### Python

```python
from pymongo import MongoClient

uri = "mongodb://admin:YOUR_PASSWORD@localhost:27017/myapp?authSource=admin"
client = MongoClient(uri)
db = client.myapp
collection = db.users

collection.insert_one({"name": "John"})
users = list(collection.find())
print(users)
client.close()
```

### Java

```java
import com.mongodb.client.*;
import org.bson.Document;

String uri = "mongodb://admin:YOUR_PASSWORD@localhost:27017/myapp?authSource=admin";
MongoClient mongoClient = MongoClients.create(uri);
MongoDatabase database = mongoClient.getDatabase("myapp");
MongoCollection<Document> collection = database.getCollection("users");

collection.insertOne(new Document("name", "John"));
mongoClient.close();
```

### Docker Container to MongoDB

```javascript
// In docker-compose.yml, use service name instead of localhost:
const uri = "mongodb://admin:YOUR_PASSWORD@mongodb:27017/myapp?authSource=admin"
```

---

## 🌍 Multi-Device Setup

### Using GitHub

```bash
git init && git add . && git commit -m "MongoDB setup"
git push origin main

# On other device:
git clone your-repo-url && docker-compose up -d
```

### Using Cloud Storage

1. Save folder to Dropbox/OneDrive/Google Drive
2. Access on other device
3. Run: `docker-compose up -d`

---

## 🔐 Security

1. **Edit `.env`** - Change default passwords to strong ones
2. **Use 12+ characters** - Mix uppercase, lowercase, numbers, symbols
3. **Don't share `.env`** - Already protected by .gitignore
4. **Regular backups** - Run backup.bat or ./backup.sh weekly

---

## 🛠️ Troubleshooting

| Problem               | Solution                                         |
| --------------------- | ------------------------------------------------ |
| Port 27017 in use     | Change in docker-compose.yml: `"27018:27017"`    |
| Container won't start | Run: `docker-compose logs mongodb`               |
| Authentication failed | Verify .env passwords match docker-compose.yml   |
| First run timeout     | Wait 30-40 seconds, then try again               |
| Reset & start fresh   | `docker-compose down -v && docker-compose up -d` |

---

## 📁 Files Included

| File               | Purpose                            |
| ------------------ | ---------------------------------- |
| docker-compose.yml | Main MongoDB + Mongo Express setup |
| .env               | Your credentials (keep private!)   |
| .env.example       | Credentials template               |
| init-mongo.js      | Auto-initialization script         |
| start.bat          | Quick start (Windows)              |
| stop.bat           | Quick stop (Windows)               |
| backup.bat         | Backup database (Windows)          |
| restore.bat        | Restore database (Windows)         |
| backup.sh          | Backup database (Linux/Mac)        |
| .gitignore         | Prevent .env from version control  |

---

## 🔑 Default Access

```
Mongo Express Web UI:  http://localhost:8081
MongoDB:               localhost:27017
Username:              admin
Password:              (from .env file)

Connection String:
mongodb://admin:PASSWORD@localhost:27017/admin?authSource=admin
```

---

## ❓ FAQ

**Q: Will data be lost if I restart?**
A: No! Docker volumes persist data automatically.

**Q: How do I use this on Mac/Linux?**
A: Same setup. Run `docker-compose up -d` instead of start.bat

**Q: Can I use on multiple devices?**
A: Yes! Push to GitHub or cloud storage, then clone/sync on other devices.

**Q: How do I backup?**
A: Run `backup.bat` (Windows) or `./backup.sh` (Linux/Mac)

**Q: Is this production-ready?**
A: Yes! Includes authentication, health checks, and resource limits.

---

**Status:** ✅ Complete | **Version:** 1.0 | **Updated:** January 2026

# Restart containers

docker-compose restart

````

### Reset Everything

```bash
# Stop and remove containers, networks, and volumes
docker-compose down -v

# Start fresh
docker-compose up -d
````
