# bibhtmlize

`bibhtmlize` is a Ruby wrapper around a deviously hacked [BibTeX](http://www.bibtex.org/) style that generates HTML rather than TeX output.
It reads a BibTeX database file, and produces a sorted list of entries on stdout.

    bibhtmlize foo.bib > foo.partial.html
    
    # add basic <html><head> etc to make a (technically) complete HTML page:
    bibhtmlize --wrap foo.bib > foo.html

See also `bibhtmlize --help`.

### Dependencies

- Ruby and BibTeX (duh)
- sed
- the [cri](http://rubydoc.info/gems/cri/file/README.md) gem

### Disclaimer

I shamelessly took ideas and stuff from [Bibhtml](http://nxg.me.uk/dist/bibhtml/) and from Nicolas Markey's [publist](http://www.lsv.ens-cachan.fr/~markey/BibTeX/publist/), then tweaked a few things to match my bibliography bookkeeping conventions and metadata. I won't pretend it's flexible or useable by anyone else than me, but hey… it's a start.

