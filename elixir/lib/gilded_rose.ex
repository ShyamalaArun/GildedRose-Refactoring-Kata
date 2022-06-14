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

  def update_quality(items) do
    Enum.map(items, &update_item/1)
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
    %{item | quality: item.quality - (2 * @default_degrade)}
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

  def update_item_original(item) do
    item = cond do
      item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
        if item.quality > 0 do
          if item.name != "Sulfuras, Hand of Ragnaros" do
            %{item | quality: item.quality - 1}
          else
            item
          end
        else
          item
        end
      true ->
        cond do
          item.quality < 50 ->
            item = %{item | quality: item.quality + 1}
            cond do
              item.name == "Backstage passes to a TAFKAL80ETC concert" ->
                item = cond do
                  item.sell_in < 11 ->
                    cond do
                      item.quality < 50 ->
                        %{item | quality: item.quality + 1}
                      true -> item
                    end
                  true -> item
                end
                cond do
                  item.sell_in < 6 ->
                    cond do
                      item.quality < 50 ->
                        %{item | quality: item.quality + 1}
                      true -> item
                    end
                  true -> item
                end
              true -> item
            end
          true -> item
        end
    end
    item = cond do
      item.name != "Sulfuras, Hand of Ragnaros" ->
        %{item | sell_in: item.sell_in - 1}
      true -> item
    end
    cond do
      item.sell_in < 0 ->
        cond do
          item.name != "Aged Brie" ->
            cond do
              item.name != "Backstage passes to a TAFKAL80ETC concert" ->
                cond do
                  item.quality > 0 ->
                    cond do
                      item.name != "Sulfuras, Hand of Ragnaros" ->
                        %{item | quality: item.quality - 1}
                      true -> item
                    end
                  true -> item
                end
              true -> %{item | quality: item.quality - item.quality}
            end
          true ->
            cond do
              item.quality < 50 ->
                %{item | quality: item.quality + 1}
              true -> item
            end
        end
      true -> item
    end
  end
end
