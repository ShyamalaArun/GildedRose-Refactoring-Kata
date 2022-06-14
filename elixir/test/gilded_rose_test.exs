defmodule GildedRoseTest do
  use ExUnit.Case

  test "Aged Brie: check if quality increases" do
    items = [%Item{name: "Aged Brie", sell_in: 0, quality: 25}]
    updated_list = GildedRose.update_quality(items)
    %{quality: quality} = List.first(updated_list)
    assert 26 == quality
  end

  test "Aged Brie: check if quality does not exceed 50" do
    items = [%Item{name: "Aged Brie", sell_in: 0, quality: 50}]
    updated_list = GildedRose.update_quality(items)
    %{quality: quality} = List.first(updated_list)
    assert 50 == quality
  end

  test "Aged Brie: check if sell in day decreases" do
    items = [%Item{name: "Aged Brie", sell_in: 10, quality: 25}]
    updated_list = GildedRose.update_quality(items)
    %{sell_in: sell_in} = List.first(updated_list)
    assert 9 == sell_in
  end

  test "Sulfuras: check if sell_in is unchanged" do
    items = [%Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 10, quality: 25}]
    updated_list = GildedRose.update_quality(items)
    %{sell_in: sell_in} = List.first(updated_list)
    assert 10 == sell_in
  end

  test "Sulfuras: check if quality is 80" do
    items = [%Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 10, quality: 80}]
    updated_list = GildedRose.update_quality(items)
    %{quality: quality} = List.first(updated_list)
    assert 80 == quality
  end

  test "Backstage passes: check if quality is set to 0" do
    items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: -1, quality: 11}]
    updated_list = GildedRose.update_quality(items)
    %{quality: quality} = List.first(updated_list)
    assert 0 == quality
  end

  test "Backstage passes: check if quality reduces by 1" do
    items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 11}]
    updated_list = GildedRose.update_quality(items)
    %{quality: quality} = List.first(updated_list)
    assert 12 == quality
  end

  test "Backstage passes: check if quality reduces by 2" do
    items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 20}]
    updated_list = GildedRose.update_quality(items)
    %{quality: quality} = List.first(updated_list)
    assert 22 == quality
  end

  test "Backstage passes: check if quality reduces by 3" do
    items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 30}]
    updated_list = GildedRose.update_quality(items)
    %{quality: quality} = List.first(updated_list)
    assert 33 == quality
  end

  test "Backstage passes: check if sell in day decreases" do
    items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 25}]
    updated_list = GildedRose.update_quality(items)
    %{sell_in: sell_in} = List.first(updated_list)
    assert 9 == sell_in
  end

  test "Backstage passes: check if quality does not exceed 50" do
    items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 50}]
    updated_list = GildedRose.update_quality(items)
    %{quality: quality} = List.first(updated_list)
    assert 50 == quality
  end
end
