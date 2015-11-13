class AmazonProxy


  def self.import_book(asin)
    item = fetch(asin)
    save_book asin, item
  end

  def self.save_book(asin, item)
    return if Book.exists?(asin: asin)

    options                    = {}
    image_url                  = item.get_hash('MediumImage')['URL']
    item_attributes            = item.get_element('ItemAttributes')
    options[:asin]             = asin
    options[:title]            = item_attributes.get('Title')
    options[:published_at]     = item_attributes.get('PublicationDate')
    options[:author]           = item_attributes.get_array('Author').join(', ')
    options[:amazon_image_url] = image_url
    options[:publisher]        = item_attributes.get('Publisher')
    options[:page_number]      = item_attributes.get('NumberOfPages')
    options[:isbn]             = item_attributes.get('ISBN')

    # options[:image_url]        = save_image(asin, image_url)
    Book.create! options
  end

  private
  def self.fetch(asin)
    result = Amazon::Ecs.item_lookup(asin, { :response_group => 'Medium' })
    result.items[0]
  end
end
