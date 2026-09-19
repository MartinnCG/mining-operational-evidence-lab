# Field Design Questions

These questions require Martin's generalized field judgment. Answers must not contain employer, site, person, asset, or incident identifiers.

## Decisions recorded for M1

The initial project positioning resolves four foundational questions:

- **Professional audience:** clients, recruiters, and companies evaluating Martin's experience and systems capability.
- **Synthetic operational persona:** incoming supervisor.
- **Handover unit:** work front, capable of grouping multiple tasks and dependencies.
- **First value problem:** ambiguity between reported, evidence-supported, pending, conflicting, and unknown state.

These decisions remain hypotheses to test through synthetic scenarios. They do not describe or reproduce one employer's workflow.

## Handover unit

1. Which task and dependency attributes must a work front contain?
2. When does a work front count as meaningfully changed?
3. When should one work front split into two?

## Incoming supervisor view

4. What three facts must the incoming supervisor understand in under one minute?
5. What should remain hidden or secondary unless requested?
6. Which condition should be visually dominant: blocker, evidence gap, ownership, or change since last handover?

## Evidence and uncertainty

7. Which generic evidence types most often support a status assertion?
8. What is commonly reported as complete before the evidence is actually available?
9. How should conflicting verbal and recorded updates appear?
10. When should the system say “unknown” rather than infer a state?

## Interruptions and blockers

11. Which generic classes matter most: access, material, tooling, dependency, inspection, weather, coordination, or evidence delay?
12. Which interruptions change the handover state, and which are only context?
13. What makes ownership of the next action unambiguous?

## Authority boundary

14. Which statements would be dangerous if a software system presented them as authorization?
15. What wording clearly separates “evidence recorded” from “safe/approved/ready to work”?
16. Which decisions must always remain with site procedures and competent roles?

## Professional value test

17. What should a recruiter or client be able to verify in five minutes?
18. Which artifact best demonstrates the connection between field experience and systems design?
19. What existing tool or practice would this complement rather than replace?
20. What observable metric would show that the synthetic handover became better?
