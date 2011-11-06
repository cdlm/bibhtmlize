#!/usr/bin/env ruby

HTML_PRE = <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <body>
EOF

HTML_POST = <<-EOF
    </body>
</html>
EOF

def message(str)
  $stderr.puts str unless $quiet
end

require "Getopt/Declare"
$wrap = false
$clean = true
$bibfiles = []
$bibstyle = 'plainhtml'
$quiet = false

args = Getopt::Declare.new <<-EOF
Converts BibTeX to HTML (on standard output)

  -w[rap]             Wrap generated html in a full page (header/footer)
    { $wrap = true }
  
  -k[eep]             Keep intermediary file when finished
    { $clean = false }
  
  -s[tyle] <bibstyle> BibTeX style file (defaults to plainhtml.bst)
    { $bibstyle = bibstyle }
  
  <bibfile>...        BibTeX database(s) [required]
    { $bibfiles = bibfile }

  -q                  Quiet
    { $quiet = true }
EOF

AUX = 'tmp.htmlize.aux'
BBL = 'tmp.htmlize.bbl'
File.open(AUX, 'w') do |aux|
  message "Generating .aux file..."
  $bibfiles.each do |each|
    aux.puts "\\bibdata{#{each}}"
  end
  aux.puts "\\bibstyle{#{$bibstyle}}"
  aux.puts "\\citation{*}"
end

message "Running BibTeX on #{AUX}..."
system "bibtex #{AUX} >&2"

message "Fixing up the HTML..."
$stdout.write(HTML_PRE) if $wrap
system "sed -f fixbibtex.sed #{BBL}"
$stdout.write(HTML_POST) if $wrap

if $clean
  message "Cleaning up..."
  File.delete(AUX) if File.file?(AUX)
  File.delete(BBL) if File.file?(BBL)
end
