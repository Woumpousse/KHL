var leeftijd = parseInt(prompt("Wat is jouw leeftijd"));
if (leeftijd < 16) {
    alert("Je mag geen alcoholische drank kopen.");
} else if (leeftijd < 18) {
    alert("Je mag geen sterke drank kopen.");
} else {
    alert("Je mag alle types van alcoholische dranken kopen.");
}
