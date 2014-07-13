Hint hint = new Hint("paard");
System.out.println(hint.show()); // _ _ _ _ _
hint.reveal('a');
System.out.println(hint.show()); // _ a a _ _
hint.reveal('d');
System.out.println(hint.show()); // _ a a _ d
