# -*- coding: utf-8 -*-
import scrapy

from helloScrapy.items import BookItem


class ShudanSpider(scrapy.Spider):
    name = 'shudan'
    allowed_domains = ['shudan.vip', 'pan.shudan.vip']
    start_urls = [f'https://www.shudan.vip/page/{i}' for i in range(1, 16873)]
    start_urls.extend(f'https://pan.shudan.vip/page/{i}' for i in range(1, 749))

    def parse(self, response):
        item = BookItem()
        item['book_url'] = response.css('.block-title a::attr(href)').extract_first()
        item['book_name'] = response.css('.block-title a::text').extract_first()
        yield item
