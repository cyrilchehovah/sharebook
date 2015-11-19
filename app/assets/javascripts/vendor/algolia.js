function initialize_algolia_search() {
  console.log("test");

// Replace with your own values
var APPLICATION_ID = 'LNZ38F4R3P';
var SEARCH_ONLY_API_KEY = $("#js-algolia-metas").data('algolia-search-api-key');
var INDEX_NAME = 'Book' + $("#js-algolia-metas").data('algolia-suffix');
var PARAMS = {
  hitsPerPage: 10,
  maxValuesPerFacet: 8,
  facets: ['type'],
  disjunctiveFacets: ['category', 'brand', 'price']
  };
  var FACETS_SLIDER = ['price'];
  var FACETS_ORDER_OF_DISPLAY = ['category', 'brand', 'price', 'type'];
  var FACETS_LABELS = {categories: 'Category', brand: 'Brand', price: 'Price', type: 'Type'};

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


//On document Ready
$searchInput
var query = $(this).val()
toggleIconEmptyInput(query)

var category = $('#hits').data('category');

if (category.length) {
  algoliaHelper.toggleRefine('category', category).setQuery(query).setQueryParameter('aroundLatLngViaIP', true).setQueryParameter('aroundRadius', 50000).search();
}
else {
  algoliaHelper.setQuery(query).setQueryParameter('aroundLatLngViaIP', true).setQueryParameter('aroundRadius', 50000).search();
}

// algoliaHelper.setQuery(query).setQueryParameter('aroundLatLngViaIP', true).setQueryParameter('aroundRadius', 50000).search()

// Input binding
$searchInput
.on('keyup', function() {
  var query = $(this).val();
  toggleIconEmptyInput(query);
  algoliaHelper.setQuery(query).setQueryParameter('aroundLatLngViaIP', true).setQueryParameter('aroundRadius', 50000).search()
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
  renderFacets(content, state);
  handleNoResults(content);
});

function renderHits(content) {
  $hits.html(hitTemplate.render(content));
}


function renderFacets(content, state) {
  var facetsHtml = '';
  var facetName = 'category';
  var facetResult = content.getFacetByName(facetName);
  var facetContent = {};
  if (facetResult)   if (facetResult) {
    facetContent = {
      facet: facetName,
      title: FACETS_LABELS[facetName],
      values: content.getFacetValues(facetName, {sortBy: ['isRefined:desc', 'count:desc']}),
      disjunctive: $.inArray(facetName, PARAMS.disjunctiveFacets) !== -1
    };
    facetsHtml += facetTemplate.render(facetContent);
  }
  $facets.html(facetsHtml);
}

$(document).on('click', '.toggle-refine', function(e) {
  e.preventDefault();
  algoliaHelper.toggleRefine($(this).data('facet'), $(this).data('value')).search();
});

// NO RESULTS
// ==========

function handleNoResults(content) {
  if (content.nbHits > 0) {
    $main.removeClass('no-results');
    return;
  }
  $main.addClass('no-results');

  var filters = [];
  var i;
  var j;
  for (i in algoliaHelper.state.facetsRefinements) {
    filters.push({
      class: 'toggle-refine',
      facet: i, facet_value: algoliaHelper.state.facetsRefinements[i],
      label: FACETS_LABELS[i] + ': ',
      label_value: algoliaHelper.state.facetsRefinements[i]
    });
  }
  for (i in algoliaHelper.state.disjunctiveFacetsRefinements) {
    for (j in algoliaHelper.state.disjunctiveFacetsRefinements[i]) {
      filters.push({
        class: 'toggle-refine',
        facet: i,
        facet_value: algoliaHelper.state.disjunctiveFacetsRefinements[i][j],
        label: FACETS_LABELS[i] + ': ',
        label_value: algoliaHelper.state.disjunctiveFacetsRefinements[i][j]
      });
    }
  }
  for (i in algoliaHelper.state.numericRefinements) {
    for (j in algoliaHelper.state.numericRefinements[i]) {
      filters.push({
        class: 'remove-numeric-refine',
        facet: i,
        facet_value: j,
        label: FACETS_LABELS[i] + ' ',
        label_value: j + ' ' + algoliaHelper.state.numericRefinements[i][j]
      });
    }
  }
  $hits.html(noResultsTemplate.render({query: content.query, filters: filters}));
}

}
