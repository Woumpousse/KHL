var maps = (function () {
    var strings = function () { /*
1
..........
..........
..........
..........
..........
....G.....
....C.....
..........
..........
..........
2
..........
..........
..........
..........
....G.....
.... .....
....C.....
..........
..........
..........
3
..........
..........
..........
....G.....
.... .....
.... .....
....C.....
..........
..........
..........
4
..........
..........
....G.....
.... .....
.... .....
.... .....
....C.....
..........
..........
..........
5
..........
....G.....
.... .....
.... .....
.... .....
.... .....
.... .....
.... .....
....C.....
..........
6
..........
..........
..........
..........
..........
..........
..........
..........
....CG....
..........
7
..........
.       G.
. ........
. ........
. ........
. ........
. ........
. ........
.C........
..........
8
..........
.        .
. ...... .
. ...... .
. ...... .
. ...... .
. ...... .
. ...... .
.C......G.
..........
9
..........
..........
..........
.    .....
. .. .....
. .. .....
. ..G.....
. ........
.C........
..........
10
..........
..........
..........
..........
..........
..........
.        .
. ......G.
.C........
..........
11
..........
.        .
. ...... .
. .    . .
. . .. . .
. . .. . .
. . .G . .
. . .... .
.C.      .
..........
12
..........
..........
..........
..........
..........
....GC....
..........
..........
..........
..........
13
..........
.        .
. ...... .
. .    . .
. . .. . .
. . .. . .
. . G. . .
. .... . .
.      .C.
..........
14
..........
.       C.
. ........
. .      .
. . .... .
. . ..G. .
. .    . .
. ...... .
.        .
..........
15
..........
..........
..........
..........
....C.....
....G.....
..........
..........
..........
..........
16
..........
..........
..........
....C.....
.... .....
.... .....
....G.....
..........
..........
..........
17
..........
....C.....
.... .....
.... .....
.... .....
.... .....
.... .....
.... .....
....G.....
..........
18
..........
..........
..........
..........
..G  .....
.... .....
....C.....
..........
..........
..........
19
..........
..........
..........
..........
....  G...
.... .....
....C.....
..........
..........
..........
20
..........
.       C.
. ........
.        .
........ .
.        .
. ........
.        .
........G.
..........
21
..........
..   .   .
.G .   . .
........ .
.C  .    .
... . ....
.   .    .
. ...... .
.        .
..........
22
..........
.        .
........ .
.G       .
........ .
.        .
........ .
.        .
........C.
..........
23
..........
.G       .
........ .
.        .
........ .
.        .
........ .
.        .
........C.
..........
24
..........
.        .
........ .
.        .
........ .
.G       .
........ .
.        .
........C.
..........
25
..........
.       G.
. ........
.        .
. ........
.        .
. ........
.        .
.C........
..........
26
..........
. . G.   .
. . .  . .
. . .... .
.        .
..... ....
.   .    .
. ...... .
.C       .
..........
*/ }.toString();


return _.map( strings.split(/\s+\d+\s+/).slice(1), function (block) {
    var lines = block.split("\n");
    
    return lines;
} );

})();


function Vector2D(x, y)
{
    return { x: x,
             y: y,
             eq: function( other )
             {
                 return x === other.x && y === other.y;
             },
             add: function( other )
             {
                 return Vector2D(x + other.x, y + other.y);
             }
           };
}

var Orientation = (function ()
                   {
                       var orientations;

                       function create(i, vector)
                       {
                           var me = { turnRight: function ()
                                      {
                                          return orientations[ (i + 1) % 4 ];
                                      },
                                      angle: i * 90,
                                      vector: vector
                                    };

                           return me;
                       }

                       orientations = [ create(0, Vector2D(0, 1)),
                                        create(1, Vector2D(1, 0)),
                                        create(2, Vector2D(0, -1)),
                                        create(3, Vector2D(-1, 0))
                                      ];

                       var me = { NORTH: orientations[0],
                                  EAST: orientations[1],
                                  SOUTH: orientations[2],
                                  WEST: orientations[3]
                                };

                       return me;                                  
                   })();


