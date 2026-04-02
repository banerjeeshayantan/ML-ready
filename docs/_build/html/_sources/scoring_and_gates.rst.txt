Scoring Framework and Gates
===========================

High-level design
-----------------

MERIT reports two top-level scores:

- **Core ML readiness score**
- **Reusability score** (FAIR metadata-oriented)

It also reports:

- **Provisional band** (from core score)
- **Final band** (after applying feasibility-gate ceilings)

Section score computation
-------------------------

Section scores are computed as mean of non-informational metrics within section.

From ``merit/readiness_score.py``:

.. math::

   \text{section\_score} = \frac{\sum m_i}{\max(N_{\text{non-info}}, N_{\text{fixed}})}

Where:

- ``m_i`` are metric scores in that section with ``informational=False``
- ``N_fixed`` is the section's fixed denominator configured in ``_SECTION_METRIC_COUNTS``

Current fixed section counts
----------------------------

- structural: 5
- metadata: 2
- analytical: 5
- annotation: 4
- cohort: 3
- ml_feasibility: 4

Core and reusability aggregation
--------------------------------

Core score uses unweighted mean of these sections:

- structural
- analytical
- annotation
- cohort
- ml_feasibility

.. math::

   \text{core\_ml\_readiness\_score} = \frac{S_{struct}+S_{analytical}+S_{annotation}+S_{cohort}+S_{ml}}{5}

Reusability score currently uses metadata section only:

.. math::

   \text{reusability\_score} = S_{metadata}

Band thresholds
---------------

From ``_band_from_score``:

- Ready: score >= 0.85
- Conditional: score >= 0.70
- Fragile: score >= 0.50
- Not Ready: score < 0.50

Feasibility gates (G1-G5)
--------------------------

Gates are computed separately and are **not** part of score arithmetic.

- **G1 tabular_data_availability**: at least one usable matrix required
- **G2 sufficient_biological_sample_count**: preferred >= threshold (default 20)
- **G3 deposited_groups**: >=2 distinct label groups
- **G4 minimum_per_group_support**: minimum class support from label suitability details
- **G5 non_catastrophic_missingness**: based on median sample-level missingness

Gate ceiling logic
------------------

Final band is capped by gate statuses:

- If G1 fails -> final band = ``No Data``
- Else if any gate fails -> ceiling ``Not Ready``
- Else if any gate warns -> ceiling ``Conditional``
- Else -> no ceiling

So:

.. math::

   \text{final\_band} = \min(\text{provisional\_band},\ \text{gate\_ceiling})

(with band rank ordering)

Why annotation is in core score
-------------------------------

MERIT intentionally includes annotation in core score.

Rationale in code comment:

- training can occur without strong annotation,
- but scientific interpretability and downstream biological utility are materially degraded,
- so annotation is treated as a core readiness dimension, not optional decoration.

Informational metrics
---------------------

Some metrics are explicitly informational and excluded from core section arithmetic:

- ``qc_blank_presence``
- ``batch_info_availability``
- ``scale_diagnostics``

These still render in UI and provide operational guidance.

