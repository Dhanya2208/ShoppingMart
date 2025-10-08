<!DOCTYPE html>
<html>
<head>
  <title>SIGN UP</title>
  <style>
    body {
      background-position: center;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .form-container {
      width: 30%;
      background-color: rgba(255, 255, 255, 0.9);
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
      color: #2e7d32;
    }

    form input[type="text"],
    form input[type="password"] {
      width: 100%;
      padding: 10px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    form input[type="submit"] {
      width: 100%;
      padding: 10px;
      background-color: #0f2d16;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 16px;
    }

    form input[type="submit"]:hover {
      background-color: #1b5027;
    }

    .link {
      text-align: center;
      margin-top: 15px;
      font-size: 14px;
    }

    .link a {
      color: #2e7d32;
      text-decoration: none;
    }

    .link a:hover {
      text-decoration: underline;
    }

    /* Validation message style */
    .msg {
      font-size: 13px;
      display: block;
      margin-top: -8px;
      margin-bottom: 8px;
    }
  </style>
</head>
<body>
  <div class="form-container">
    <h2>Create Account</h2>
    <form action="SignupServlet" method="post" onsubmit="return checkForm()">
      Name: <input type="text" name="name" id="name" onkeyup="checkName()" required>
      <span id="nameMsg" class="msg"></span><br>

      Email: <input type="text" name="email" id="email" onkeyup="checkEmail()" required>
      <span id="emailMsg" class="msg"></span><br>

      Password: <input type="password" name="password" id="password" onkeyup="checkPassword()" required>
      <span id="passMsg" class="msg"></span><br>

      Phone: <input type="text" name="phone" id="phone" onkeyup="checkPhone()" required>
      <span id="phoneMsg" class="msg"></span><br>

      Location: <input type="text" name="location" id="location" onkeyup="checkLocation()" required>
      <span id="locMsg" class="msg"></span><br>

      <input type="submit" value="Sign Up">
    </form>

    <div class="link">
      Already have an account? <a href="login.jsp">Login here</a>
    </div>
  </div>

  <script>
   
    function checkName() {
      let name = document.getElementById("name").value.trim();
      let msg = document.getElementById("nameMsg");
      if (name.length === 0) {
        msg.style.color = "red";
        msg.innerHTML = "Name is required";
      } else {
        msg.style.color = "green";
        msg.innerHTML = "✔ Looks good";
      }
    }

    
    function checkEmail() {
      let email = document.getElementById("email").value.trim();
      let msg = document.getElementById("emailMsg");
      if (email.length === 0) {
        msg.innerHTML = "Email is required";
        msg.style.color = "red";
        return;
      }

      if (!email.includes("@") || !email.includes(".")) {
        msg.style.color = "red";
        msg.innerHTML = "Invalid email format";
        return;
      }

      let xhr = new XMLHttpRequest();
      xhr.onreadystatechange = function() {
        if (this.readyState === 4 && this.status === 200) {
          console.log("Response:", this.responseText); 
          if (this.responseText.trim() === "exists") {
            msg.style.color = "red";
            msg.innerHTML = "Email already registered";
          } else {
            msg.style.color = "green";
            msg.innerHTML = "Email available";
          }
        }
      };
      xhr.open("GET", "EmailCheckServlet?email=" + encodeURIComponent(email), true);
      xhr.send();
    }

    
    function checkPassword() {
      let pass = document.getElementById("password").value;
      let msg = document.getElementById("passMsg");
      if (pass.length < 6) {
        msg.style.color = "red";
        msg.innerHTML = "Password must be at least 6 characters";
      } else {
        msg.style.color = "green";
        msg.innerHTML = "Strong enough";
      }
    }

   
    function checkPhone() {
      let phone = document.getElementById("phone").value.trim();
      let msg = document.getElementById("phoneMsg");
      if (!/^\d{10}$/.test(phone)) {
        msg.style.color = "red";
        msg.innerHTML = "Phone must be exactly 10 digits";
      } else {
        msg.style.color = "green";
        msg.innerHTML = "Valid phone number";
      }
    }

   
    function checkLocation() {
      let location = document.getElementById("location").value.trim();
      let msg = document.getElementById("locMsg");
      if (location.length === 0) {
        msg.style.color = "red";
        msg.innerHTML = "Location is required";
      } else {
        msg.style.color = "green";
        msg.innerHTML = "✔ OK";
      }
    }

   
    function checkForm() {
      checkName();
      checkEmail();
      checkPassword();
      checkPhone();
      checkLocation();

      
      let msgs = document.querySelectorAll(".msg");
      for (let m of msgs) {
        if (m.style.color === "red" && m.innerHTML !== "") {
          alert("Please fix errors before submitting");
          return false;
        }
      }
      return confirm("Are you sure you want to submit?");
    }
  </script>
</body>
</html>
