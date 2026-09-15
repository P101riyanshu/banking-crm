# Banking CRM

This is my Salesforce Banking CRM project. I built it to practise turning a real banking workflow into a Salesforce application instead of just creating isolated Apex or LWC examples.

The project brings customer onboarding, bank accounts, loan applications, transactions, and service requests into one place. The aim is to give bank staff a clearer view of a customer and the activity connected to their account.

## What I built

- Custom objects for customers, bank accounts, loan applications, loans, transactions, and service requests.
- Lightning Web Components for common banking tasks, including account creation, transaction entry, loan calculations, EMI summaries, account details, and customer/account counts.
- Apex controllers and trigger handlers to support the UI and apply business logic.
- Record-triggered and scheduled flows for automations such as loan-status updates and payment reminders.
- Custom tabs, page layouts, quick actions, permission sets, and profiles to make the app usable for different banking roles.

## Project structure

```text
force-app/main/default/
├── classes/          Apex controllers and supporting logic
├── triggers/         Trigger-based validation and automation
├── lwc/              Lightning Web Components
├── objects/          Custom object definitions and fields
├── flows/            Salesforce Flow automations
├── layouts/          Page layouts
├── permissionsets/   Access configuration
└── tabs/             Custom navigation tabs
```

## Getting started

### Prerequisites

- Salesforce CLI
- VS Code with the Salesforce Extension Pack
- A Salesforce Developer Edition, sandbox, or scratch org

### Authorize an org

```bash
sf org login web --alias my-org
```

### Deploy the project

```bash
sf project deploy start --source-dir force-app --target-org my-org
```

### Retrieve changes made in Salesforce

```bash
sf project retrieve start --source-dir force-app --target-org my-org
```

## Notes

This repository stores Salesforce metadata and source code only. Local Salesforce authentication, cache files, dependencies, and environment files are ignored through `.gitignore`.

I am continuing to improve the CRM by refining the banking workflows, adding validation, and making the Lightning experience easier for users to work with.
