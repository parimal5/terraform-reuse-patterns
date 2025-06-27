# Terraform Module Reuse Patterns

This repository demonstrates multiple approaches to structuring reusable Terraform modules. Each subdirectory represents a distinct pattern of wiring and reusing modules.

## 📁 Sub-Repos

- [`terraform-reuse-root-wiring`](./terraform-reuse-root-wiring): Root module wires everything
- [`terraform-reuse-child-wiring`](./terraform-reuse-child-wiring): Child modules wire dependencies
- [`terraform-reuse-lookup`](./terraform-reuse-lookup): Resources extracted via `lookup()` from map/list

## 🎯 Goal

To explore:
- How reusable each approach is
- Trade-offs and maintainability
- How dynamic or static the inputs can be

Each approach has its own `README.md` with details on the pattern used, Terraform implementation, and design decisions.

---

> Note: All examples use basic EC2 and Security Group modules to demonstrate the concepts simply.
