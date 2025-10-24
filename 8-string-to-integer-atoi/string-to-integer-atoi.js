/**
 * @param {string} s
 * @return {number}
 */
var myAtoi = function(s) {
    let rr=parseInt(s);
    if(isNaN(rr)){
        return 0
    }
    if(rr < Math.pow(-2,31)){
        return Math.pow(-2,31)
    }if(rr > Math.pow(2,31)-1){
        return Math.pow(2,31)-1
    }
    return rr
};