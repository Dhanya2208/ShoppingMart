# 🛒 ShoppingMart Web Application

## 📌 Overview
**ShoppingMart** is a dynamic e-commerce web application that allows users to browse, search, and purchase products online while enabling administrators to manage product listings, inventory, and user activities.  
This platform provides an integrated shopping experience with a responsive user interface and robust back-end management.

---

## 🎯 Objectives
The objective of this project is to develop a **web-based e-commerce platform** that delivers a seamless and user-friendly experience for customers and administrators.  
It aims to:

1. **Display Products Effectively**
   - Show all available products with name, price, category, and availability.
   - Categorize items for easy browsing and filtering.

2. **User Account Management**
   - Allow users to sign up, log in, and securely manage their profiles.
   - Validate user input dynamically using **AJAX**.

3. **Cart & Checkout**
   - Add, remove, and update products in a virtual shopping cart.
   - Provide a smooth checkout process with total price calculation.

4. **Admin Management**
   - Enable admin users to add, edit, or delete products.
   - Monitor user activity and manage stock levels.

5. **Enhanced User Experience**
   - Responsive, mobile-friendly design.
   - Dynamic interactions without page reload using **AJAX**.

---

## 🧱 Project Architecture

### 🔹 1. Front-End Infrastructure
The front-end handles all user interactions.

**Technologies Used:**
- **HTML / CSS / JavaScript** – Page structure, styling, interactivity.
- **AJAX / XMLHttpRequest** – Asynchronous operations (e.g., validation, cart updates).
- **Bootstrap** *(optional)* – Responsive and mobile-friendly design.

**Components:**
- **Home Page:** Product listing by category.
- **Cart Interface:** View, update, and manage selected products.
- **Signup/Login Forms:** User registration and authentication.
- **Admin Dashboard:** Manage products, categories, and stock.

---

### 🔹 2. Back-End Infrastructure
The back-end manages business logic, validation, and database operations.

**Technologies Used:**
- **Java Servlets / JSP:** Server-side logic for authentication, product management, and transactions.
- **MySQL:** Stores product, user, cart, and order data.
- **XAMPP / Tomcat:** Hosts application and database locally.

**Key Components:**
- **SignupServlet.java / LoginServlet.java** – Handles user registration and authentication.
- **ProductServlet.java** – Manages product operations (CRUD).
- **CartServlet.java** – Handles cart actions.
- **OrderServlet.java** – Checkout and order processing.

---

### 🔹 3. Database Design (MySQL)
| Table Name | Description |
|-------------|--------------|
| **users** | Stores user details (id, name, email, password, role) |
| **products** | Product catalog with category, price, and stock |
| **categories** | Product category data |
| **cart** | Temporary cart data per user |
| **orders** | Stores completed transactions |

---

## 🧪 Selenium Test Automation

The project integrates **Selenium WebDriver with TestNG** to ensure functionality through automated testing.

### 🔹 Test Coverage
- **BasicsTest.java:**  
  - Launch browsers, open URLs, capture title, refresh, navigate, switch windows.
- **WebElementsTest.java:**  
  - Validate UI elements: `isDisplayed`, `isEnabled`, `isSelected`, `click`, `sendKeys`, `getText`.
- **LocatorsTest.java:**  
  - Identify elements via `id`, `name`, `className`, `linkText`, `cssSelector`, `xpath`.

### 🔹 Tools Used
- **Java 21**
- **Selenium 4.x**
- **TestNG**
- **WebDriverManager** (auto driver setup)
- **Maven** (project management)

---

## ⚙️ Installation & Setup

### 🔧 Prerequisites
- **JDK 21 or above**
- **Eclipse IDE** (or IntelliJ)
- **Apache Tomcat 10+**
- **XAMPP** (for MySQL & Apache)



git clone https://github.com/your-username/ShoppingMart.git
cd ShoppingMart
