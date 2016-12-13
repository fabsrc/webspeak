Webspeak
========

An online dictionary for all the important terms of the web world. Also: literal translations of terms into other languages.

Requirements
------------

* Ruby `2.2.0`
* Rails `4.1.6`
* Elasticsearch

Install
-------

```bash
$ bundle update
$ bundle install
```

Setup
-----

```bash
$ rake db:migrate
$ rake db:seed
$ rake searchkick:reindex:all
```

Start
-----

```bash
$ rails s
```

Note
----

This project was created for the *Backend Engineering* class at the FH-Salzburg in the winter term of 2014.