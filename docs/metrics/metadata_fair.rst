Metadata / FAIR Metrics
=======================

Section membership
------------------

Metadata section includes 2 scored metrics:

- ``fair_study_metadata_compliance``
- ``fair_metabolite_identifier_resolvability``

Section score is unweighted mean with fixed denominator 2.

Important boundary
------------------

Label-usability metrics are intentionally **not** in this section:

- ``disease_endpoint_extractability``
- ``factor_label_harmonizability``

They are scored under **ML Feasibility**.

1) fair_study_metadata_compliance
---------------------------------

Purpose
  Study-level FAIR-style metadata and documentation compliance.

Binary checks (7)
  - f1_doi_registered
  - r1_2_linked_publication
  - r1_funding_source_declared
  - r1_contributors_listed
  - r1_study_type_declared
  - f2_substantive_description (>=20 words)
  - a1_1_raw_data_format_recorded

Formula

.. math::

   score = \frac{\#\text{passed checks}}{7}

Status
  - pass: score >= 0.8
  - warn: 0.6 <= score < 0.8
  - fail: score < 0.6

2) fair_metabolite_identifier_resolvability
-------------------------------------------

Purpose
  Measure study metabolite interoperability via RefMet linkage (Workbench endpoint path),
  with fallback to trusted mapping namespaces when endpoint rows are unavailable.

Primary path
  Use study ``metabolites`` endpoint rows:

  - ``named_total`` = rows with usable metabolite names
  - ``refmet_matched`` = rows with non-empty ``refmet_name``

Formula (primary path)

.. math::

   score = \frac{refmet\_matched}{named\_total}

Status
  - pass: score >= 0.7
  - warn: 0.5 <= score < 0.7
  - fail: score < 0.5

Fallback path
  Uses annotation + mapping namespaces and trusted IDs:

  - refmet, hmdb, chebi, kegg, pubchem, inchi, inchikey, metlin, lipidmaps

Representative UI text
----------------------

Descriptor examples:

- "Score = passed / 7 binary checks drawn from the study's mwtab metadata."
- "Score = metabolites with a RefMet match / total named metabolites, sourced from the study metabolites endpoint."

Important interpretation note
-----------------------------

This section is reported as **reusability** and is not part of FAIR/label mixing.
Label usability is handled under ML feasibility metrics.
