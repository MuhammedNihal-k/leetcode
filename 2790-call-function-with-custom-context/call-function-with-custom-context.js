

Function.prototype.callPolyfill = function(context, ...args) {

    context = context || {};

    const fn = this;

    const uniqueKey = Symbol();

    context[uniqueKey] = fn;

    const result = context[uniqueKey](...args);

    delete context[uniqueKey];

    return result;
};
