Structural Metrics
==================

Section membership
------------------

Structural section includes 5 scored metrics:

- ``schema_integrity``
- ``tabular_data_availability``
- ``required_field_completeness``
- ``duplicate_entities``
- ``minimum_sample_count``

Section score is unweighted mean with fixed denominator 5.

1) schema_integrity
-------------------

Family: Structural

Purpose
  Validate the presence of five mandatory top-level components.

Checks
  ``study_id``, ``title``, ``samples``, ``assays``, ``feature_matrices``

Formula

.. math::

   score = \frac{\#\text{passed checks}}{5}

Status
  - pass: score == 1.0
  - warn: score >= 0.6
  - fail: score < 0.6

2) tabular_data_availability
----------------------------

Purpose
  Verify that assay matrices actually contain usable tabular content.

Per-matrix usable condition
  matrix has non-empty ``sample_ids``, ``feature_ids``, and ``values``.

Formula

.. math::

   score = \frac{\#\text{matrices with usable data}}{\#\text{matrices}}

Status
  - pass: at least one usable matrix
  - fail: no usable matrices

3) required_field_completeness
------------------------------

Purpose
  Combine study-level field completeness and sample-level field coverage.

Study-level subscore checks (6 fields)
  title, description, organism, disease, analysis_type, platform

Sample-level coverage
  label, sample_type, organism over all samples

Formula

.. math::

   score = 0.5 \times study\_score + 0.5 \times sample\_score

Status
  - pass: score >= 0.85
  - warn: otherwise

4) duplicate_entities
---------------------

Purpose
  Detect duplicate sample IDs and duplicate feature IDs.

Formula

.. math::

   score = \max\left(0, 1 - \frac{total\_duplicates}{n\_samples + n\_features}\right)

Status
  - pass: ``total_duplicates == 0``
  - warn: otherwise

5) minimum_sample_count
-----------------------

Purpose
  Quantify whether biological sample count is sufficient for baseline ML.

Biological sample filter
  Excludes rows identified as QC/blank/pool/reference by keyword logic.

Threshold
  ``THRESHOLD = 20``

Formula

.. math::

   score = \min\left(1, \frac{n_{bio}}{20}\right)

Status
  - pass: ``n_bio >= 20``
  - warn: otherwise

Representative UI text
----------------------

Example descriptor text:

- "Counts biological samples after excluding QC pools, blanks, NIST references, and other non-biological rows. Minimum threshold: 20."

Example recommendation text:

- "Fewer than 20 biological samples detected. ML models may be unreliable at this scale."

