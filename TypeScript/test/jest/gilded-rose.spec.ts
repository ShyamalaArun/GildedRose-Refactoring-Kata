import { Item, GildedRose } from '@/gilded-rose';

describe('Gilded Rose', () => {
  it('Aged Brie: check if quality increases', () => {
    const gildedRose = new GildedRose([new Item('Aged Brie', 0, 25)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(26);
  });

  it('Aged Brie: check if quality does not exceed 50', () => {
    const gildedRose = new GildedRose([new Item('Aged Brie', 5, 50)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(50);
  });

  it('Aged Brie: check if quality does not go negative', () => {
    const gildedRose = new GildedRose([new Item('Aged Brie', 5, -1)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(0);
  });

  it('Aged Brie: check if sell in decreases', () => {
    const gildedRose = new GildedRose([new Item('Aged Brie', 5, -1)]);
    const items = gildedRose.updateQuality();
    expect(items[0].sellIn).toBe(4);
  });

  it('Sulfuras: check if sell_in is unchanged', () => {
    const gildedRose = new GildedRose([new Item('Sulfuras, Hand of Ragnaros', 5, 25)]);
    const items = gildedRose.updateQuality();
    expect(items[0].sellIn).toBe(5);
  });

  it('Sulfuras: check if quality is 80', () => {
    const gildedRose = new GildedRose([new Item('Sulfuras, Hand of Ragnaros', 5, 80)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(80);
  });

  it('Backstage passes: check if quality is set to 0', () => {
    const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', -1, 1)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(0);
  });

  it('Backstage passes: check if quality increases by 1', () => {
    const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 15, 11)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(12);
  });

  it('Backstage passes: check if quality increases by 2', () => {
    const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 10, 20)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(22);
  });

  it('Backstage passes: check if quality increases by 3', () => {
    const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 0, 30)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(33);
  });

  it('Backstage passes: check if quality does not exceed 50', () => {
    const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 10, 50)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(50);
  });

  it('Backstage passes: check if sell in day decreases', () => {
    const gildedRose = new GildedRose([new Item('Backstage passes to a TAFKAL80ETC concert', 10, 25)]);
    const items = gildedRose.updateQuality();
    expect(items[0].sellIn).toBe(9);
  });

  it('Conjured: check if quality reduces', () => {
    const gildedRose = new GildedRose([new Item('Conjured', 5, 30)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(28);
  });

  it('Conjured: check if quality reduces twice', () => {
    const gildedRose = new GildedRose([new Item('Conjured', -5, 30)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(26);
  });

  it('Conjured: check if quality is not negative', () => {
    const gildedRose = new GildedRose([new Item('Conjured', 10, 1)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(0);
  });

  it('Conjured: check if sell in day decreases', () => {
    const gildedRose = new GildedRose([new Item('Conjured', 10, 25)]);
    const items = gildedRose.updateQuality();
    expect(items[0].sellIn).toBe(9);
  });

  it('Default: check if quality reduces', () => {
    const gildedRose = new GildedRose([new Item('Default', 5, 30)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(29);
  });

  it('Default: check if quality reduces twice', () => {
    const gildedRose = new GildedRose([new Item('Default', -5, 30)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(28);
  });

  it('Default: check if quality is not negative', () => {
    const gildedRose = new GildedRose([new Item('Default', -10, 1)]);
    const items = gildedRose.updateQuality();
    expect(items[0].quality).toBe(0);
  });

  it('Default: check if sell in day decreases', () => {
    const gildedRose = new GildedRose([new Item('Default', 10, 11)]);
    const items = gildedRose.updateQuality();
    expect(items[0].sellIn).toBe(9);
  });
});
