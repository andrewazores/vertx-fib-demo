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
  fib(i, function(res) { $("table").append("<tr><td>" + i + "</td><td>" + res + "</td></tr>"); }, oncomplete);
}

function startAuto() {
  if (window.runAuto) {
    return;
  }
  window.runAuto = true;
  var i = 0;
  var next = function() {
    if (!window.runAuto) {
      return;
    }
    var delay = 1 * 1000;
    doFib(i, function() { setTimeout(next, delay); });
    i++;
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

$(document).ready(setTableHeaders);
