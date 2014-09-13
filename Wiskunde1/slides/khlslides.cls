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

\usetikzlibrary{shadows,calc,shapes}


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
  stringstyle=\color{black}\ttfamily,
  basicstyle=\tt,
  morestring=[b]',
  morestring=[b]",
  escapeinside=\`\`,
  showstringspaces=false,
}

\lstdefinelanguage{HTML}{
    morecomment = [l]{//},
    morecomment = [l]{///},
    morecomment = [s]{/*}{*/},
    morestring=[b]",
    sensitive = true,
    morekeywords = {html,head,body,script,title,h1,h2,p,a,b,i,link}
}


\lstdefinelanguage{CSS}{
  morekeywords={accelerator,azimuth,background,background-attachment,
            background-color,background-image,background-position,
            background-position-x,background-position-y,background-repeat,
            behavior,border,border-bottom,border-bottom-color,
            border-bottom-style,border-bottom-width,border-collapse,
            border-color,border-left,border-left-color,border-left-style,
            border-left-width,border-right,border-right-color,
            border-right-style,border-right-width,border-spacing,
            border-style,border-top,border-top-color,border-top-style,
            border-top-width,border-width,bottom,caption-side,clear,
            clip,color,content,counter-increment,counter-reset,cue,
            cue-after,cue-before,cursor,direction,display,elevation,
            empty-cells,filter,float,font,font-family,font-size,
            font-size-adjust,font-stretch,font-style,font-variant,
            font-weight,height,ime-mode,include-source,
            layer-background-color,layer-background-image,layout-flow,
            layout-grid,layout-grid-char,layout-grid-char-spacing,
            layout-grid-line,layout-grid-mode,layout-grid-type,left,
            letter-spacing,line-break,line-height,list-style,
            list-style-image,list-style-position,list-style-type,margin,
            margin-bottom,margin-left,margin-right,margin-top,
            marker-offset,marks,max-height,max-width,min-height,
            min-width,binding,border-radius,
            border-radius-topleft,border-radius-topright,
            border-radius-bottomright,border-radius-bottomleft,
            border-top-colors,border-right-colors,
            border-bottom-colors,border-left-colors,opacity,
            outline,outline-color,outline-style,
            outline-width,user-focus,user-input,
            user-modify,user-select,orphans,outline,
            outline-color,outline-style,outline-width,overflow,
            overflow-X,overflow-Y,padding,padding-bottom,padding-left,
            padding-right,padding-top,page,page-break-after,
            page-break-before,page-break-inside,pause,pause-after,
            pause-before,pitch,pitch-range,play-during,position,quotes,
            -replace,richness,right,ruby-align,ruby-overhang,
            ruby-position,-set-link-source,size,speak,speak-header,
            speak-numeral,speak-punctuation,speech-rate,stress,
            scrollbar-arrow-color,scrollbar-base-color,
            scrollbar-dark-shadow-color,scrollbar-face-color,
            scrollbar-highlight-color,scrollbar-shadow-color,
            scrollbar-3d-light-color,scrollbar-track-color,table-layout,
            text-align,text-align-last,text-decoration,text-indent,
            text-justify,text-overflow,text-shadow,text-transform,
            text-autospace,text-kashida-space,text-underline-position,top,
            unicode-bidi,-use-link-source,vertical-align,visibility,
            voice-family,volume,white-space,widows,width,word-break,
            word-spacing,word-wrap,writing-mode,z-index,zoom},  
  sensitive=true,
  morecomment=[l]{//},
  morecomment=[s]{/*}{*/},
  morestring=[b]',
  morestring=[b]",
  alsodigit={-}
}

\lstdefinelanguage{myjava}[]{java}{
  escapeinside=\`\`,%
  basicstyle={\ttfamily},%
  keywordstyle={\ttfamily\bfseries},%
  commentstyle={\it},%
}


% Code formatting
\pgfkeys{
  /khl/code/.cd,
  frame/.code=\lstset{frame=#1},
  font size/.code=\lstset{basicstyle={\ttfamily #1}},
  width/.initial=.8\linewidth,
  language/.code=\lstset{language=#1},
  show lines/.code=\lstset{showlines}
}

% Styles
\pgfkeys{
  /khl/note/.style={drop shadow,fill=blue!60,opacity=.8,text opacity=1},
  /khl/note arrow/.style={blue!60,ultra thick,-latex,opacity=.8}
}

\lstset{language=JavaScript,frame=lines}

% \code[pgfkeys]{filename}
\newcommand{\code}[2][]{
  {
    \pgfkeys{/khl/code/.cd,#1}
    \begin{center}
      \pgfkeys{/khl/code/width/.get=\width}
      \begin{minipage}{\width}
        \lstinputlisting{#2}
      \end{minipage}
    \end{center}
  }
}

\newcommand{\inlinecode}[2][]{
  {
    \pgfkeys{/khl/code/.cd,#1}
    \pgfkeys{/khl/code/width/.get=\width}
    \begin{minipage}{\width}
      \lstinputlisting{#2}
    \end{minipage}
  }
}


% Tikz related commands
% \NODE{text}{id}
\newcommand{\NODE}[3][]{\tikz[baseline,remember picture]{\node[anchor=base,inner sep=0mm,#1] (#3) {{#2}};}}
\newcommand{\COORD}[1]{\tikz[overlay,baseline,remember picture]{\coordinate (#1);}}


\newcommand{\toc}{
  \begin{frame}
    \tableofcontents[sectionstyle=show/shaded,subsectionstyle=show/shaded/hide]
  \end{frame}
}


\setbeamertemplate{title page}{%
  \begin{center}
    Toegepaste Wiskunde 1 \\[5mm]
    {\sc\Huge \inserttitle}
  \end{center}
}


\definecolor{darkgreen}{RGB}{0,127,0}