var tijdsinterval = khl[1][8][1][5][1][14][2][1];
var start = tijdsinterval[1];
var einde = tijdsinterval[2];
var duur = (einde[0] * 3600 +
            einde[1] * 60 +
            einde[2] -
            start[0] * 3600 -
            start[1] * 60 -
            start[2]) / 3600;
