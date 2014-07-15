\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{wiskunde}[14/07/2014]
\LoadClass[DIV=calc,BCOR=1cm]{scrbook}

\RequirePackage{kvoptions}

\SetupKeyvalOptions{
  family=TW,
  prefix=TW@
}

\DeclareBoolOption[false]{zwartwit}
\ProcessKeyvalOptions*


\RequirePackage{showlabels}
\RequirePackage[utf8]{inputenc}
\RequirePackage[dutch]{babel}
\RequirePackage{graphicx}
\RequirePackage{fancyvrb}
\RequirePackage[labelsep=space,hang,small,bf]{caption}
\RequirePackage{array}
\RequirePackage{enumerate}
\RequirePackage{answers}
\RequirePackage{amsthm}
\RequirePackage{subfig}
\RequirePackage{amsmath}
\RequirePackage{textcomp}
\RequirePackage[utopia]{quotchap}
\RequirePackage{latexsym}
\RequirePackage{varioref}
\RequirePackage{amscd}
\RequirePackage{epsfig}
\RequirePackage{array}
\RequirePackage{float}
\RequirePackage{boxedminipage}
\RequirePackage[scaled]{beramono}
\RequirePackage[T1]{fontenc}
\RequirePackage{xcolor}
\RequirePackage[output-decimal-marker={,},quotient-mode = fraction,per-mode=symbol]{siunitx}
\RequirePackage{listings}
\RequirePackage{booktabs}
\RequirePackage{multirow} 
\RequirePackage{multicol} 
\RequirePackage{wrapfig}
\RequirePackage{microtype}
\RequirePackage{tikz}
\RequirePackage{pdfpages}
%\RequirePackage[adobe-utopia]{mathdesign}
\RequirePackage[bitstream-charter]{mathdesign}
%\RequirePackage[colorlinks,citecolor=spot,linkcolor=spot,urlcolor=spot]{hyperref} %Voor screenpdf
\RequirePackage{makeidx}
\RequirePackage{hyperref}
\RequirePackage[noabbrev,dutch]{cleveref} % Moet na hyperref komen!


\usetikzlibrary{patterns,topaths,arrows,calc,decorations.markings,positioning}

\frenchspacing


% Kleuren. Voor het printen in enkel zwart en wit
% kan je kleuren herdefiniëren. Dit wordt dan automatisch
% aangepast, zowel in \textcolor commando's, als in
% TikZ tekening met \draw[kleur ...] ...
\definecolor{grijs}{rgb}{0.9,0.9,0.9}

\ifTW@zwartwit
  \definecolor{donkergroen}{rgb}{0,.3,0}
  \definecolor{spot}{rgb}{0,0.1,0.6}
\else
  \definecolor{donkergroen}{rgb}{0,.3,0}
  \definecolor{spot}{rgb}{0,0.1,0.6}
%\definecolor{chaptergrey}{RGB}{84,106,150}
%\definecolor{orange}{RGB}{0,0,0}
\fi

% Geen schreefloze in titels enz.
\setkomafont{sectioning}{\rmfamily\bfseries\boldmath}
\setkomafont{descriptionlabel}{\rmfamily\bfseries}
%\addtokomafont{disposition}{\color{spot}} %hoofdstuktitels in blauw voor screenpdf



%%%%%% Environments %%%%%%
\newenvironment{bewijs}{\noindent{\textbf{Bewijs}} \\}{\proofend}
\newenvironment{stelling}{\noindent{\textbf{Stelling}} }{}
\newenvironment{definitie}{\noindent{\textbf{Definitie}} }{}


%%%%%%%%% Voor oefeningen en oplossingen %%%%%%%%%%%
\Newassociation{opl}{Oplossing}{ans}
\theoremstyle{definition} % want anders inhoud van oefeningen cursief
\newtheorem{oef}{Oefening}[chapter]
\Opensolutionfile{ans}[ans1]
\renewenvironment{Oplossing}[1]{\par\noindent\textbf{Oplossing #1}}{\bigskip}

\newcommand{\oplossingen}{
  \clearpage
  \Closesolutionfile{ans}  
  \chapter{Oplossingen}
  \input{ans1}
}


%%%%%%% nodig voor aanmaak bibliografie %%%%%%%
\def\bbt#1{\bibitem{#1} \label{bb:#1}}
\setlength{\unitlength}{1pt}
\bibliographystyle{unsrt}


%%%%%%%%%% Code listings %%%%%%%%%%
\lstset{%
  language=Scilab,%
  basicstyle=\ttfamily\footnotesize,%
  backgroundcolor=\color{white},%
  frame=single,%
  framerule=0.5pt,%
  rulecolor=\color{gray},%
  tabsize=2,%
  numbers=none,%
  showstringspaces=false%
}

\lstdefinestyle{inline}{basicstyle=\normalsize\ttfamily}

\newcommand{\code}[2][]{
  \begin{center}
    \begin{minipage}{.8\linewidth}
      \lstinputlisting[#1]{#2}
    \end{minipage}
  \end{center}
}

%%%%%%%%%% cleveref %%%%%%%%%%
\crefname{section}{sectie}{secties}


%%%%%%%%%% Index %%%%%%%%%%
\makeindex
