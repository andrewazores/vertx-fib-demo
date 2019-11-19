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
    var delay = 1 * 1000;
    doFib(i, function() { setTimeout(next, delay); });
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

window.runAuto = false;
window.min = 1;
window.max = 32;

$(document).ready(setTableHeaders);
