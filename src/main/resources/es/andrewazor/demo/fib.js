function fib(i, onresult, oncomplete) {
  $.ajax("/fib/" + i)
    .done(function(res) {
      if (onresult) {
        onresult.call(this, res);
      }
    })
    .fail(function(err) {
      alert(JSON.stringify(err));
    })
    .always(function() {
      if (oncomplete) {
        oncomplete.apply()
      }
    });
}

function doFib(i, oncomplete) {
  fib(i, function(res) {
    if (window.runAuto) {
      $("table").append("<tr><td>" + i + "</td><td>" + res + "</td></tr>");
    }
  }, oncomplete);
}

function startAuto() {
  if (window.runAuto) {
    return;
  }
  window.runAuto = true;
  var i = window.min;
  var next = function() {
    if (!window.runAuto) {
      return;
    }
    doFib(i, function() { setTimeout(next, window.delay * 1000); });
    i++;
    if (i > window.max) {
      i = window.min;
    }
  }
  next.apply();
}

function stopAuto() {
  window.runAuto = false;
  $("table").empty();
  setTableHeaders();
}

function setTableHeaders() {
  $("table").append("<tr><th>Index</th><th>Value</th></tr>");
}

function setMin(v) {
  if (v < 1) {
    return;
  }
  if (v > window.max) {
    return;
  }
  window.min = v;
}

function setMax(v) {
  if (v > 40) {
    return;
  }
  if (v < window.min) {
    return;
  }
  window.max = v;
}

function setDelay(v) {
  if (v > 5) {
    return;
  }
  if (v < 0) {
    return;
  }
  window.delay = v;
}

window.runAuto = false;
window.min = 1;
window.max = 32;
window.delay = 1;

$(document).ready(setTableHeaders);
