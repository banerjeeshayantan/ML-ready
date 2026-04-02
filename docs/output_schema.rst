Output Schema and Interpretation
================================

Assessment report file
----------------------

Primary assessment object: ``AssessmentReport``.

Top-level fields:

- ``source``
- ``ingestion_summary``
- ``schema_validation``
- ``metadata_readiness``
- ``analytical_readiness``
- ``annotation_readiness``
- ``cohort_bias``
- ``ml_readiness``
- ``class_separability``
- ``cross_study_harmonization``
- ``remediations_applied``
- ``software_versions``
- ``content_hash``

Metric result object
--------------------

Each metric entry is ``MetricResult``:

- ``family``
- ``name``
- ``score``
- ``status``
- ``summary``
- ``details``
- ``thresholds``
- ``recommendations``
- ``informational``

Readiness score payload
-----------------------

``compute_readiness_score()`` returns a dictionary containing:

- ``score`` (alias of core score)
- ``band`` (alias of final band)
- ``core_ml_readiness_score``
- ``reusability_score``
- ``provisional_band``
- ``final_band``
- ``gate_ceiling``
- ``gates``
- ``gate_summary``
- ``section_scores``
- ``core_section_scores``
- ``reusability_section_scores``
- ``recommendation``
- ``actions``
- ``status_note``

Meaning of key fields
---------------------

``provisional_band``
  Band from core score before applying gate ceilings.

``final_band``
  Band after gate ceiling application.

``gate_ceiling``
  ``None``, ``Conditional``, ``Not Ready``, or ``No Data`` depending on gate outcomes.

``actions``
  Auto-generated prioritization hints based on weak sections and gate outcomes.

``informational`` metrics
-------------------------

If ``informational=True``, the metric:

- appears in UI,
- keeps summary/details/recommendations,
- does **not** contribute to section readiness arithmetic.

