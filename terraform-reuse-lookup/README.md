# Approach 3: Decoupled Lookup Pattern

## 🧠 Concept

This approach decouples the EC2 and Security Group (SG) modules completely. The EC2 module does **not know** how or where SGs are created — it just works with a **map of SG IDs**, passed from the root module.

Each EC2 instance in the `tfvars` only declares the names of SGs it needs (like `"web"`, `"ssh"`), and the actual mapping from name to ID is passed in separately. The EC2 module looks up the corresponding SG IDs from this map internally.

## 🧱 What’s Implemented

- The SG module accepts a map of definitions and returns a map of SG name to ID.
- The EC2 module accepts a map of instance definitions, where each instance lists SG **names** it wants.
- The EC2 module dynamically resolves the SG names to actual IDs using the SG output map (`sg_id_map`).
- The root module wires everything together — but **doesn’t hardcode dependencies**.

## 📂 Module Flow

[Root Module]
├──> [SG Module] → output: map of SG name → SG ID
└──> [EC2 Module]
↳ receives instance config + sg_id_map
↳ performs name-to-ID resolution internally

## 📦 tfvars as Single Source of Truth?

Yes — in this approach:

- All static config (AMI, instance type, subnet, SG names) is defined in `terraform.tfvars`
- No need to manually wire SG IDs or outputs in the root
- You get near-complete declarative behavior from a single config file

The only dynamic piece is that the EC2 module performs the name-to-ID resolution internally — not the root module.

---

## ⚠️ Trade-offs Summary

| ✅ Pros                                         | ❌ Cons                                            |
| ----------------------------------------------- | -------------------------------------------------- |
| Full decoupling of EC2 and SG modules           | Assumes SG names exist in the SG output map        |
| Root module stays clean and declarative         | Some runtime logic in the EC2 module (map lookup)  |
| Reusable module inputs and simple `tfvars`      | Less reusable if naming schemes change             |
| tfvars remains the single point of static input | SG structure must match expectations of EC2 module |

---

## 💡 What’s Next?

In [Approach 4](../terraform-reuse-merge-pattern), we take it one step further: we enrich the instance data using `merge()` and `lookup()` in `locals`, building the final full config before applying it — enabling better composition, validation, and reusability.

---

## ▶️ How to Run

```bash
terraform init
terraform plan
terraform apply
```
