\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{khltoets}[12/10/2013]

\long\def\BEGINSOLUTION#1\ENDSOLUTION{}
\DeclareOption{solution}{\long\def\BEGINSOLUTION#1\ENDSOLUTION{\begin{center}\solutionframe{\begin{center}\begin{minipage}{.90\textwidth}\toggletrue{solutionmode}#1\togglefalse{solutionmode}\end{minipage}\end{center}}\end{center}}}

\ProcessOptions\relax

\LoadClass{article}

\RequirePackage{a4wide}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{graphicx}
\RequirePackage{listings}
\RequirePackage{pxfonts}
\RequirePackage[framemethod=tikz]{mdframed}
\RequirePackage{tikz}
\RequirePackage{etoolbox}

\usetikzlibrary{calc,decorations.pathmorphing,patterns,mindmap,shapes.arrows,shapes,shadings,arrows,automata,positioning,shadows}

\pagestyle{empty}

\newcommand{\HEADER}[3]{
\begin{center}
\begin{tabularx}{\textwidth}{Xc}
  \toprule
  \parbox[c]{\linewidth}{\sc{\Large#1} \\ {#2} } & \parbox[c]{1.5in}{\includegraphics[width=1.5in]{KHL.jpg}} \\
  \midrule
  \parbox[c]{\linewidth}{\sc\large \vskip1mm Naam:\\Datum:\\Reeks:\vskip2mm} & \parbox[c]{1.5in}{\Huge\bf\hfill /#3} \\
  \bottomrule
\end{tabularx}
\end{center}
}

\lstdefinelanguage{MyJava}[]{java}{
  escapechar=@,%
  basicstyle={\ttfamily},%
  keywordstyle={\ttfamily\bfseries},%
  commentstyle={\it},%
  frame=lines,%
  captionpos=b,%
}

\newcommand{\INLINECODE}[2][]{
  \begin{center}
    \begin{minipage}{.95\linewidth}
      \lstinputlisting[language=MyJava,#1]{#2}
    \end{minipage}
  \end{center}
}


\newtoggle{solutionmode}

\newcommand{\HOLE}[1]{
%  \iftoggle{solutionmode}{\framebox[2cm]{#1}}{\framebox[2cm]{\phantom{A}}}
  \iftoggle{solutionmode}{\framebox{#1}}{\rule{1.5cm}{.2pt}}
}

\newcommand{\HIGHLIGHT}[1]{\iftoggle{solutionmode}{\framebox{#1}}{#1}}
\newcommand{\CORRECT}[2]{\iftoggle{solutionmode}{\framebox{#2}}{#1}}


\mdfdefinestyle{assignmentframestyle}{innerleftmargin=5mm,innerrightmargin=5mm,innertopmargin=5mm,innerbottommargin=5mm,roundcorner=10pt,frametitle={Opgave},nobreak=true}
\mdfdefinestyle{solutionframestyle}{innerleftmargin=5mm,innerrightmargin=5mm,innertopmargin=5mm,innerbottommargin=5mm,roundcorner=10pt,frametitle={Oplossing},nobreak=true}

\newcommand{\assignmentframe}[1]{\begin{mdframed}[style=assignmentframestyle]#1\end{mdframed}}
\newcommand{\solutionframe}[1]{\begin{mdframed}[style=solutionframestyle]#1\end{mdframed}}

\long\def\BEGINASSIGNMENT#1\ENDASSIGNMENT{\begin{center}\assignmentframe{\begin{center}\begin{minipage}{.90\textwidth}#1\end{minipage}\end{center}}\end{center}}

% Placeholder to be used in tikz pictures
\newcommand{\PH}[2]{\tikz[baseline,remember picture]{ \node[anchor=base,inner sep=0mm] (#2) { #1 }; }}

% Used to draw overlays
\newenvironment{overlay}[1][]{\begin{tikzpicture}[overlay,remember picture,#1]}{\end{tikzpicture}}

\newcommand{\highlight}[1]{
  \draw[fill=red,opacity=0.5] ($ (#1.south west) - (0.1,0.1) $) rectangle ($ (#1.north east) + (0.1,0.1) $);
}

\newcommand{\correction}[3][(0.5,0.5)]{
  \draw[red, ultra thick] ($ (#2.south west) - (0.1,0.1) $) -- ($ (#2.north east) + (0.1,0.1) $);
  \node[fill=red,opacity=0.5,text opacity=1] (correction #2) at ($ (#2) + #1 $) {{\small #3}};
  \draw[->] (correction #2) -- (#2);
}

