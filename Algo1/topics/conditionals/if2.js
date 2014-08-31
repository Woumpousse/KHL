if ( `\NODE{waarde === 'bankroet'}{bankruptcy}` ) {
    score = 0;
    huidigeSpeler++;
} else if ( `\NODE{waarde === 'joker'}{joker}` ) {
    joker++;
} else if ( `\NODE{waarde === 'beurtverlies'}{pass}` ) {
    huidigeSpeler++;
} else`\COORD{else}` {
    score += waarde;
}