function Rectangle( x, y, width, height )
{
    return { x: x,
             y: y,
             width: width,
             height: height,
             shrink: function(delta)
             {
                 return Rectangle(x + delta, y + delta, width - 2 * delta, height - 2 * delta);
             },
             lowerLeft: Vector2D(x, y)
           };
}

var global = { worldWidth: 500,
               worldHeight: 500,
               cellWidth: 50,
               cellHeight: 50,
               wallMargin: 2,
               crashed: "crashed",
               goalReached: "goal reached",
               goalNotReached: "goal not reached",
               animationSpeed: 50,
               animate: true,
               debugMode: false
             };

var SVG = function( svg )
{
    var me = { cellBoundingRectangle: function (pos)
               {
                   return Rectangle( pos.x * global.cellWidth,
                                     global.worldHeight - pos.y * global.cellHeight,
                                     global.cellWidth,
                                     global.cellHeight
                                   );
               },
               reset: function ()
               {
                   svg.clear();
               },
               drawWall: function (pos)
               {
                   var rect = SVG.cellBoundingRectangle(pos).shrink(global.wallMargin);
                   var elt = svg.rect( rect.x,
                                       rect.y,
                                       rect.width,
                                       rect.height );
                   elt.attr( {fill: 'black'} );
               },
               drawEmpty: function (pos)
               {
                   var rect = SVG.cellBoundingRectangle(pos).shrink(global.wallMargin);
                   var elt = svg.rect( rect.x,
                                       rect.y,
                                       rect.width,
                                       rect.height );
               },
               drawGoal: function (pos)
               {
                   var rect = SVG.cellBoundingRectangle(pos).shrink(global.wallMargin);
                   var elt = svg.rect( rect.x,
                                       rect.y,
                                       rect.width,
                                       rect.height );
                   elt.attr( {fill: 'green'} );
               },
               drawCar: function ()
               {
                   var rect = SVG.cellBoundingRectangle( Vector2D(0, 0) );
                   var elt  = svg.image("car.png", 0, 0, rect.width, rect.height);
                   var currentState;
                   elt.hide();

                   function constructTransformationString(transformation)
                   {
                       return "t" + transformation.pixelPosition.x.toString() + "," + transformation.pixelPosition.y.toString() + "r" + transformation.angle.toString();
                   }

                   function stateToTransformation(state)
                   {
                       var rect = SVG.cellBoundingRectangle( state.position );
                       var angle = state.orientation.angle;

                       return { pixelPosition: rect.lowerLeft,
                                angle: angle + 90
                              };
                   }

                   var me = { update: function (state)
                              {
                                  var transformationString = constructTransformationString( stateToTransformation(state) );
                                  elt.transform( transformationString );

                                  elt.show();

                                  currentState = state;
                              },
                              animate: function (state)
                              {
                                  if ( currentState && currentState.orientation.angle == 270 && state.orientation.angle == 0 )
                                  {
                                      transformation = stateToTransformation(currentState);
                                      transformation.angle = 0;
   
                                      elt.transform( constructTransformationString( transformation) );
                                  }

                                  var transformString = constructTransformationString( stateToTransformation(state) );

                                  elt.stop().animate( { transform: transformString }, global.animationSpeed);

                                  currentState = state;
                              }
                            };
                   return me;
               }
             };

    return me;
};


function createGrid( width, height )
{
    var grid = new Array( width );

    for ( var i = 0; i != width; ++i )
    {
        grid[i] = new Array( height );
    }

    var me = { width: width,
               height: height,
               at: function (pos) { return grid[pos.x][pos.y]; },
               set: function (pos, val) { return grid[pos.x][pos.y] = val; },
               draw: function () {
                   for ( var i = 0; i != width; ++i )
                   {
                       for ( var j = 0; j != height; ++j )
                       {
                           me.at( Vector2D(i, j) ).draw();
                       }
                   }       
               }
             };

    return me;
}

function EmptyCell(position)
{
    this.draw = function ()
    {
        SVG.drawEmpty(position);
    };
}

function WallCell(position)
{
    this.draw = function ()
    {
        SVG.drawWall(position);
    };
}

function GoalCell(position)
{
    this.draw = function ()
    {
        SVG.drawGoal(position);
    };
}

