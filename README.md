SQLAnywhere-connection-string
=============================

Parse SQLAnywhere connection strings to a hash, and create connection strings from hashes.

SQLAnywhere using a connection string for specifying options when connecting to a database.
ActiveRecord (generally) uses a hash.
This library will translate from one to the other.

Rationale
---------

There are a couple SQLAnywhere Activerecord drivers with different but related code bases.
I figured it would be helpful to start sharing some of the common code.

This seems like quite a simple thing to test, and I want to try out TDD.

SQLAnywhere Documentation
-------------------------

[Connection parameter overview with list of parameters](http://dcx.sybase.com/1200/en/dbadmin/da-conparm.html)

[Connection parameter syntax rules](http://dcx.sybase.com/1200/en/dbadmin/da-dbconnections-s-4083642.html)
