var Lazy = (function () {
    function Lazy(_producer) {
        this._producer = _producer;
    }
    Object.defineProperty(Lazy.prototype, "value", {
        get: function () {
            if (!this._computed) {
                this._val = this._producer();
                this._computed = true;
            }

            return this._val;
        },
        enumerable: true,
        configurable: true
    });
    return Lazy;
})();
