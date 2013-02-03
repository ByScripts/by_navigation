require 'test_helper'

class ByNavigationTest < ActiveSupport::TestCase

  def setup
    ByNavigation::Configuration.new :main do

      item :level_1, "Level 1" do

        param :just_level_1, 'just-level-1'
        param :from_level_1_to_level_2, 'from-level-1-to-level-2', true
        param :from_level_1_to_level_4_skip_level_3, 'from-level-1-to-level-4-skip-level-3', true

        html_id 'level-one'

        item :level_2, "Level 2" do

          slug "second-level"

          item :level_3, "Level 3" do

            param :just_level_3, 'just-level-3'
            param :from_level_1_to_level_2, nil, true
            param :from_level_1_to_level_4_skip_level_3, nil

            html_class 'love-css3'

            url "level-3-is-root"

            item :level_4, "Level 4"
          end
        end
      end
    end

    @main = ByNavigation::Configuration.get_item(:main)
    @level1 = ByNavigation::Configuration.get_item(:main_level_1)
    @level2 = ByNavigation::Configuration.get_item(:main_level_1_level_2)
    @level3 = ByNavigation::Configuration.get_item(:main_level_1_level_2_level_3)
    @level4 = ByNavigation::Configuration.get_item(:main_level_1_level_2_level_3_level_4)
  end

  test "should have a level1 item" do
    assert @level1
  end

  test "should have a level2 item" do
    assert @level2
  end

  test "should have a level3 item" do
    assert @level3
  end

  test "should have a level4 item" do
    assert @level4
  end



  test "should have correct html_class for level1" do
    assert_equal 'main level-1', @level1.html_class
  end

  test "should have correct html_class for level2" do
    assert_equal 'main level-1 level-2', @level2.html_class
  end

  test "should have correct html_class for level3" do
    assert_equal 'main level-1 level-2 love-css3', @level3.html_class
  end

  test "should have correct html_class for level4" do
    assert_equal 'main level-1 level-2 love-css3 level-4', @level4.html_class
  end



  test "should have correct html_id for level1" do
    assert_equal 'main-level-one', @level1.html_id
  end

  test "should have correct html_id for level2" do
    assert_equal 'main-level-one-level-2', @level2.html_id
  end

  test "should have correct html_id for level3" do
    assert_equal 'main-level-one-level-2-level-3', @level3.html_id
  end

  test "should have correct html_id for level4" do
    assert_equal 'main-level-one-level-2-level-3-level-4', @level4.html_id
  end



  test "should have correct url for level1" do
    assert_equal '/level-1', @level1.url
  end

  test "should have correct url for level2" do
    assert_equal '/level-1/second-level', @level2.url
  end

  test "should have correct url for level3" do
    assert_equal '/level-3-is-root', @level3.url
  end

  test "should have correct url for level4" do
    assert_equal '/level-3-is-root/level-4', @level4.url
  end



  test "should have correct depth for level1" do
    assert_equal 1, @level1.depth
  end

  test "should have correct depth for level2" do
    assert_equal 2, @level2.depth
  end

  test "should have correct depth for level3" do
    assert_equal 3, @level3.depth
  end

  test "should have correct depth for level4" do
    assert_equal 4, @level4.depth
  end



  test "should have correct params for level1" do
    assert_equal 'just-level-1', @level1.param(:just_level_1)
    assert_equal 'from-level-1-to-level-2', @level1.param(:from_level_1_to_level_2)
    assert_equal 'from-level-1-to-level-4-skip-level-3', @level1.param(:from_level_1_to_level_4_skip_level_3)
  end

  test "should have correct params for level2" do
    assert_equal nil, @level2.param(:just_level_1)
    assert_equal 'from-level-1-to-level-2', @level2.param(:from_level_1_to_level_2)
    assert_equal 'from-level-1-to-level-4-skip-level-3', @level2.param(:from_level_1_to_level_4_skip_level_3)
  end

  test "should have correct params for level3" do
    assert_equal nil, @level3.param(:just_level_1)
    assert_equal nil, @level3.param(:from_level_1_to_level_2)
    assert_equal nil, @level3.param(:from_level_1_to_level_4_skip_level_3)
    assert_equal 'just-level-3', @level3.param(:just_level_3)
  end

  test "should have correct params for level4" do
    assert_equal nil, @level4.param(:just_level_1)
    assert_equal nil, @level4.param(:from_level_1_to_level_2)
    assert_equal nil, @level4.param(:just_level_3)
    assert_equal 'from-level-1-to-level-4-skip-level-3', @level4.param(:from_level_1_to_level_4_skip_level_3)
  end



  test "should give main item by default, if id argument is omitted" do
    assert_same @main, ByNavigation::Configuration.get_item
  end



  test "should be able to retrieve an item by url" do
    assert_equal @main, ByNavigation::Configuration.get_item('/')
    assert_equal @level1, ByNavigation::Configuration.get_item('/level-1')
    assert_equal @level2, ByNavigation::Configuration.get_item('/level-1/second-level')
    assert_equal @level3, ByNavigation::Configuration.get_item('/level-3-is-root')
    assert_equal @level4, ByNavigation::Configuration.get_item('/level-3-is-root/level-4')
  end
end
