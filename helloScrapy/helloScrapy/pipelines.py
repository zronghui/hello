# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html
import json


class HelloscrapyPipeline(object):
    """
    处理爬虫所爬取到的数据
    """

    def __init__(self):
        """
        初始化操作，在爬虫运行过程中只执行一次
        """
        self.file = open('books.json', 'a', encoding='utf-8')

    def process_item(self, item, spider):
        # 现将item数据转为字典类型，再将其保存为json文件
        text = json.dumps(dict(item), ensure_ascii=False) + '\n'
        # 写入本地
        self.file.write(text)
        # 会将item打印到屏幕上，方便观察
        return item

    def close_spider(self, spider):
        """
        爬虫关闭时所执行的操作，在爬虫运行过程中只执行一次
        """
        self.file.close()
