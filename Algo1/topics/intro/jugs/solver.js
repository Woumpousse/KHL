var __extends = this.__extends || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    __.prototype = b.prototype;
    d.prototype = new __();
};
function getUrlVars() {
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < hashes.length; i++) {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}

function format(result) {
    var args = [];
    for (var _i = 0; _i < (arguments.length - 1); _i++) {
        args[_i] = arguments[_i + 1];
    }
    for (var i = 0; i != args.length; i++) {
        var regEx = new RegExp("\\{" + i + "\\}", "gm");
        result = result.replace(regEx, args[i]);
    }

    return result;
}

var Jug = (function () {
    function Jug(_capacity, _contents) {
        this._capacity = _capacity;
        this._contents = _contents;
    }
    Object.defineProperty(Jug.prototype, "capacity", {
        get: function () {
            return this._capacity;
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(Jug.prototype, "contents", {
        get: function () {
            return this._contents;
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(Jug.prototype, "free", {
        get: function () {
            return this._capacity - this._contents;
        },
        enumerable: true,
        configurable: true
    });

    Object.defineProperty(Jug.prototype, "isFilled", {
        get: function () {
            return this._contents === this._capacity;
        },
        enumerable: true,
        configurable: true
    });

    Object.defineProperty(Jug.prototype, "isEmpty", {
        get: function () {
            return this._contents === 0;
        },
        enumerable: true,
        configurable: true
    });

    Jug.prototype.fill = function () {
        return new Jug(this._capacity, this._capacity);
    };

    Jug.prototype.lose = function (n) {
        return new Jug(this._capacity, this.contents - n);
    };

    Jug.prototype.gain = function (n) {
        return new Jug(this._capacity, this.contents + n);
    };

    Object.defineProperty(Jug.prototype, "hash", {
        get: function () {
            return this._capacity * 128 + this._contents;
        },
        enumerable: true,
        configurable: true
    });

    Jug.prototype.equals = function (x) {
        return x instanceof Jug && x.capacity === this.capacity && x.contents === this.contents;
    };

    Jug.prototype.toString = function () {
        return format("{0}/{1}", this._contents, this._capacity);
    };
    return Jug;
})();

var Step = (function () {
    function Step(_start, _end) {
        this._start = _start;
        this._end = _end;
    }
    Object.defineProperty(Step.prototype, "start", {
        get: function () {
            return this._start;
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(Step.prototype, "end", {
        get: function () {
            return this._end;
        },
        enumerable: true,
        configurable: true
    });
    return Step;
})();

var FillStep = (function (_super) {
    __extends(FillStep, _super);
    function FillStep(start, end, _filledIndex) {
        _super.call(this, start, end);
        this._filledIndex = _filledIndex;
    }
    FillStep.prototype.toString = function () {
        return format("Fill jug #{0}", this._filledIndex + 1);
    };
    return FillStep;
})(Step);

var TransferStep = (function (_super) {
    __extends(TransferStep, _super);
    function TransferStep(start, end, _fromIndex, _toIndex, _amount) {
        _super.call(this, start, end);
        this._fromIndex = _fromIndex;
        this._toIndex = _toIndex;
        this._amount = _amount;
    }
    TransferStep.prototype.toString = function () {
        return format("Transfer {0} from jug #{1} to jug #{2}", this._amount, this._fromIndex + 1, this._toIndex + 1);
    };
    return TransferStep;
})(Step);

var State = (function () {
    function State(jugs) {
        this._jugs = jugs;
    }
    Object.defineProperty(State.prototype, "jugs", {
        get: function () {
            return this._jugs;
        },
        enumerable: true,
        configurable: true
    });

    State.prototype.expandByFill = function () {
        var result = [];

        for (var i = 0; i !== this._jugs.length; ++i) {
            var jug = this._jugs[i];

            if (!jug.isFilled) {
                var jugs = this._jugs.slice();
                jugs[i] = jug.fill();

                var endState = new State(jugs);
                result.push(new FillStep(this, endState, i));
            }
        }

        return result;
    };

    State.prototype.expandByTransfer = function () {
        var result = [];

        for (var fromIndex = 0; fromIndex !== this._jugs.length; ++fromIndex) {
            for (var toIndex = 0; toIndex !== this._jugs.length; ++toIndex) {
                var from = this._jugs[fromIndex];
                var to = this._jugs[toIndex];

                if (fromIndex !== toIndex && !from.isEmpty && !to.isFilled) {
                    var transfer = Math.min(from.contents, to.free);
                    var jugs = this._jugs.slice();

                    jugs[fromIndex] = from.lose(transfer);
                    jugs[toIndex] = to.gain(transfer);

                    var endState = new State(jugs);

                    result.push(new TransferStep(this, endState, fromIndex, toIndex, transfer));
                }
            }
        }

        return result;
    };

    State.prototype.expand = function () {
        return this.expandByFill().concat(this.expandByTransfer());
    };

    State.prototype.containsJugWithContents = function (n) {
        for (var i in this._jugs) {
            var jug = this._jugs[i];

            if (jug.contents === n) {
                return true;
            }
        }

        return false;
    };

    Object.defineProperty(State.prototype, "hash", {
        get: function () {
            var result = 0;

            for (var i in this._jugs) {
                result += this._jugs[i].hash;
            }

            return result;
        },
        enumerable: true,
        configurable: true
    });

    State.prototype.equals = function (x) {
        if (x instanceof State) {
            if (x.jugs.length !== this.jugs.length) {
                return false;
            } else {
                for (var i in this.jugs) {
                    if (!this.jugs[i].equals(x.jugs[i])) {
                        return false;
                    }
                }

                return true;
            }
        } else {
            return false;
        }
    };

    State.prototype.toString = function () {
        return this._jugs.toString();
    };
    return State;
})();

function createInitialState(capacities) {
    var jugs = new Array(capacities.length);

    for (var i = 0; i !== jugs.length; ++i) {
        jugs[i] = new Jug(capacities[i], 0);
    }

    return new State(jugs);
}

var SearchNode = (function () {
    function SearchNode(_state, _history) {
        this._state = _state;
        this._history = _history;
    }
    Object.defineProperty(SearchNode.prototype, "state", {
        get: function () {
            return this._state;
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(SearchNode.prototype, "history", {
        get: function () {
            return this._history;
        },
        enumerable: true,
        configurable: true
    });

    SearchNode.prototype.add = function (step) {
        var history = this._history.slice();
        history.push(step);

        return new SearchNode(step.end, history);
    };

    SearchNode.prototype.toString = function () {
        return this._state.toString();
    };
    return SearchNode;
})();

var NoSolutionFound = (function () {
    function NoSolutionFound() {
    }
    return NoSolutionFound;
})();

function withDefault(x, def) {
    return x ? x : def;
}

function solve(start, goal) {
    var states = [new SearchNode(start, [])];
    var node;
    var count = withDefault(getUrlVars()['count'], 10000);

    while (count > 0 && !(node = states.shift()).state.containsJugWithContents(goal)) {
        var expansion = node.state.expand();

        for (var i in expansion) {
            states.push(node.add(expansion[i]));
        }

        --count;
    }

    if (count === 0) {
        throw new NoSolutionFound();
    } else {
        return node.history;
    }
}
