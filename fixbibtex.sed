#!/usr/bin/sed -f

# Remove %\n line-breaks added by BibTeX
/% *$/{
  :a
  N
  s/% *\n//
  t a
}

# Process DOI:{...} lines, escaping '<' characters in DOIs and rearranging into a <a> element
# (the substitutions below probably rely on the "DOI:" being at the beginning of a line).
# First, turn DOI:{X} into DOI:{X|X}
/^DOI/s,DOI:{\([^}]*\)},DOI:{\1|\1},
# Escape the two DOIs differently...
#    ...first do URL escaping
#    ...then do HTML/XML escaping
/^DOI:/{
  :bx
  s,\([^<|]*\)<\([^|]*\)|,\1%3C\2|,
  t bx
  :cx
  s,\([^<}]*\)<\([^}]*\)},\1\&lt;\2},
  t cx
}
# ...and then turn the result into a <a> element
/^DOI:{/s,DOI:{\([^|]*\)|\([^}]*\)},DOI:\&nbsp;<a href='http://dx.doi.org/\1'><code>\2</code></a>,

# Get rid of TeX braces (I hope there aren't any of these in DOIs or other URLs)
s/[{}]//g

# Replace '~' ties with spaces, as long as they aren't URL ".../~user"
s_\([^/]\)~_\1\&nbsp;_g

s/\\%/%/g
s/---/\&mdash;/g
s/--/\&ndash;/g
