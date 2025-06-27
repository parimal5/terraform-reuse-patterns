# Approach 2: Shared Context Wiring

## 🧠 Concept

In this pattern, modules remain separate, but we introduce a **shared context** — a common variable (like `security_groups`) that is passed into **both** modules. This allows modules to coordinate using the same source of truth, even though they are not nested.

The **EC2 module does not create security groups**, but it relies on the **structure of the `security_groups` map** to determine which SGs to attach — based on a shared naming convention.

## 🧱 What’s Implemented

- A `sg` module dynamically creates security groups using a `map(object)` input.
- An `ec2` module creates EC2 instances using a `map(object)` input.
- The root module:
  - Passes `security_groups` to both the SG and EC2 modules.
  - Passes the SG output (`map of SG IDs`) to the EC2 module.
- The EC2 module:
  - Uses the `security_groups` list for each instance (e.g., `["web", "ssh"]`)
  - Looks up the SG IDs using `lookup(var.sg_id_map, sg_name)`

## 📂 Module Flow

[Root Module]
├──> [SG Module] (input: security_groups) → outputs = SG name → ID
└──> [EC2 Module]
        ↳ input: instances + security_groups + sg_id_map

## 🔍 Analysis & Trade-offs

In this approach, the root module is simplified: it no longer has to manually wire SG IDs into the EC2 module. Instead, it just passes down a common `security_groups` map, and the EC2 module takes care of resolving SG names to IDs using a shared `sg_id_map`.

However, this convenience comes with a price: **tight coupling**.

The EC2 module must now:

- Know the **structure** of the `security_groups` config.
- Trust that the SG module and `sg_id_map` match that structure.
- Perform dynamic logic (using `locals` and `lookup()`) to compute `vpc_security_group_ids`.

This means the EC2 module is no longer **truly isolated or reusable**, because it assumes naming conventions and dependencies from the SG module.

### 💡 What’s Next?

In the [next approach](../terraform-reuse-lookup/), we’ll remove the shared dependency entirely. EC2 will only receive a map of SG IDs, and use a lookup by name — avoiding any structural knowledge of SG config.

This gives us true decoupling and maximum reusability — with a different set of trade-offs.
