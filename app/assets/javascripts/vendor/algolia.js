
// function initialize_algolia_search() {
//   var client = algoliasearch("LNZ38F4R3P", "44638aca0bf25d6a95b4fdeb148d36c7");
//   var index  = client.initIndex('test_Books');


//   function algolia_search() {
//     index.search( $("#search-input").val() , function(success, hits) { console.log(success, hits) });

//   }


//   $("#search-input").on("keyup", algolia_search);

// }


function initialize_algolia_search() {

// Replace with your own values
var APPLICATION_ID = 'LNZ38F4R3P';
var SEARCH_ONLY_API_KEY = '44638aca0bf25d6a95b4fdeb148d36c7';
var INDEX_NAME = 'Book';
var PARAMS = {
  hitsPerPage: 10,
  maxValuesPerFacet: 8,
};

// Client + Helper initialization
var algolia = algoliasearch(APPLICATION_ID, SEARCH_ONLY_API_KEY);
var algoliaHelper = algoliasearchHelper(algolia, INDEX_NAME, PARAMS);

// DOM BINDING
$searchInput = $('#search-input');
$searchInputIcon = $('#search-input-icon');
$main = $('main');
$sortBySelect = $('#sort-by-select');
$hits = $('#hits');
$stats = $('#stats');
$facets = $('#facets');
$pagination = $('#pagination');

// Hogan templates binding
var hitTemplate = Hogan.compile($('#hit-template').text());
var statsTemplate = Hogan.compile($('#stats-template').text());
var facetTemplate = Hogan.compile($('#facet-template').text());
var sliderTemplate = Hogan.compile($('#slider-template').text());
var paginationTemplate = Hogan.compile($('#pagination-template').text());
var noResultsTemplate = Hogan.compile($('#no-results-template').text());

// Input binding
// Input binding
$searchInput
.on('keyup', function() {
  var query = $(this).val();
  toggleIconEmptyInput(query);
  algoliaHelper.setQuery(query).search();
})
.focus();

$searchInputIcon.on('click', function(e) {
  e.preventDefault();
  $searchInput.val('').keyup().focus();
});

function toggleIconEmptyInput(query) {
  $searchInputIcon.toggleClass('empty', query.trim() !== '');
}

// Search results
algoliaHelper.on('result', function(content, state) {
  renderHits(content);
});

function renderHits(content) {
  $hits.html(hitTemplate.render(content));
}

}
