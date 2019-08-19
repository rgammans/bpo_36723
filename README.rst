Unittest discovery and namespace packages
=========================================

Synopsis
--------

This repository is intended to demonstrate the behaviour of the
test discovery feature of the standard library's unittest module
when the tests are inside namespace packages.

Two simple packages are presents, ``namespace.pkg1`` and ``namespace.pkg2``,
these two packages have test modules in ``test_one.py``, and ``test_two.py``
respectively.

These two packages are stored in two separate directories ``path1``, ``path2``, 
to show that we are making uses of the new layout options afforded by
namespace packages.

This pattern of putting the tests directly inside modules is 
a common pattern in django projects.

Test 1
------

The aim of test on to show that the tests are valid and runnable 
python unittests and that they pass.

We run them by setting our working directory to inside the namespace
package. This means that the discovery process does not need
to traverse a namespace package. This test is run in two halves (a & b)
for two distinct packages in our testing namespace.


Test 2
------

This tests uses PYTHONPATH to join the two directories which contain the
test namespace. This test is run in the root of this repository so
actual paths to the packages under test is relatively symmetrical. The
only asymmetry comes from the order of reference in PYTHONPATH.

Before running the main tests we ensure the two packages which contain
the tests are importable via the standard python module loading machinery.
A warning is printed if this is not the case.


Test 3
------

This test is run in two part, the aim here is to ensure any that both
symmetries are tested.

This test is intended to show a more realistic example of where such
a namespace might be encoutered. Here we run the tests in the same
two directories as we did in tests 1a & 1b, but here  we ensure the 
other namespace directory is the python import path.
