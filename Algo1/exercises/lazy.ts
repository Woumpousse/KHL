interface Producer<T>
{
    () : T;
}

class Lazy<T>
{
    private _val : T;
    private _computed : boolean;

    constructor(private _producer : Producer<T>) { }

    get value() {
        if ( !this._computed ) {
            this._val = this._producer();
            this._computed = true;
        }

        return this._val;
    }
}
