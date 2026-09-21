# 🚀 Collect — Production Flutter Application

I’m excited to share one of the latest projects I’ve worked on using **Flutter**: **Collect**, a **Production Application** designed for debt management and collection.

## 💰 About Collect

**Collect** helps business owners manage debts owed by debtors, track payments, postponements, and changes to debt amounts, while organizing debts by their current status.

This makes it easier to know what has been collected, what is due, and what is overdue.

## 🔐 Authentication

The app provides multiple authentication options:

- Sign up and log in using **Email & Password**
- Sign in directly with **Google**
- **Forgot Password** functionality that sends a password-reset link to the user's email

After signing in, the user is taken to the main application.

## 🏠 Home

The Home section consists of **4 pages** accessible through a **Bottom Navigation View**.

### 1️⃣ Debts

The first page is dedicated to viewing and managing debts.

A **Summary** section provides information such as:

- Total outstanding debts
- Total amount collected today
- Total amount due today
- Total overdue amount

The debts can also be filtered by:

- **All Debts**
- **Nearly Due**
- **Due Today**
- **Late**
- **Paid Today**

When selecting a debt, the user can view its complete details.

### 💳 Debt Details

From the debt details page, the user can manage the debt whether it is being paid in one payment or through multiple installments.

Available actions include:

- Pay an installment
- Postpone a payment
- Increase the debt amount
- Decrease the debt amount
- **Settlement** — settle the remaining debt completely
- Delete the debt

The page also includes an **Ask** feature for contacting the debtor.

If a phone number is available, the user can:

- Contact the debtor through **WhatsApp**
- Call the debtor directly

Users can also create and save predefined messages from **Settings** and use them when requesting payment through the Ask feature.

### 2️⃣ Debtors

The second page displays a list of all debtors with a search option by name.

Each debtor profile contains:

- Name — required
- Phone number — optional
- Address — optional

The profile also provides a history of:

- Paid installments
- Postponements
- Debt increases
- Debt decreases
- Other changes related to the debtor's debts

### 3️⃣ Statistics

The third page provides statistics and charts related to debt collection.

It displays information such as:

- Collected amounts
- Uncollected amounts
- Other debt and collection statistics

This helps users understand the overall status of their debt collection.

### 4️⃣ Settings

The Settings page includes:

- User name and email
- Profile picture when signed in with Google
- **Dark Mode / Light Mode**
- Support for **8 languages**
- **Help Center**
- **Contact Us**
- **About App**
- Management of predefined messages used with the **Ask** feature
- **Sign Out**

## 🔒 Security

Security was an important part of the application.

The app uses:

- **Firebase Security Rules** to control access to user data
- **Flutter Secure Storage** for securely storing sensitive data
- **Encryption Package** to encrypt important data before sending it to Firebase

## 🛠️ Tech Stack

**Flutter • Dart • MVC • Firebase Authentication • Cloud Firestore • Firebase Security Rules • Flutter Secure Storage • Encryption • Shared Preferences • Localization**

Building **Collect** was a valuable practical experience in developing a complete **Production Application** and working with:

**Authentication • Database • Business Logic • Localization • Security • UI/UX**

🚀 I’m continuing to improve my **Flutter** skills and build practical applications that solve real-world problems.

#Flutter #FlutterDeveloper #Dart #Firebase #Firestore #MobileDevelopment #SoftwareDevelopment #AppDevelopment #MVC #ProductionApp #FlutterProjects #Programming