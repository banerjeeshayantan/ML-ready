MERIT Documentation
===================

This documentation is the implementation-level reference for **MERIT**
(MachinE learning ReadIness for Tabular metabolomics data).

Scope
-----

This guide is intentionally detailed and code-aligned. It covers:

- End-to-end pipeline and data model
- Every scoring section and every metric currently implemented
- Exact formulas, thresholds, and section aggregation behavior
- Gate logic (G1-G5), provisional vs final banding, and gate ceilings
- UI output semantics, including examples of descriptor/tooltip text
- Practical usage for CLI, UI, and reproducible assessment runs

Read this in order if you are new to MERIT.

.. toctree::
   :maxdepth: 2
   :caption: Core Guide

   quickstart
   pipeline_and_data_model
   scoring_and_gates
   output_schema
   ui_text_and_tooltips
   faq

.. toctree::
   :maxdepth: 2
   :caption: Metric Reference

   metrics/index
