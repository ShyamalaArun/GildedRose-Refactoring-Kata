export class Item {
  name: string;
  sellIn: number;
  quality: number;

  constructor(name, sellIn, quality) {
    this.name = name;
    this.sellIn = sellIn;
    this.quality = quality;
  }
}

export class GildedRose {
  items: Array<Item>;
  AGED_BRIE = 'Aged Brie';
  BACKSTAGE_PASSES = 'Backstage passes to a TAFKAL80ETC concert';
  SULFURAS = 'Sulfuras, Hand of Ragnaros';
  CONJURED = 'Conjured';
  MIN_QUALITY_DEFAULT: number = 0;
  MAX_QUALITY_DEFAULT = 50;
  MAX_QUALITY_SULFURAS = 80;
  DEFAULT_DEGRADE = 1;

  constructor(items: Item[] = []) {
    this.items = items;
  }

  updateQuality() {
    this.items.map((item: Item) => {
      switch (item.name) {
        case this.AGED_BRIE:
          item = this.updateAgedBrie(item);
          break;
        case this.SULFURAS:
          break;
        case this.BACKSTAGE_PASSES:
          item = this.updateBackstagePasses(item);
          break;
        case this.CONJURED:
          item = this.updateConjured(item);
          break;
        default:
          item = this.updateDefault(item);
      }
    });

    return this.items;
  }

  updateDefault(item: Item): Item {
    item.quality = item.sellIn < 0 ? item.quality - (2 * this.DEFAULT_DEGRADE) : item.quality - this.DEFAULT_DEGRADE;
    item.quality = this.restrictQuality(item.quality);
    item.sellIn = this.updateSellIn(item.sellIn);
    return item;
  }

  updateAgedBrie(item: Item): Item {
    item.quality = item.quality + 1;
    item.quality = this.restrictQuality(item.quality);
    item.sellIn = this.updateSellIn(item.sellIn);
    return item;
  }

  updateConjured(item: Item): Item {
    item.quality = item.sellIn < 0 ? item.quality - (4 * this.DEFAULT_DEGRADE) : item.quality - (2 * this.DEFAULT_DEGRADE);
    item.quality = this.restrictQuality(item.quality);
    item.sellIn = this.updateSellIn(item.sellIn);
    return item;
  }

  updateBackstagePasses(item: Item): Item {
    switch (true) {
      case item.sellIn >= 0 && item.sellIn <= 5:
        item.quality = item.quality + 3;
        break;
      case item.sellIn >= 6 && item.sellIn <= 10:
        item.quality = item.quality + 2;
        break;
      case item.sellIn > 10:
        item.quality = item.quality + 1;
        break;
      case item.sellIn < 0:
        item.quality = 0;
        break;
    }
    item.quality = this.restrictQuality(item.quality);
    item.sellIn = this.updateSellIn(item.sellIn);
    return item;
  }

  restrictQuality(quality: number): number {
    switch (true) {
      case (quality < this.MIN_QUALITY_DEFAULT):
        return this.MIN_QUALITY_DEFAULT;
      case (quality > this.MAX_QUALITY_DEFAULT):
        return this.MAX_QUALITY_DEFAULT;
      default:
        return quality;
    }
  }

  updateSellIn(sellIn: number): number {
    return sellIn - 1;
  }
}
