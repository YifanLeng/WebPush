$(document).ready(function() {
    console.log("document loaded")
    // process the form
    $(".followship_form").submit(function(event) {
        // stop the form from submitting the normal way and refreshing the page
        event.preventDefault();

        // get the form data
        // there are many ways to get this data using jQuery (you can use the class or id also)
        var formData = {
            "idol_id": $("input[name=idol_id]").val(),
        };

        if ($(".followship_form").attr("id") == "follow") {
          $.ajax({
              type        : "POST", // define the type of HTTP verb we want to use (POST for our form)
              url         : "/follow", // the url where we want to POST
              data        : formData, // our data object
              dataType    : "html", // what type of data do we expect back from the server
              encode      : true,
              error       : function(xhr){
                  alert("An error occured: " + xhr.status + 
                      " " + xhr.statusText);},
              success     : function(result){
                  $(".followship_form").attr("id", "unfollow");
                  $("#submit_button").attr("value", "unfollow");}})
        } else {
          $.ajax({
            type        : "POST", // define the type of HTTP verb we want to use (POST for our form)
            url         : "/unfollow", // the url where we want to POST
            data        : formData, // our data object
            dataType    : 'html', // what type of data do we expect back from the server
            encode      : true,
            error       : function(xhr){
                alert("An error occured: " + xhr.status + 
                    " " + xhr.statusText);},
            success     : function(result){
                $(".followship_form").attr("id", "follow");
                $("#submit_button").attr("value", "follow");}})
      }
  });
});