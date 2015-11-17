
// -----------------------------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------------------------

var fill_and_submit_book_form = function() {
  // On récupère le "data-book", on remet les caractères spéciaux, et on transforme la string en un hash javascript
  var data = JSON.parse(unescape($(".card-container").data("book")));

  // Vis ta vis de vinaigrette
  $('#book_title'      ).val(data.title);
  $('#book_subtitle'   ).val(data.subtitle);
  $('#book_description').val(data.description);
  $('#book_image'      ).val(data.image);
  $('#book_author'     ).val(data.author);
  $('#book_publisher'  ).val(data.publisher);
  $('#book_isbn_10'    ).val(data.isbn_10);
  setTimeout(function() {
    $('#new_book').submit();
  }, 500);
};

var create_book_result_list = function(data) {
// Premièrement : effacement du HTML
  $('#results').html('');
  for( i = 0; i < data.items.length; i++) {
    var volInfo = data.items[i].volumeInfo;
    // On récupère toutes les infos et on en fait un beau hash
    // console.log(data.items[i].volumeInfo);
    // console.log(volInfo.industryIdentifiers)

    var bookInfo = {
      title:        volInfo.title,
      subtitle:     volInfo.subtitle,
      description:  volInfo.description,
      image:        (volInfo.imageLinks) ? volInfo.imageLinks.thumbnail : "http://placehold.it/350x150",
      author:       (volInfo.authors  )  ? volInfo.authors[  0] : "",
      publisher:    (volInfo.publisher)  ? volInfo.publisher[0] : "",
      isbn_10:       ""
    };
    if (volInfo.industryIdentifiers) {
      for( j=0; j < volInfo.industryIdentifiers.length ; j++) {
        if( volInfo.industryIdentifiers[j].type == "ISBN_10") {
          bookInfo["isbn_10"] = volInfo.industryIdentifiers[j].identifier
        }
      }
    } else {
      bookInfo["isbn_10"]     = "";
    }

    // On prend notre beau hash et on échappe les caractères spéciaux (""), on le transforme en string et on
    // le met dans notre HTML dans un attribut "data-book"
    // Pour chaque résultat on crée le HTML et on le place sans l'élément #results
    $('#results').append(
      '<div class="card-container" data-toggle="modal" data-target="#myModal" data-book="' + escape(JSON.stringify(bookInfo)) + '" id="result_' + i + '">' +
        '<hr>' +
        '<div class="row">' +
          '<div class ="col-xs-offset-1 col-xs-2">' +
          '<img src="' + bookInfo.image + '" alt="book-cover" class="result-img img-responsive">' +
        '</div>' +
        '<div class ="col-xs-9 result-infos">' +
          '<h3>' +
            bookInfo.title +
          '</h3>' +
          '<h4>' +
            bookInfo.author +
          '</h4>' +
        '</div>' +
      '</div>'
    )
  }

  function open_modal(index) {
    // Premièrement : effacement du HTML
    $('.modal-body').html('');

    var volInfo = data.items[index].volumeInfo;

    var bookInfo = {
      title:        volInfo.title,
      subtitle:     volInfo.subtitle,
      description:  volInfo.description,
      image:        (volInfo.imageLinks) ? volInfo.imageLinks.thumbnail : "http://placehold.it/350x150",
      author:       (volInfo.authors  )  ? volInfo.authors[  0] : "",
      publisher:    (volInfo.publisher)  ? volInfo.publisher[0] : "",
      isbn_10:       ""
    };

    var modalBody = '<div class="card-container" data-toggle="modal" data-target="#myModal">' +
                      '<div class="row">' +
                        '<div class ="col-xs-offset-1 col-xs-2">' +
                          '<img src="' + bookInfo.image + '" alt="book-cover" class="result-img img-responsive">' +
                        '</div>' +
                      '<div class ="col-xs-9 result-infos">' +
                        '<h3>' +
                          bookInfo.title +
                        '</h3>' +
                        '<h4>' +
                          bookInfo.author +
                        '</h4>' +
                      '</div>' +
                    '</div>'
    $('.modal-body').html(modalBody)
  };

  $(".card-container").on('click', function() {
    var id = $(this).attr('id').slice($(this).attr('id').lastIndexOf('_') + 1)
    open_modal(id);
  })

  $("#submit_book_form").on('click', fill_and_submit_book_form);
}





// -----------------------------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------------------------
var search_book = function() {
  // Je stocke la chaine de recherche entrée par l'utilisateur.
  var search_string = $("#book-title").val();

  // Cas 1 : la chaine est vide : on efface le HTML
  if (search_string.length == 0) {
    $('#results').html('');
    return;
  }

  // Cas 2, chaine non vide, on lance une recherche en Ajax.

  $.ajax({
    type: "GET",
    url: "https://www.googleapis.com/books/v1/volumes?q=" + $(this).val() + "&key=" + global_google_api_key,
    success: create_book_result_list,
    error:   function(data) {
     console.log('Some error occurred');
   }
  });
}




