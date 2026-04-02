FAQ
===

What does MERIT score: trainability only or interpretability too?
-----------------------------------------------------------------

Both. Core ML readiness intentionally includes annotation quality so score
captures predictive feasibility plus metabolomics interpretability.

Why is Metadata / FAIR reported separately?
-------------------------------------------

FAIR metadata quality is critical for reuse and reproducibility, but it is not
a direct proxy for whether labels/matrices are immediately usable for supervised
ML training. MERIT therefore reports reusability separately.

Why can final band be lower than provisional band?
--------------------------------------------------

The provisional band comes from core score only.
Final band applies gate ceilings (G1-G5). A strong score can still be capped by
warn/fail gates.

Why can an informational metric show WARN?
------------------------------------------

Informational metrics still report status to aid interpretation, but they are
excluded from section/core score arithmetic.

Which metrics are informational today?
--------------------------------------

- ``qc_blank_presence``
- ``batch_info_availability``
- ``scale_diagnostics``

How does source-aware missingness work?
---------------------------------------

- datatable: zero treated as valid value
- mwtab / untarg_data / results: zero treated as missing

All sources also treat explicit missing tokens (NA/ND/BDL/etc.), empty strings,
non-finite values, and ``<...`` threshold tokens as missing.

Are QC/blank/pool samples excluded from scoring?
------------------------------------------------

Yes, for metrics where biological-only behavior matters (sample-level
missingness, label suitability, class separability inputs, etc.), QC/blank
samples are excluded using keyword filtering.

How should I interpret class separability?
------------------------------------------

As a diagnostic of label discriminability under a simple linear model.
It is not currently part of core readiness arithmetic and should be interpreted
alongside cohort and analytical diagnostics.

How do I keep docs accurate after metric changes?
-------------------------------------------------

For every logic change:

1. Update metric code.
2. Update UI descriptor/tooltip text if user-facing meaning changed.
3. Update this documentation set (formulas, thresholds, membership, examples).
4. Rebuild docs locally before merging.
