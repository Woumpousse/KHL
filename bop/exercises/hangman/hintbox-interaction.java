HintBox box = new HintBox('g');
System.out.println( box.show() ); // _
System.out.println( box.isRevealed() ); // false
box.reveal('a');
System.out.println( box.show() ); // _
System.out.println( box.isRevealed() ); // false
box.reveal('g');
System.out.println( box.show() ); // g
System.out.println( box.isRevealed() ); // true
