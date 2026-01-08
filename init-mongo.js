// Initialize MongoDB with default user and database
// This script runs automatically when the container starts

db = db.getSiblingDB("admin")

// Create admin user (root user is created by MONGO_INITDB_ROOT_USERNAME env var)
// This is just for reference and additional setup if needed

// Create default application database
db = db.getSiblingDB("myapp")

// Create default collections (optional)
db.createCollection("users")
db.createCollection("products")

console.log("MongoDB initialization completed")
