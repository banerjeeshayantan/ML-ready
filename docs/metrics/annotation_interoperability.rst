Annotation / Interoperability Metrics
=====================================

Section membership
------------------

Annotation section includes 4 scored metrics:

- ``feature_annotation_type``
- ``annotation_ambiguity_burden``
- ``unknown_feature_fraction``
- ``feature_redundancy``

Section score is unweighted mean with fixed denominator 4.

Additional metric class in module (not in current default section score):

- ``identifier_coverage``

1) feature_annotation_type
--------------------------

Purpose
  Classify feature naming layer quality and annotation modality.

Counts tracked

- named metabolites
- mz/RT-like tokens
- NMR bins
- unannotated placeholders
- non-metabolite tokens

Tiering rules

- if NMR-bin fraction >= 50% -> score 0.65 (tier ``nmr_binned``)
- else if named fraction >= 70% -> score 1.0 (tier ``named_metabolites``)
- else if named > 0 and (named + mz_rt)/total >= 70% -> score 0.5 (tier ``mixed_mz_rt``)
- else -> score 0.2 (tier ``mostly_unannotated``)

Status
  - pass if score >= 0.65
  - warn otherwise

2) annotation_ambiguity_burden
------------------------------

Purpose
  Penalize unresolved multi-candidate or ambiguous annotations.

Formula

.. math::

   score = 1 - \frac{ambiguous}{total}

Status
  - pass if score >= 0.7
  - warn otherwise

NMR special case
  NMR-binned studies return N/A-style pass behavior (score 1.0) for ambiguity semantics.

3) unknown_feature_fraction
---------------------------

Purpose
  Quantify proportion of unknown/unidentified placeholders.

Formula

.. math::

   score = 1 - \frac{unknown\_features}{total\_features}

Status
  - pass if score >= 0.8
  - warn otherwise

NMR handling
  NMR bins are treated as identified spectral positions, not unknowns.

4) feature_redundancy
---------------------

Purpose
  Detect repeated raw feature names within each assay.

Formula

.. math::

   score = 1 - \frac{redundant}{total}

Where ``redundant`` is sum of ``count-1`` for duplicate raw names within-assay.

Status
  - pass if score >= 0.85
  - warn otherwise

Additional metric class: identifier_coverage
---------------------------------------------

``identifier_coverage`` is implemented in ``merit/metrics/annotation.py`` and
can be run in custom pipelines.

Purpose
  Measure strict external-ID / trusted-namespace coverage.

Rule
  - count as covered if feature has external DB identifier or mapping namespace
    in trusted set (refmet, hmdb, chebi, kegg, pubchem, inchi, inchikey, metlin, lipidmaps)
  - score = covered / total annotations

Status
  - pass if score >= 0.7
  - warn otherwise

NMR handling
  Returns pass-style not-applicable behavior for NMR-binned studies.

Why annotation is core-scored
-----------------------------

MERIT includes annotation in core readiness intentionally:

- interpretability is a primary objective for metabolomics ML,
- weak annotation degrades biological meaning even when predictive modeling is feasible,
- therefore annotation quality is treated as core readiness, not an optional appendix.

Representative UI text
----------------------

- "This section is included in the core ML readiness score because interpretability is a core readiness requirement for metabolomics ML."
- "Named metabolites are preferred for ML interpretability and cross-study reuse."
