param([Parameter(Mandatory=$true)][String]$Name,
      [Switch]$Convert)

ruby "$Name.rb" | out-file -encoding ascii -filepath "temp.tex"
pdflatex "temp.tex"

if (($Convert)) {
   convert -density 200 -quality 85 -trim "temp.pdf" "$Name-%d.png"
}
