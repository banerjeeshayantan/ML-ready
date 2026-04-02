UI Text and Tooltip Reference
=============================

Purpose
-------

This page documents representative descriptor/tooltip text currently rendered by
MERIT UI, aligned with ``merit/ui.py``.

Overview panel text
-------------------

Examples:

- ``Core ML readiness = mean(Structural, Analytical QC, Annotation, Cohort/Bias, ML Feasibility). Reusability score = Metadata / FAIR only.``
- ``Core ML readiness is computed from five core sections (excluding Metadata / FAIR), while Reusability reports FAIR-oriented reuse evidence separately.``
- ``No gate ceiling applied.`` or gate warning/fail notes depending on G1-G5.

Gate labels shown in overview
-----------------------------

- G1 tabular data availability
- G2 sufficient biological sample count
- G3 deposited groups
- G4 minimum per group support
- G5 non catastrophic missingness

Analytical QC text examples
---------------------------

Sample-level missingness tooltip includes:

- Source-aware zero handling statement:
  ``datatable zeros are treated as valid (curated structural fill); mwTab/untarg_data zeros are treated as missing (below detection).``
- Scoring statement:
  ``Per-analysis score = 1 − median(per-sample missingness rates); aggregate = mean of per-analysis scores.``

Assay platform comparability tooltip includes:

- Spread definition:
  ``spread = max(per-analysis log10 median) − min(per-analysis log10 median)``
- Score formula:
  ``score = 1 / (1 + spread)``
- Positive values definition:
  ``Positive values = matrix cells used for this metric after filtering to values that are (1) not missing or non-finite and (2) strictly greater than 0.``

Scale diagnostics descriptor includes:

- Inference note that diagnostic status is distribution-derived (min/median/p90/max)
- Explicit statement that it is informational only and excluded from readiness score

Outlier burden explanatory text includes
----------------------------------------

- ``outlier_rate = n_outlier_values / n_values × 100``
- ``n_values`` means usable (finite, non-missing) values for that feature in that analysis

ML Feasibility tooltips
-----------------------

Feature-to-sample ratio tooltip exposes:

- total features and biological samples
- global F:S ratio
- median per-analysis p:n ratio
- percentage of analyses with features > samples
- per-analysis ratio lines

Cohort/Bias tooltip examples
----------------------------

Label entropy tooltip contains the explicit formula:

.. math::

   H = -\sum_i p_i\ln p_i,\quad score = H/\ln(K)

and class-count snapshots used in entropy interpretation.

Informational-only badge behavior
---------------------------------

Metrics flagged ``informational=True`` render with a red
``informational only`` chip and the note:

``This metric is informational only and is not included in the readiness score.``

Current informational metrics:

- ``qc_blank_presence``
- ``batch_info_availability``
- ``scale_diagnostics``

Maintaining sync between docs and UI strings
--------------------------------------------

When modifying UI copy in ``merit/ui.py``, update this file in the same pull
request so users and maintainers can map exact output text to current logic.
