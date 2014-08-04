function getUrlVars()
{
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}

function format(result : string, ... args : any[]) : string
{
    for (var i = 0; i != args.length; i++) {
        var regEx = new RegExp("\\{" + i + "\\}", "gm");
        result = result.replace(regEx, args[i]);
    }

    return result;
}

class Jug
{
    constructor(private _capacity : number, private _contents : number) { }

    get capacity() { return this._capacity; }
    get contents() { return this._contents; }
    get free() { return this._capacity - this._contents; }

    get isFilled() : boolean
    {
        return this._contents === this._capacity;
    }

    get isEmpty() : boolean
    {
        return this._contents === 0;
    }

    fill() : Jug
    {
        return new Jug( this._capacity, this._capacity );
    }

    lose(n : number) : Jug
    {
        return new Jug( this._capacity, this.contents - n );
    }

    gain(n : number) : Jug
    {
        return new Jug( this._capacity, this.contents + n );
    }

    get hash() : number
    {
        return this._capacity * 128 + this._contents;
    }

    equals(x : any) : boolean
    {
        return x instanceof Jug && x.capacity === this.capacity && x.contents === this.contents;
    }

    toString() : string
    {
        return format( "{0}/{1}", this._contents, this._capacity );
    }
}

class Step
{
    constructor(private _start : State, private _end : State) { }

    get start() : State { return this._start; }
    get end() : State { return this._end; }
}

class FillStep extends Step
{
    constructor(start : State, end : State, private _filledIndex : number)
    {
        super(start, end);
    }

    toString() : string
    {
        return format( "Fill jug #{0}",  this._filledIndex + 1 );
    }
}

class TransferStep extends Step
{
    constructor(start : State, end : State, private _fromIndex : number, private _toIndex : number, private _amount : number)
    {
        super(start, end);
    }

    toString() : string
    {
        return format( "Transfer {0} from jug #{1} to jug #{2}", this._amount, this._fromIndex + 1, this._toIndex + 1 );
    }   
}

class State
{
    private _jugs : Array<Jug>;

    constructor(jugs : Array<Jug>)
    {
        this._jugs = jugs;
    }

    get jugs() : Array<Jug>
    {
        return this._jugs;
    }

    private expandByFill() : Array<Step>
    {
        var result : Array<Step> = [];

        for ( var i = 0; i !== this._jugs.length; ++i )
        {
            var jug = this._jugs[i];

            if ( !jug.isFilled )
            {
                var jugs = this._jugs.slice();
                jugs[i] = jug.fill();
               
                var endState = new State(jugs);
                result.push( new FillStep(this, endState, i) );
            }
        }

        return result;
    }

    private expandByTransfer() : Array<Step>
    {
        var result : Array<Step> = [];

        for ( var fromIndex = 0; fromIndex !== this._jugs.length; ++fromIndex )
        {
            for ( var toIndex = 0; toIndex !== this._jugs.length; ++toIndex )
            {
                var from = this._jugs[fromIndex];
                var to = this._jugs[toIndex];

                if ( fromIndex !== toIndex && !from.isEmpty && !to.isFilled )
                {
                    var transfer = Math.min( from.contents, to.free );
                    var jugs = this._jugs.slice();

                    jugs[fromIndex] = from.lose( transfer );
                    jugs[toIndex] = to.gain( transfer );

                    var endState = new State(jugs);

                    result.push( new TransferStep(this, endState, fromIndex, toIndex, transfer) );
                }
            }
        }

        return result;
    }

    expand() : Array<Step>
    {
        return this.expandByFill().concat(this.expandByTransfer());
    }

    containsJugWithContents(n : number)
    {
        for ( var i in this._jugs )
        {
            var jug = this._jugs[i];

            if ( jug.contents === n )
            {
                return true;
            }
        }

        return false;
    }

    get hash() : number
    {
        var result = 0;

        for ( var i in this._jugs )
        {
            result += this._jugs[i].hash;
        }

        return result;
    }

    equals(x : any) : boolean
    {
        if ( x instanceof State )
        {
            if ( x.jugs.length !== this.jugs.length )
            {
                return false;
            }
            else
            {                
                for ( var i in this.jugs )
                {
                    if ( !this.jugs[i].equals( x.jugs[i] ) )
                    {
                        return false;
                    }
                }

                return true;
            }
        }
        else
        {
            return false;
        }
    }

    toString() : string
    {
        return this._jugs.toString();
    }
}

function createInitialState(capacities : Array<number>) : State
{
    var jugs = new Array(capacities.length);
    
    for ( var i = 0; i !== jugs.length; ++i )
    {
        jugs[i] = new Jug(capacities[i], 0);
    }

    return new State(jugs);
}

class SearchNode
{
    constructor(private _state : State, private _history : Array<Step>) { }

    get state() : State { return this._state; }
    get history() : Array<Step> { return this._history; }

    add(step : Step) : SearchNode
    {
        var history = this._history.slice();
        history.push(step);

        return new SearchNode( step.end, history );
    }

    toString() : string
    {
        return this._state.toString();
    }
}

class NoSolutionFound { }

function withDefault(x, def)
{
    return x ? x : def;
}

function solve(start : State, goal : number) : Array<Step>
{
    var states = [ new SearchNode(start, []) ];
    var node;
    var count = withDefault( getUrlVars()['count'], 10000 );
    
    while ( count > 0 && !( node = states.shift() ).state.containsJugWithContents(goal) )
    {
        var expansion = node.state.expand();
       
        for ( var i in expansion )
        {
            states.push( node.add(expansion[i]) );
        }

        --count;
    }

    if ( count === 0 )
    {
        throw new NoSolutionFound();
    }
    else
    {
        return node.history;
    }
}
