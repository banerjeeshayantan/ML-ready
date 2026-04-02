Quickstart
==========

Prerequisites
-------------

- Python 3.10+
- Project checkout at ``/home/shayantan/metabolomics/ML-ready``

Install MERIT runtime dependencies:

.. code-block:: bash

   pip install -e .

Run the UI:

.. code-block:: bash

   merit ui --host 0.0.0.0 --port 8765

Open:

- ``http://localhost:8765`` (local)
- or your server host + port

Run one study via CLI (ingest -> normalize -> assess -> report)
---------------------------------------------------------------

.. code-block:: bash

   merit ingest --source workbench --study-id ST000010 --fetch-mode local --root mw-dump-latest-confirmation-latest-version --output outputs/st000010_bundle.json
   merit normalize --bundle outputs/st000010_bundle.json --output outputs/st000010_canonical.json
   merit assess --bundle outputs/st000010_bundle.json --profile full --output outputs/st000010_assessment.json
   merit report --assessment outputs/st000010_assessment.json --format md --output outputs/st000010_report.md

Build this documentation locally
--------------------------------

Install doc dependencies:

.. code-block:: bash

   pip install -r docs/requirements.txt

Build HTML:

.. code-block:: bash

   make -C docs html

Open:

- ``docs/_build/html/index.html``

ReadTheDocs setup
-----------------

A minimal ``.readthedocs.yaml`` is included at repo root.

To build on ReadTheDocs:

1. Import this repository in ReadTheDocs.
2. Ensure default branch is selected.
3. Confirm the config file is detected.
4. Build and publish.

