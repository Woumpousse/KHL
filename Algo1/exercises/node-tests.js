var vm = require('vm');
var fs = require('fs');

function loadScript(path, context)
{
    var context = context ? context : {};

    vm.runInNewContext( fs.readFileSync(path), context );

    return context;
}

var context = loadScript('conditionals/solutions.js');
context = loadScript('test-framework.js', context);
context = loadScript('conditionals/tests.js', context);
var student = loadScript('conditionals/student.js');

