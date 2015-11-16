
function initialize_algolia_search() {
  var client = algoliasearch("LNZ38F4R3P", "44638aca0bf25d6a95b4fdeb148d36c7");
  var index  = client.initIndex('test_Books');


  function algolia_search() {
    index.search( $("#search_field").val() , function(success, hits) { console.log(success, hits) });

  }


  $("#search_field").on("keyup", algolia_search);

}


