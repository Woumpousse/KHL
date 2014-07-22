foreach ( $file in get-childitem *.uml.tex ) {
    $base = $file.BaseName

    pdflatex $file
    convert -quality 90 -density 300 -trim "$base.pdf" "$base.png"
}