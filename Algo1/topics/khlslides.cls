\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{khlslides}[16/05/2014]
\LoadClass{beamer}

\usepackage{graphicx}
\usepackage{pxfonts}
\usepackage{tikz}
\usepackage{calc}
\usepackage{listings}
\usepackage{booktabs}
\usepackage{url}
\usepackage{framed}
\usepackage{hyperref}
\usepackage{cleveref}

\usetikzlibrary{shadows,calc}


\mode<presentation>
\usetheme[height=.75cm]{Rochester}
% \setbeamertemplate{background canvas}[vertical shading][top=blue!10,bottom=blue!30]

\institute[KHL]{KHLeuven}
\logo{\includegraphics[height=0.5cm]{../KHL.jpg}}



\lstdefinelanguage{JavaScript}{
  keywords={typeof, new, true, false, catch, function, return,
            null, catch, switch, var, if, in, for, while, do, else, case, break},
  keywordstyle=\color{blue}\bfseries,
  ndkeywords={class, export, boolean, throw, implements, import, this},
  ndkeywordstyle=\color{darkgray}\bfseries,
  identifierstyle=\color{black},
  sensitive=false,
  comment=[l]{//},
  morecomment=[s]{/*}{*/},
  commentstyle=\color{purple}\ttfamily,
  stringstyle=\color{red}\ttfamily,
  morestring=[b]',
  morestring=[b]",
  escapeinside=\`\`
}

\lstdefinelanguage{HTML}[]{generic}{
    morecomment = [l]{//},
    morecomment = [l]{///},
    morecomment = [s]{/*}{*/},
    morestring=[b]",
    sensitive = true,
    captionpos=b,
    morekeywords = {html, head, body, script, title}
}


% Code formatting
\pgfkeys{
  /khl/code/.cd,
  frame/.code=\lstset{frame=#1},
  font size/.code=\lstset{basicstyle={\ttfamily #1}},
}

\lstset{language=JavaScript,frame=lines}

\newcommand{\code}[2][]{
  {
    \pgfkeys{/khl/code/.cd,#1}
    \begin{tabular}{c}
      \lstinputlisting{#2}
    \end{tabular}
  }
}


% Tikz related commands
\newcommand{\NODE}[2]{\tikz[baseline,remember picture]{\node[anchor=base,inner sep=0mm] (#2) {{#1}};}}
\newcommand{\COORD}[1]{\tikz[baseline=-.5cm,remember picture]{\coordinate (#1);}}


\newcommand{\toc}{
  \begin{frame}
    \tableofcontents[sectionstyle=show/shaded,subsectionstyle=show/shaded/hide]
  \end{frame}
}


\setbeamertemplate{title page}{%
  \begin{center}
    Algoritmen en Datastructuren 1 \\[5mm]
    {\sc\Huge \inserttitle}
  \end{center}
}