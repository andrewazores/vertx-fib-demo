function fib() {
  var i = $("input").val();
  $.ajax("/fib/" + i)
    .done(function(res) {
      $("table").append("<tr><td>" + i + "</td><td>" + res + "</td></tr>");
    })
    .fail(function(err) {
      alert(JSON.stringify(err));
    });
}
