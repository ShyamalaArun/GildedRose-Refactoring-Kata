defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  @aged_brie "Aged Brie"
  @backstage_passes "Backstage passes to a TAFKAL80ETC concert"
  @sulfuras "Sulfuras, Hand of Ragnaros"
  @conjured "Conjured"
  @min_quality_default 0
  @max_quality_default 50
  @max_quality_sulfuras 80
  @default_degrade 1

  defguardp is_aged_brie(item) when item.name === @aged_brie
  defguardp is_backstage_passes(item) when item.name === @backstage_passes
  defguardp is_sulfuras(item) when item.name === @sulfuras
  defguardp is_conjured(item) when item.name === @conjured
  defguardp is_default(item) when item.name !== @aged_brie and item.name !== @backstage_passes 
                            and item.name !== @sulfuras and item.name !== @conjured

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  defp update_item(item) when is_default(item) do
    if item.sell_in < 0, 
      do: %{item | quality: item.quality - (2 * @default_degrade)},
      else: %{item | quality: item.quality - @default_degrade}
        |> restrict_quality
        |> update_sell_in
  end

  defp update_item(item) when is_sulfuras(item) do
    %{item | quality: @max_quality_sulfuras}
  end

  defp update_item(item) when is_aged_brie(item) do
    %{item | quality: item.quality + 1}
      |> restrict_quality
      |> update_sell_in
  end

  defp update_item(item) when is_conjured(item) do
    if item.sell_in < 0, 
      do: %{item | quality: item.quality - (4 * @default_degrade)},
      else: %{item | quality: item.quality - (2 * @default_degrade)}
        |> restrict_quality
        |> update_sell_in
  end

  defp update_item(item) when is_backstage_passes(item) do
    cond do
      item.sell_in > 10 ->
        %{item | quality: item.quality + 1}
      item.sell_in in 6..10 ->
        %{item | quality: item.quality + 2}
      item.sell_in in 0..5 ->
        %{item | quality: item.quality + 3}
      item.sell_in < 0 ->
        %{item | quality: 0}
    end
      |> restrict_quality
      |> update_sell_in
  end

  defp update_sell_in(item) do
    %{item | sell_in: item.sell_in - 1}
  end

  defp restrict_quality(item) do
    cond do
      item.quality > @max_quality_default -> %{item | quality: 50}
      item.quality < @min_quality_default -> %{item | quality: 0}
      true -> item
    end
  end
end
