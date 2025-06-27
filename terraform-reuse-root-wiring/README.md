# Approach 1: Root-Level Wiring

## 🧠 Concept

In this pattern, all the modules are wired and composed in the **root module (`main.tf`)**. Each module is completely decoupled, and the root module is responsible for passing outputs from one module as inputs to another.

## 🧱 What’s Implemented

- A `sg` module creates one or more security groups dynamically.
- An `ec2` module creates an EC2 instance.
- The root module wires the security groups to the EC2 instance via `security_group_ids`.

## 📂 Module Flow

[Root Module]
├──> [SG Module] --> outputs = list of SG IDs
└──> [EC2 Module] <-- input = list of SG IDs

## 🔍 Analysis & Trade-offs

In this approach, we are wiring everything directly in the **root module**, including how modules are composed and how dependencies are passed between them.

We have:

- A **Security Group (SG) module** — accepts values from `terraform.tfvars` since the data is **static** (e.g., name, description).
- An **EC2 module** — requires both **static** and **dynamic** values.

### 🧩 Why is EC2 more complex?

The EC2 module depends on **security group IDs**, which are:

- **Dynamically created** by the SG module
- **Not known ahead of time**, so they cannot be placed in `terraform.tfvars`
- Therefore, these IDs must be **manually wired in the root module (`main.tf`)** using `module.sg.security_group_ids["<key>"]`

As a result, configuration is split:

- **Static values** (like AMI, instance type, subnet ID) go into `terraform.tfvars`
- **Dynamic values** (like security group IDs) must be passed via `main.tf`

This means we lose the simplicity of a **single point of entry**.

---

### ⚠️ Trade-offs Summary

| ✅ Pros                                          | ❌ Cons                                                              |
| ------------------------------------------------ | -------------------------------------------------------------------- |
| Clean separation of module responsibilities      | Root module becomes verbose and harder to maintain                   |
| Modules are reusable and generic                 | Cannot define everything from a single file (`tfvars`)               |
| Static config is easy to manage with `tfvars`    | Dynamic config (like SGs for EC2) must be manually wired             |
| Ideal for small projects with fewer dependencies | Scalability and maintainability become challenging in larger systems |

---

### 💡 What’s Next?

In the [next approach](../terraform-reuse-child-wiring), we’ll explore how wiring **inside child modules** can reduce root module complexity — and what trade-offs it introduces in terms of coupling and reusability.

## ▶️ How to Run

```bash
terraform init
terraform plan
terraform apply
```
