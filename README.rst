Assembly laboratory project
========

It finds the number of paths of given length k between two nodes in a directed graph by matrix exponentiation.

Syntax
------
AT&T Assembly Syntax

Presentation of the project theme
---------------------------------

.. image:: https://github.com/omacelaru/Assembly-laboratory-project/blob/master/images/tema.png
   :alt: Tema

.. image:: https://github.com/omacelaru/Assembly-laboratory-project/blob/master/images/cerinta_1.png
   :alt: Cerinta 1

.. image:: https://github.com/omacelaru/Assembly-laboratory-project/blob/master/images/cerinta_2.png
   :alt: Cerinta 2

How to run
------------

The command you use to get the executable.

.. code-block:: console

    gcc -m32 matrix_multiplication.s -o matrix_multiplication -no-pie

For the first request use the command

.. code-block:: console

    ./matrix_multiplication < input1.in

For the second request use the command

.. code-block:: console

    ./matrix_multiplication < input2.in
