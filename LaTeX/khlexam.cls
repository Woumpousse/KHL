\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{khlexamen}[04/07/2014]
\LoadClass{scrartcl}

\RequirePackage{a4wide}
\RequirePackage[headheight=40pt]{geometry}
\RequirePackage{scrpage2}
\RequirePackage{afterpage}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{graphicx}
\RequirePackage{multirow}
\RequirePackage{microtype}
\RequirePackage{lastpage}
\RequirePackage{tikz}

\makeatletter

\newpagestyle{exampage}{%
  {\smallheader@produce}%
  {\smallheader@produce}%
  {\smallheader@produce}
  (\textwidth,1pt)
}{%
  {L}%
  {R}%
  {\rm\rlap{\exam@datum} \hspace{\fill} pagina \thepage\ van \pageref{LastPage} \hspace{\fill} \llap{KHLeuven}}%
}

\newpagestyle{firstexampage}{%
  {\header@produce}%
  {\header@produce}%
  {\header@produce}
  (\textwidth,1pt)
}{%
  {L}%
  {R}%
  {\rm\rlap{\exam@datum} \hspace{\fill} pagina \thepage\ van \pageref{LastPage} \hspace{\fill} \llap{KHLeuven}}%
}


\pagestyle{exampage}



\pgfkeys{
  /exam/.cd,
  academiejaar/.store in=\exam@academiejaar,
  opleiding/.store in=\exam@opleiding,
  fase/.store in=\exam@fase,
  examinator/.store in=\exam@examinator,
  opo/.store in=\exam@opo,
  ola/.store in=\exam@ola,
  activiteit/.store in=\exam@activiteit,
  hulpmiddelen/.store in=\exam@hulpmiddelen,
  datum/.store in=\exam@datum,
  beginuur/.store in=\exam@beginuur,
  duur/.store in=\exam@duur
}


\newcommand{\fillindots}[1]{\makebox[#1]{\dotfill}}
\newcommand{\exam}[1]{\pgfkeys{/exam/.cd,#1}}



\newcommand{\header@produce}{%
  \rm\footnotesize%
  \begin{tabular}{rlr}
    Academiejaar: & \exam@academiejaar & \multirow{4}{2cm}[0mm]{\includegraphics[width=3cm]{logoGT.pdf}} \\
    Opleiding: & \exam@opleiding  & \\
    Fase: & \exam@fase  & \\
    Examinator: & \exam@examinator  & \\
    OPO: & \exam@opo  & \\
    OLA: & \exam@ola  & \\
    Activiteit:& \exam@activiteit &\\
    Hulpmiddelen: &\exam@hulpmiddelen & \\ 
    Datum: & \exam@datum &  \\
    Beginuur: & \exam@beginuur & \\
    Tijdsduur: & \exam@duur  & \\ \\
    Student: & \multicolumn{2}{l}{\fillindots{5cm} \hspace{1mm} Nummer: \fillindots{2cm} \hspace{1mm} Reeks: \fillindots{1cm}}
  \end{tabular}%
}

\newcommand{\smallheader@produce}{
  \footnotesize\rm\hspace*{\fill}
  \begin{tabular}{rlr}
    OLA: & \exam@ola  & \\
    Datum: & \exam@datum &  \\[2mm]
    Student: & \multicolumn{2}{l}{\fillindots{9cm} \hspace{1mm} \hspace{1mm} Reeks: \fillindots{1cm}}
 \end{tabular}\hspace*{\fill}%
}

\makeatother


\AtBeginDocument{
  \setlength{\headheight}{140pt}
  \thispagestyle{firstexampage}
  \afterpage{\global\setlength{\headheight}{40pt}}
}
