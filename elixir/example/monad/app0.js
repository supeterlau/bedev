let plus3 = (val) => val + 3;

console.log([2].map(plus3));

console.log([].map(plus3));

let plus3AndLog = (val) => {
  let result = val + 3;
  console.log(result);
  return result;
};

[2].map(plus3AndLog);

[].map(plus3AndLog);

let promise = Promise.resolve(1);

console.log(
  promise.then(
    (v) => v + 1,
    function (reason) {
      console.log(reason);
    }
  )
);

(async function () {
  let result = await promise;
  console.log("await: ", result);
})();

var p = Promise.resolve([1, 2, 3]);

console.log(
  p.then(function (v) {
    console.log(v[0]); // 1
  })
);

let plus5 = (val) => val + 5;

let plus6 = (val) => val + 6;

let compose = (f, g) => (x) => f(g(x));

console.log("compose", compose(plus5, plus6)(10));

let wrapped2 = [2];
let wrapped3 = [3];

Array.prototype.ap = function (wrappedVal) {
  if (this[0] !== undefined) {
    return wrappedVal.map(this[0]);
  } else {
    return [];
  }
};

// 处理均为数组情况

Array.prototype.aps = function (wrappedVals) {
  let results = [];
  for (let i = 0; this.length; i++) {
    results.push(wrappedVals.map(this[i]));
  }
  return results;
};

let add = (a) => (b) => a + b;

let wrappedPlus3 = wrapped3.map(add);

console.log("Applicatives:", wrappedPlus3.ap(wrapped2));

console.log("=== END ===");

Array.prototype.flatMap = function (lambda) {
  return [].concat.apply([], this.map(lambda));
};

let half = (val) => (val % 2 == 0 ? [val / 2] : []);

console.log("Monad 1:", [3].flatMap(half));
console.log("Monad 2:", [4].flatMap(half));
console.log("Monad 3:", [].flatMap(half));

// Request

function get(url) {
  return new Promise(function (resolve, reject) {
    let req = new XMLHttpRequest();
    req.open("GET", url);

    req.onload = function () {
      if (req.status == 200) {
        resolve(req.response);
      } else {
        reject(Error(req.statusText));
      }
    };

    req.onerror = function () {
      reject(Error("Wrong"));
    };

    req.send();
  });
}

get("https://www.friends.com/contacts/1")
  .then((result) => JSON.parse(result))
  .then((parsedJSON) => {
    let contactId = parsedJSON.connections[0];
    return get("https://www.friends.com/contacts/" + contactId);
  })
  .then((result) => JSON.parse(result), console.error);
