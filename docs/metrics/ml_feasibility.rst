ML Feasibility Metrics
======================

Section membership (scored)
---------------------------

Current ML Feasibility section score includes exactly 4 metrics:

1. ``disease_endpoint_extractability``
2. ``factor_label_harmonizability``
3. ``label_suitability``
4. ``feature_to_sample_ratio``

Section score is unweighted mean with fixed denominator 4.

.. math::

   S_{ml\_feasibility} = mean(m_1, m_2, m_3, m_4)

1) disease_endpoint_extractability
----------------------------------

Purpose
  Checks whether sample labels define a usable supervised endpoint.

Inputs
  - Study-level disease field presence
  - Biological-sample labels only
  - Label coverage (valid labels / labeled biological samples)
  - Number of distinct usable groups

Rule (tiered)
  - ``score=0.0, fail`` if disease missing and coverage < 0.5
  - ``score=1.0, pass`` if groups >= 2 and coverage >= 0.8
  - ``score=0.7, warn`` if groups >= 2 and coverage >= 0.5
  - ``score=0.3, warn`` otherwise

Implementation detail
  Also records non-usable label examples with sample IDs, surfaced in recommendations.

2) factor_label_harmonizability
-------------------------------

Purpose
  Measures label quality and factor-string structural complexity.

Formula

.. math::

   score = 0.5 \times label\_quality + 0.5 \times simplicity

Where:
  - ``label_quality`` = fraction of biological samples with non-unknown labels
  - ``simplicity`` is stepwise from average number of ``|`` separators:

    - <1 pipe -> 1.0
    - <2 pipes -> 0.7
    - <3 pipes -> 0.4
    - >=3 pipes -> 0.1

Status
  - pass if score >= 0.75
  - warn otherwise

3) label_suitability
--------------------

Purpose
  Enforces minimum per-class support for supervised classification.

Definitions
  - Let ``min_count`` be configured minimum class count (default 5)
  - Let ``observed_min`` be smallest valid class size

Formula
  - if <2 classes: ``score = 0.0``
  - else: ``score = min(1.0, observed_min / min_count)``

Status
  - pass only when score == 1.0
  - warn otherwise

4) feature_to_sample_ratio
--------------------------

Purpose
  Penalizes high dimensionality relative to available biological samples.

Per-analysis ratio

.. math::

   r_a = \frac{n\_features\_in\_matrix}{n\_samples\_in\_matrix}

Per-analysis ratio score
  - ``r<=10`` -> 1.0
  - ``10<r<=50`` -> 0.8
  - ``50<r<=200`` -> 0.5
  - ``r>200`` -> ``max(0.1, 1 - r/1000)``

Composite
  Sample-weighted mean across analyses:

.. math::

   score = \frac{\sum_a score_a \cdot n\_samples\_in\_matrix(a)}
                 {\sum_a n\_samples\_in\_matrix(a)}

Status
  - pass if score >= 0.8
  - warn otherwise

Current UI subsection layout
----------------------------

ML Feasibility tab renders:

- **Label Usability**
  - disease endpoint extractability
  - factor label harmonizability

- **Core ML Readiness**
  - label suitability
  - feature-to-sample ratio

Related metric classes present in code but excluded from this section score
----------------------------------------------------------------------------

Defined in ``merit/metrics/ml_readiness.py`` but not in current scored membership:

- ``recommended_ml_task``
- ``stratified_split_feasibility``
- ``benchmark_split_leakage_risk``

These can still be used diagnostically in custom runs, but are excluded from
the current readiness section arithmetic.
