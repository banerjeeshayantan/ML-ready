Pipeline and Data Model
=======================

Pipeline overview
-----------------

MERIT evaluates each study through a deterministic sequence:

1. ``create_bundle()`` (connector stage)
2. ``normalize_bundle()`` (canonical schema conversion)
3. ``assess_study()`` (metric execution by family)
4. ``compute_readiness_score()`` (section scores + gates + final bands)
5. UI rendering (overview + section tabs + per-analysis diagnostics)

Multi-source behavior
---------------------

For Workbench studies, MERIT runs source-specific assessments independently:

- ``datatable`` (Tier 1)
- ``mwtab`` (Tier 1)
- ``untarg_data`` (Tier 2)

Source priority used for primary rendering/output is:

``datatable > mwtab > untarg_data``

Source-aware zero handling
--------------------------

A core design decision in analytical metrics:

- ``datatable``: zero is treated as valid structural fill
- ``mwtab``, ``untarg_data``, ``results``: zero is treated as missing/below-detection

This behavior is implemented in analytical metrics via:

- ``_source_kind_counts_zero(source_kind)``
- ``_is_missing(value, count_zero=...)``

Canonical data model
--------------------

The central dataclass is ``CanonicalStudy`` in ``merit/models.py``.

Key nested records:

- ``StudyRecord``: study-level metadata
- ``SampleRecord``: sample rows and attributes
- ``AssayRecord``: assay metadata
- ``FeatureMatrix``: tabular data used by analytical and ML metrics
- ``MetaboliteAnnotationRecord``: feature naming/annotation layer
- ``MappingRecord``: namespace mapping/interoperability info

FeatureMatrix
-------------

``FeatureMatrix`` fields that directly drive scoring:

- ``sample_ids``
- ``feature_ids``
- ``values``
- ``labels``
- ``source_kind``

``source_kind`` controls source-aware missingness semantics in analytical metrics.

Assessment report object
------------------------

``assess_study()`` returns ``AssessmentReport`` with section arrays:

- ``schema_validation``
- ``metadata_readiness``
- ``analytical_readiness``
- ``annotation_readiness``
- ``cohort_bias``
- ``ml_readiness``
- ``class_separability``
- ``cross_study_harmonization``

Each metric is a ``MetricResult`` with:

- ``score``
- ``status`` (pass/warn/fail)
- ``summary``
- ``details`` (structured payload used by UI)
- ``thresholds``
- ``recommendations``
- ``informational`` (excluded from composite readiness score)