function parseMap(strings)
{
    var height = strings.length;
    var width  = strings[0].length;
    var grid   = createGrid(width, height);

    for ( var y = 0; y != height; ++y )
    {
        for ( var x = 0; x != width; ++x )
        {
            var carPosition;
            var position = Vector2D(x, height-y-1);
            var cell;

            switch ( strings[y].charAt(x) )
            {
            case " ":
                cell = new EmptyCell(position);
                break;

            case ".":
                cell = new WallCell(position);
                break;

            case "C":
                cell = new EmptyCell(position);
                carPosition = position;
                break;

            case "G":
                cell = new GoalCell(position);
                break;
            }

            grid.set( position, cell );
        }
    }

    return { map: grid,
             initialCarState: CarState(carPosition, Orientation.NORTH)
           };
}

function CarState(position, orientation)
{
    var me = { position: position,
               orientation: orientation,
               forward: function() {
                   return CarState( position.add( orientation.vector ), orientation );
               },
               turnRight: function() {
                   return CarState( position, orientation.turnRight() );
               }
             };

    return me;
}

function createCar(initialState, map)
{
    var currentState = initialState;
    var history = [ currentState ];

    function check()
    {
        if ( map.at( currentState.position ) instanceof GoalCell )
        {
            throw global.goalReached;
        }
        else if ( map.at( currentState.position ) instanceof WallCell )
        {
            throw global.crashed;
        }            
    }

    var me = { forward: function ()
               {
                   currentState = currentState.forward();
                   history.push(currentState);

                   check();

                   return me;
               },
               turnRight: function ()
               {
                   currentState = currentState.turnRight();
                   history.push(currentState);

                   check();

                   return me;
               },
               sensor: function ()
               {
                   var sensePosition = currentState.position.add( currentState.orientation.vector );
                   return map.at(sensePosition) instanceof WallCell;
               }
             };

    return { car: me, history: history };
}

function getExercise()
{
    idx = getUrlVars().exercise || 1;

    return parseMap(maps[idx-1]);
}

function visualizeHistory( svgCar, history, post )
{
    svgCar.update( history[0] );

    if ( history.length > 1 )
    {
        var i = 1;

        function step()
        {
            if ( global.animate ) {
                svgCar.animate( history[i] );
            }
            else {
                svgCar.update(  history[i] );
            }
            ++i;
            
            if ( i < history.length )
            {
                setTimeout( step, global.animationSpeed );
            }
            else
            {
                setTimeout( post, global.animationSpeed );
            }
        }

        step();
    }
}

function simulate(configuration)
{
    var car = createCar( configuration.initialCarState, configuration.map );
    var outcome;

    try
    {
        drive(car.car);
        outcome = global.goalNotReached;
    }
    catch ( exception )
    {
        if ( typeof exception == 'string' )
        {
            outcome = exception;
        }
        else
        {
            throw exception;
        }
    }

    return { car: car.car, history: car.history, outcome: outcome };
}

function createNavBar()
{
    function newElt(tag)
    {
        return $( document.createElement(tag) );
    }

    var nav = $('nav');
    var list = newElt('ul');

    for ( var i = 0; i !== maps.length; ++i )
    {
        var item = newElt('li');
        var link = newElt('a');
        link.append((i + 1).toString());
        link.attr('href', "?exercise=" + (i+1));
        item.append(link);
        list.append(item);
    }

    nav.append(list);
}

function startSimulation()
{
    createNavBar();

    SVG = SVG( Raphael("svg-holder", 1000, 1000) );

    var configuration = getExercise();
    var result = simulate(configuration);

    configuration.map.draw();
    var svgCar = SVG.drawCar();

    visualizeHistory( svgCar, result.history, function() {
        if ( result.outcome == global.crashed )
        {
            alert("You crashed the car!");
        }
        else if ( result.outcome == global.goalNotReached )
        {
            alert("You failed to reach your destination");
        }
        else if ( result.outcome == global.goalReached )
        {
            alert("Congratulations! Proceed with next exercise.");
        }
        else
        {
            alert("You encountered a bug... " + result.outcome);
        }
    } );
}

$( startSimulation );
