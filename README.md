# Tire Multisort

`multi_sort` extended tire `sort` with some abilities

## Installation

Add this line to your application's Gemfile:

    gem 'tire-multisort'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tire-multisort

## Usage

```ruby
 multi_sort sort, order do
   by_default :premium

   by :date

   by :name,      :title
   by :rating,    :subject_rating
   by :relevance, :_score
   by :category,  :category_name
   by :distance,  :_geo_distance, location: "test", unit: 'mi'
   by :premium,   :premium, :desc

   by_collection  :category,  :category, :name
   by_collection  :premium,   :premium, :relevance, :name
 end
```

## Checkpoints

- `multi sort` - accept `sort` argument as string `name,rating,date` which
  will be translated to propper sorting field

- `auto order`

  ```ruby
    # multi_sort
    by :date
  ```

  ```ruby
    # sort
    by :date, order
  ```

- `auto check` - run sort just from `collection`, `default` or from `sort` param

  ```ruby
    # multi_sort
    by :date
  ```

  ```ruby
    # sort
    if sort == :date
      by :date, order
    end
  ```


- `aliasing`

  ```ruby
    # multi_sort
    by :name, :title
  ```

  ```ruby
    # sort
    if sort == :name
      by :title, order
    end
  ```

- `collections` - group fiew sort fields to sort collection

  ```ruby
    # multi_sort
    by_collection  :category,  :category, :name
  ```

  ```ruby
    # sort
    if sort == :category
      by :category, order
      by :name, order
    end
  ```

- `default` - is used if passed sort param is incorrect or missed

  ```ruby
    by_default :premium
  ```

## Contributing

1. Fork it ( http://github.com/igor04/tire-multisort/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
