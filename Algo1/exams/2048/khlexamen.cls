\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{khlexamen}[16/12/2013]
\LoadClass{scrartcl}


\RequirePackage{a4wide}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{graphicx}
\RequirePackage{listings}
\RequirePackage{pxfonts}
\RequirePackage{mdframed}
\RequirePackage{multirow}
\RequirePackage{fancyhdr}
\RequirePackage{microtype}
\RequirePackage{lastpage}

% \pagestyle{empty}

\newcommand{\checkexistence}[1]{\ifcsname#1\endcsname \relax\else\ClassError{khlexamen}{Missing parameter #1}{You forgot to define #1}\fi}
\newcommand{\fillindots}[1]{\makebox[#1]{\dotfill}}

\newcommand{\HEADER}{
\checkexistence{academiejaar}
\checkexistence{opleiding}
\checkexistence{fase}
\checkexistence{examinator}
\checkexistence{opo}
\checkexistence{ola}
\checkexistence{activiteit}
\checkexistence{hulpmiddelen}
\checkexistence{examendatum}
\checkexistence{beginuur}
\checkexistence{duur}
\begin{center} \footnotesize
  \begin{tabular}{rlr}
    Academiejaar: & \academiejaar  & \hspace{1.cm} \multirow{4}{3cm}[0mm]{\includegraphics[width=3cm]{logoGT.pdf}} \hfill \\
    Opleiding & \opleiding  & \\
    Fase: & \fase  & \\
    Examinator: & \examinator  & \\
    OPO: & \opo  & \\
    OLA: & \ola  & \\
    Activiteit:& \activiteit  &\\
    Toegestane hulpmiddelen: &\hulpmiddelen & \\ 
    Datum: & \examendatum &  \\
    Beginuur: & \beginuur & \\
    Toegestane tijdsduur: & \duur  & \\ \\
    Student: & \multicolumn{2}{l}{\fillindots{6cm} \hspace{1mm} Nummer: \fillindots{1cm} \hspace{1mm} Reeks: \fillindots{1cm}}
% \multicolumn{2}{l}{.....................................................  Nummer: ..........................    Reeks: .........  PC: .........}\\ \\
    \\ \hline
 \end{tabular}
\end{center}
}

\newcommand{\SMALLHEADER}{
\begin{center}
  \footnotesize
  \begin{tabular}{rlr}
    OLA: & \ola  & \\
    Datum: & \examendatum &  \\[2mm]
    Student: & \multicolumn{2}{l}{\fillindots{9cm} \hspace{1mm} \hspace{1mm} Reeks: \fillindots{1cm}} \\
    \hline
 \end{tabular}
\end{center}
}



\setkomafont{sectioning}{\rmfamily\bfseries\boldmath}
\setlength{\unitlength}{1pt}
\setlength{\headheight}{14pt}
\pagestyle{fancy}
\fancyhead{}
\fancyfoot{}
\lfoot{\examendatum, \beginuur\ uur}
\cfoot{pg. \thepage \ van \pageref{LastPage}}
\rfoot{KHLeuven, dept. G\&T}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0.3pt}



\newcommand{\answerlines}[1][22]{
  \begin{center}
    \begin{tikzpicture}
      \foreach \y in {0,.75,...,#1} {
        \draw[thin,gray] (0,\y) -- (15,\y);
      }
    \end{tikzpicture}
  \end{center}
}

\newcommand{\ANSWERPAGE}{
  \SMALLHEADER
  \vskip4mm
  \answerlines[20]
}


\newcommand{\guidelines}{
\section{Richtlijnen}
\begin{itemize}
  \item Lees deze richtlijnen.
  \item Los elke vraag op de daartoe voorziene plaats. De tekst is normaalgezien zo gestructureerd
        dat je telkens vraag- en antwoordblad naast elkaar kan zichtbaar hebben.
        De hoeveelheid plaats die je krijgt is geen indicatie voor hoe lang de code moet zijn:
        het kan zijn dat je anderhalf blad de plaats krijgt om een functie van 5 lijntjes te schrijven.
  \item Je kan om zoveel kladbladen vragen als je wil, maar deze kunnen \emph{niet} gebruikt
        worden om je finaal antwoord op te noteren. Met andere woorden, kladbladen worden genegeerd tijdens de quotering.
  \item Bij implementatievragen ben je vrij om extra hulpfuncties te defini\"eren om je code beter te structureren
        en leesbaarder te maken. Het is zelfs verplicht om extra functies te schrijven indien
        dit nodig blijkt om redundantie te vermijden. Je kan elke zelfgedefinieerde functie
        blijven gebruiken in latere vragen.
  \item Bij het werken met arrays is het \emph{niet} toegelaten gebruik te maken
        van de methodes {\tt push}, {\tt pop}, {\tt shift}, {\tt unshift}, {\tt slice}, \dots
        Enkel aanmaak, indexering en lengte-opvraging zijn toegelaten.
        Je bent uiteraard wel vrij om zelf deze methodes te implementeren in
        de vorm van hulpfuncties en deze dan te gebruiken.
  \item Het is \emph{niet} toegelaten om buiten de grenzen van een array te indexeren.
        Een array van lengte 0 aanmaken om vervolgens
        elementen toe te voegen via indexering is namelijk
        equivalent met het gebruik van {\tt push}.        
\end{itemize}}


\newcommand{\oralpart}{
\section{Mondeling Deel}
Het mondeling gedeelte behandelt sorteeralgoritmen. Straks trekken jullie
een kaartje dat zal bepalen welk algoritme jullie \emph{schriftelijk moeten voorbereiden
en mondeling toelichten}. De mondelinge ondervraging begint een half uur later.

\begin{center}
  $\circ$ Bubble Sort \hspace{2mm}
  $\circ$ Selection Sort \hspace{2mm}
  $\circ$ Insertion Sort \hspace{2mm}
  $\circ$ Merge Sort \hspace{2mm}
  $\circ$ Quicksort
\end{center}
}



\lstdefinelanguage{javascript}{%  
  morekeywords={function,var,if,else,for,while,break,do,delete,in,instanceof,new,return,this,switch,throw,try,catch,typeof,int,void,with,yield,label,import,export,continue,true,false},%
  escapechar=@,%
  basicstyle={\ttfamily},%
  keywordstyle={\ttfamily\bfseries},%
  commentstyle={\it},%
  frame=lines,%
  captionpos=b,%
  sensitive=true,%
  morecomment=[l]{//},%
  morecomment=[s]{/*}{*/},%
  morestring=[b]",%
  moredelim=**[is][\color{red}]{\#}{\#}%
}

\newcommand{\INLINECODE}[1]{
  \begin{center}
    \begin{minipage}{.95\linewidth}
      \lstinputlisting[language=javascript]{#1}
    \end{minipage}
  \end{center}
}

\mdfdefinestyle{assignmentframestyle}{leftmargin=10,rightmargin=10,innertopmargin=10}

\newcommand{\assignmentframe}[1]{\begin{mdframed}[style=assignmentframestyle]#1\end{mdframed}}

\long\def\BEGINASSIGNMENT#1\ENDASSIGNMENT{\begin{center}\assignmentframe{\begin{minipage}[t][18cm][t]{.95\textwidth}#1\end{minipage}}\end{center}}
