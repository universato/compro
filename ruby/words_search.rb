class Words < Array
  def fuzzy_find(search_word)
    words = sort
    result_word = words.bsearch{ |w| w >= search_word }
    result_word&.start_with?(search_word) ? result_word : nil
  end
end

class VersionArray < Array
  include Comparable
end

class Versions < Array
  include Comparable
  #[TODO]
  def fuzzy_find(search_version)
    versions = sort
    search_version_ary = search_version.split('.')
    result_version = versions.bsearch{ |w| VersionArray.new(w.split('.')) >= search_version_ary }
    result_version&.start_with?(search_version) ? result_version : nil
  end

  def fuzzy_find(search_version)
    versions = sort
    idx = versions.bsearch_index{ |v| v >= search_version }
    idx += 1 while versions[idx + 1]&.start_with?(search_version)
    result_version = versions[idx]
    result_version && (result_version&.start_with?(search_version) ? result_version : nil)
  end
end

require 'minitest'
require 'minitest/autorun'

class SearchTest < Minitest::Test
  def test_fuzzy_find
    words = Words['ruby', 'mruby', 'cpp', 'c', 'crystal', 'c#', 'c++', 'rust']
    assert_equal 'ruby', words.fuzzy_find('ruby')
    assert_equal 'mruby', words.fuzzy_find('mruby')
    assert_equal 'crystal', words.fuzzy_find('crystal')
    assert_equal 'rust', words.fuzzy_find('rust')

    assert_equal 'ruby', words.fuzzy_find('r')
    assert_equal 'ruby', words.fuzzy_find('ru')
    assert_equal 'ruby', words.fuzzy_find('rub')

    assert_equal 'rust', words.fuzzy_find('rus')
    assert_equal 'c++', words.fuzzy_find('c+')
    assert_equal 'c++', words.fuzzy_find('c+')

    assert_nil words.fuzzy_find('x')
    assert_nil words.fuzzy_find('$')
    assert_nil words.fuzzy_find('rubyx')
  end

  def test_version
    words = Versions['0.0.1', '0.0.5', '0.2.4', '1.2.5', '1.9.3', '2.5.0', '2.5.1', '2.5.8', '2.6.6', '2.7.0', '2.7.1', '2.7.2', '3.0.0']
    assert_equal '2.7.0', words.fuzzy_find('2.7.0')
    assert_equal '2.7.1', words.fuzzy_find('2.7.1')
    assert_equal '2.7.2', words.fuzzy_find('2.7.2')
    assert_equal '3.0.0', words.fuzzy_find('3.0.0')

    assert_equal '2.7.2', words.fuzzy_find('2.7')
    assert_equal '2.5.8', words.fuzzy_find('2.5')
    assert_equal '2.6.6', words.fuzzy_find('2.6')
    assert_equal '2.7.2', words.fuzzy_find('2')
    assert_equal '1.9.3', words.fuzzy_find('1.9')
    assert_equal '1.9.3', words.fuzzy_find('1')

    # assert_nil words.fuzzy_find('3.4')
  end
end
