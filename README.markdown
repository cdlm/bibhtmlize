# bibhtmlize

`bibhtmlize` is a Ruby wrapper around a rather deviously hacked [BibTeX style that generates HTML][bibhtml] rather than TeX output.
It reads a [BibTeX database file](http://www.bibtex.org/), and produces a sorted list of entries on stdout.

Most common use case, for inclusion in a larger web page:

    bibhtmlize foo.bib > foo.partial.html
    
To add `<html><head>` etc. and produce a very basic but technically complete HTML document:

    bibhtmlize --wrap foo.bib > foo.html

The default BibTeX style classifies entries per publication type (journals, conferences, workshops, etc) as is usual for someone's list of scientific publications. That can be changed by using a different style, e.g. the original one from [Bibhtml][]:

    bibhtmlize --style plainhtml foo.bib > foo.html

See also `bibhtmlize --help`.

### Dependencies

- Ruby and BibTeX (duh)
- sed
- the [cri](http://rubydoc.info/gems/cri/file/README.md) gem

### Disclaimer

I shamelessly took ideas and code from a couple other cool projects:

- [Norman Gray's Bibhtml][bibhtml] for making BibTeX output HTML rather than `.bbl`, and
- [Nicolas Markey's `publist`](http://www.lsv.ens-cachan.fr/~markey/BibTeX/publist/) for classifying publications by type.

On top of that I tweaked a few things to match my bibliography bookkeeping conventions and metadata.
I won't pretend it's flexible or useable by anyone else than me, but hey… it's a start.

[bibhtml]: http://purl.org/nxg/dist/bibhtml

