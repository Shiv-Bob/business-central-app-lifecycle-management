# 🏗️ BC App Lifecycle Management

A reference implementation of professional Business Central (AL) app lifecycle 
patterns, built around a practical example: an **Employee Certification Tracker**.

This repo demonstrates how a real BC extension should handle its full lifecycle — 
from first install, through ongoing background processing, to safe upgrades 
across versions — using patterns recommended for production and AppSource-ready 
extensions.

---

## 📋 What This App Does

Tracks employee certifications/training records, including issue and expiry dates. 
It automatically flags certifications as **Active**, **Expiring Soon**, or **Expired**, 
runs a daily background check, and can optionally notify when certifications are 
about to expire.

The "certification tracker" itself is intentionally simple — the real focus of 
this repo is **how the extension manages its own lifecycle** around that core idea.

---

## 🎯 What's Covered

| Area | What it demonstrates |
|---|---|
| **Setup** | Core data model: `Employee Certification` table, `Certification Setup` table, status enum, and Employee Card page extension |
| **Install** | `OnInstallAppPerCompany` — initializing setup records and seeding demo data on first install |
| **Upgrade** | `OnUpgradePerCompany` + Upgrade Tags — idempotent, safe-to-rerun migration logic for existing data |
| **Telemetry** | `Session.LogMessage` — custom telemetry events for install, upgrade, and monitoring |
| **Job Queue** | Scheduling a recurring background task to check certification statuses daily |
| **Feature Flags** | A custom opt-in setting pattern (setup table boolean) for gradually rolling out new behavior |
| **Demo Data** | Seeding sample certification records so the app is immediately usable after install |

---

## 🧱 Project Structure

src/
├── Setup/
│   ├── CertificationStatus.Enum.al
│   ├── EmployeeCertification.Table.al
│   ├── CertificationSetup.Table.al
│   ├── EmployeeCertificationsExt.PageExt.al
│   └── EmployeeCertificationsSubpage.Page.al
├── Install/
│   └── InstallManagement.Codeunit.al
├── Upgrade/
│   ├── UpgradeTags.Codeunit.al
│   └── UpgradeManagement.Codeunit.al
├── Telemetry/
│   └── TelemetryHelper.Codeunit.al
├── JobQueue/
│   ├── JobQueueSetup.Codeunit.al
│   └── CheckCertificationStatus.Codeunit.al
├── Features/
│   └── CertificationNotifier.Codeunit.al
└── Demo/
└── DemoDataSetup.Codeunit.al

---

## 🔄 How It All Connects — The Lifecycle Story

**Day 0 — Install**
- `OnInstallAppPerCompany` fires automatically when the extension is installed.
- A `Certification Setup` record is created with sensible defaults.
- A handful of sample certification records are seeded so the app isn't empty.
- Telemetry logs that installation completed successfully.

**Day 1 onward — Running**
- A recurring Job Queue entry runs `Check Certification Status` daily.
- It recalculates each certification's status (Active / Expiring Soon / Expired) based on the expiry date.
- If "Email Notifications" is enabled in setup, expiring certifications trigger a notification.
- Telemetry logs how many certifications are currently expiring.

**Months later — Upgrade**
- When the extension version changes (e.g., 1.0 → 1.1), `OnUpgradePerCompany` fires automatically.
- Upgrade Tags ensure each migration step runs **exactly once**, even if the upgrade process is retried.
- `OnValidateUpgradePerCompany` confirms all expected upgrade steps actually completed.
- Telemetry logs that the upgrade completed.

---

## 💡 Why This Matters

Every production-grade BC extension needs to handle:

- **First-run setup** — so the app works immediately without manual configuration
- **Safe upgrades** — migrating existing customer data without breaking it or running migrations twice
- **Observability** — telemetry so issues in live environments can be diagnosed remotely
- **Background automation** — work that happens reliably without a user clicking anything
- **Controlled rollout** — new behavior that can be turned on deliberately, not forced on everyone at once

These patterns reflect what's expected of mature, production-ready AL extensions — 
the kind of thinking that goes beyond "make the page show the data."

---

## 📦 Notes on Design Decisions

- **Self-contained**: this repo defines its own minimal `Loyalty`-free, certification-specific 
  data model (status enum, table, table extension) so it can be cloned and reviewed 
  independently — no dependency on other repos.

- **Feature flags**: rather than integrating with Microsoft's internal Feature Management 
  page (which doesn't expose a public extension point for third-party feature registration), 
  this repo uses a simple, realistic ISV pattern — a boolean setting on the app's own 
  setup table, toggled via the setup page. This achieves the same "off by default, 
  opt-in later" goal in a way that's fully within the extension's control.

- **Demo data**: seeded only when `GuiAllowed()` is true, to avoid creating sample 
  records during silent/automated installs (e.g., CI pipelines).

---

## 🛠️ Tech

- AL Language
- Microsoft Dynamics 365 Business Central (v28)
- Object ID range: 50220–50250

---

## 📚 Further Reading

- [Upgrading Extensions (Microsoft Learn)](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-upgrading-extensions)
- [Application Lifecycle (Microsoft Learn)](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/administration/application-lifecycle)
- [Telemetry in Business Central (Microsoft Learn)](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/administration/telemetry-overview)