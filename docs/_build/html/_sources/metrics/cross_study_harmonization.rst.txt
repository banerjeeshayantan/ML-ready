Cross-Study Harmonization Metrics
=================================

Scope
-----

These metrics summarize how easily a study could be integrated into
cross-study analyses.

Current default profile behavior
--------------------------------

These metrics are part of the metric registry but are not used in current core
or reusability composite readiness scores.

1) harmonization_feasibility
----------------------------

Purpose
  Composite proxy for label harmonizability, identifier mapping, and platform definition.

Components

- ``label_ratio`` = fraction of samples with normalized label != unknown
- ``mapping_ratio`` = fraction of annotations with non-empty mapped reference ID
- ``platform_defined`` = 1 if platform field exists else 0

Formula

.. math::

   score = 0.4\times label\_ratio + 0.4\times mapping\_ratio + 0.2\times platform\_defined

Status
  - pass if score >= 0.7
  - warn otherwise

2) pathway_mappability_proxy
----------------------------

Purpose
  Namespace-level proxy for pathway mapping readiness.

Logic

- Count mapping namespaces in ``study.mappings``
- Recognized namespaces: ``chebi, hmdb, kegg, refmet, lexical``

Formula

.. math::

   score = \frac{recognized\ mappings}{total\ mappings}

Status
  - pass if score >= 0.75
  - warn otherwise

Interpretation caveat
---------------------

These are practical proxies, not pathway-quality guarantees. They indicate
namespace readiness for downstream pathway tooling, not biological correctness.
