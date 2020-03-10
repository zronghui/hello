from django.test import TestCase


# Create your tests here.
# 类名无所谓
class ATestClass(TestCase):
    # 测试方法以 test 开头
    def test_aTestMethod(self):
        self.assertEquals([1, 2, 3], [1, 2, 3])
