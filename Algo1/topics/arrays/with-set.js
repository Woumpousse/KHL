function gelukkig(n) {
    var `\NODE{bezocht}{visited}` = `\NODE{\color{darkgreen}nieuweVerzameling}{new set}`();

    while ( !`\NODE{\color{darkgreen}elementVan}{element}`(n, bezocht) &&
            n !== 1 )
    {
        `\NODE{\color{darkgreen}voegToe}{insert}`(n, bezocht);
        n = opvolger(n);
    }

    return `\NODE{n === 1}{result}`;
}
