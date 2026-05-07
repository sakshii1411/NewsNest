# NewsNest 📰

> A personalized news aggregator with category-based filtering, user authentication, and activity-based recommendations.

![Java](https://img.shields.io/badge/Java-ED8B00?style=flat-square&logo=openjdk&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-007396?style=flat-square&logo=java&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-00000F?style=flat-square&logo=mysql&logoColor=white)
![Tomcat](https://img.shields.io/badge/Apache%20Tomcat-F8DC75?style=flat-square&logo=apachetomcat&logoColor=black)
![NewsAPI](https://img.shields.io/badge/NewsAPI-000000?style=flat-square&logo=rss&logoColor=white)

---

## About

NewsNest is a web-based news aggregator built with Java Servlets and JSP. Users register, select their preferred news categories, and get a personalized feed of real-time headlines fetched from NewsAPI. The system tracks reading activity to surface the most relevant content over time.

---

## Features

- **User Authentication** — secure registration and login with BCrypt password hashing
- **Category Preferences** — select topics like Technology, Sports, Business, Health, etc.
- **Real-time Headlines** — live news fetched from NewsAPI
- **Activity Tracking** — click logging and top-category inference for personalization
- **Session Management** — secure session handling across pages
- **Personalized Feed** — content ranked by your reading history

---

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Java |
| Frontend | JSP, HTML, CSS |
| Backend | Java Servlets |
| Database | MySQL |
| News Data | NewsAPI |
| Security | BCrypt password hashing |
| Server | Apache Tomcat |
| Build | Maven |

---

## Database Schema

```sql
-- Core tables
users          -- user accounts and hashed passwords
preferences    -- category selections per user
activity       -- click logs for personalization
```

Full schema available in `setup.sql`

---

## Run Locally

### Prerequisites
- Java 11+
- Apache Tomcat 9+
- MySQL
- Maven
- NewsAPI key (free at newsapi.org)

### Steps

```bash
# Clone the repo
git clone https://github.com/sakshii1411/NewsNest.git
cd NewsNest

# Set up the database
mysql -u root -p < setup.sql

# Add your NewsAPI key
# Open src/main/java/utils/NewsService.java
# Replace API_KEY with your key

# Build with Maven
mvn clean package

# Deploy the WAR file to Tomcat
cp target/NewsNest.war $TOMCAT_HOME/webapps/

# Start Tomcat
$TOMCAT_HOME/bin/startup.sh
```

Open: http://localhost:8080/NewsNest

---

## Get a NewsAPI Key

1. Go to https://newsapi.org
2. Click **Get API Key** (free tier available)
3. Add it to `NewsService.java`

---

Built by [Sakshi Awasthi](https://github.com/sakshii1411)
