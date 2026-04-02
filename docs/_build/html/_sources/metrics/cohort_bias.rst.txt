Cohort / Bias Metrics
=====================

Section membership
------------------

Cohort section currently scores 3 metrics:

- ``class_balance``
- ``group_size_support``
- ``label_entropy``

Section score is unweighted mean with fixed denominator 3.

1) class_balance
----------------

Purpose
  Quantify imbalance severity via smallest-to-largest class ratio.

Formula

.. math::

   score = \frac{\min(class\ counts)}{\max(class\ counts)}

Special cases

- no valid classes -> score 0.0
- single class only -> score 0.25

Status
  - pass if score >= 0.4
  - warn otherwise

2) group_size_support
---------------------

Purpose
  Ensure smallest class has enough support for stable training/validation.

Tiered scoring by ``min_class_n``:

- >=20 -> 1.0
- 10-19 -> 0.7
- 5-9 -> 0.4
- <5 -> 0.1
- fewer than 2 classes -> 0.0

Status
  - pass if score >= 0.7
  - warn otherwise

3) label_entropy
----------------

Purpose
  Capture distribution evenness across classes using normalized entropy.

Definitions

.. math::

   H = -\sum_i p_i\ln p_i

.. math::

   H_{max} = \ln(K)

.. math::

   score = H/H_{max}

where ``K`` is number of classes.

Status
  - pass if score >= 0.7
  - warn otherwise

Section formula
---------------

.. math::

   cohort\_score = mean(class\_balance,\ group\_size\_support,\ label\_entropy)

Legacy/optional cohort metrics in codebase
------------------------------------------

Additional cohort metrics still exist in module code but are not part of current default section score path:

- ``sample_type_confounding_risk``
- ``age_biological_sex_metadata``
- ``biological_sex_distribution``
- ``sample_matrix_homogeneity``

These can be retained for exploratory diagnostics if explicitly invoked.

Representative UI text
----------------------

- "Cohort section score = mean(class_balance, group_size_support, label_entropy)."
- "Normalized class-distribution entropy (0-1), where H = -sum(p_i ln p_i) and score = H / ln(K)."

