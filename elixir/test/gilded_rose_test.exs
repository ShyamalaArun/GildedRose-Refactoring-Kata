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
end
