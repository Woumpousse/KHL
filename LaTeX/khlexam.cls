\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{khlexamen}[04/07/2014]
\LoadClass{scrartcl}

\RequirePackage{a4wide}
\RequirePackage[headheight=140pt,top=200pt]{geometry}
%\RequirePackage[headheight=40pt]{geometry}
\RequirePackage{scrpage2}
\RequirePackage{afterpage}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{graphicx}
\RequirePackage{multirow}
\RequirePackage{microtype}
\RequirePackage{lastpage}
\RequirePackage{tikz}
\RequirePackage[utf8]{inputenc}

\makeatletter

\newpagestyle{exampage}{%
  {\smallheader@produce}%
  {\smallheader@produce}%
  {\smallheader@produce}
  (\textwidth,1pt)
}{%
  {L}%
  {R}%
  {\normalfont\rlap{\exam@datum} \hspace{\fill} pagina \thepage\ van \pageref{LastPage} \hspace{\fill} \llap{KHLeuven}}%
}

\newpagestyle{firstexampage}{%
  {\header@produce}%
  {\header@produce}%
  {\header@produce}
  (\textwidth,1pt)
}{%
  {L}%
  {R}%
  {\normalfont\rlap{\exam@datum} \hspace{\fill} pagina \thepage\ van \pageref{LastPage} \hspace{\fill} \llap{KHLeuven}}%
}

% \pagestyle{exampage}

\pagestyle{firstexampage}


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
  \footnotesize\normalfont%
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
  \footnotesize\normalfont\hspace*{\fill}
  \begin{tabular}{rlr}
    OLA: & \exam@ola  & \\
    Datum: & \exam@datum &  \\[2mm]
    Student: & \multicolumn{2}{l}{\fillindots{9cm} \hspace{1mm} \hspace{1mm} Reeks: \fillindots{1cm}}
 \end{tabular}\hspace*{\fill}%
}

\makeatother

\newcommand{\figuur}[1]{\includegraphics[width=.9\linewidth]{#1}}

\newcounter{questioncounter}
\newenvironment{question}[1][]{
  \begin{minipage}{\linewidth}
    \textsc{\Large Vraag \stepcounter{questioncounter}\arabic{questioncounter}} \\[2mm]}
{
  \end{minipage} \vspace{2mm}
}

% \AtBeginDocument{
%   \setlength{\headheight}{140pt}
%   \thispagestyle{firstexampage}
%   \afterpage{\global\setlength{\headheight}{40pt}}
% }
