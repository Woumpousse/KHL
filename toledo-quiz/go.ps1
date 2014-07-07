param([Parameter(Mandatory=$true)][String]$Name,
      [Switch]$Convert,
      [Switch]$NoTeX)

ruby "$Name.rb" | out-file -encoding ascii -filepath "temp.tex"

if ( -not $NoTeX ) {
   pdflatex "temp.tex"
}

if ( $Convert ) {
   convert -density 200 -quality 85 -trim "temp.pdf" "$Name-%d.png"
}
