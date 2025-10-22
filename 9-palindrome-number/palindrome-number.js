/**
 * @param {number} x
 * @return {boolean}
 */
var isPalindrome = function(x) {
    let rr=x.toString();
    let reversed=rr.split('').reverse().join('');
    return rr===reversed;
    
};

