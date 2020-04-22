# Generated by Selenium IDE
import time

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys


class TestTest():
    def setup_method(self, method):
        self.driver = webdriver.Chrome()
        self.vars = {}

    def teardown_method(self, method):
        self.driver.quit()

    def wait_for_window(self, timeout=2):
        time.sleep(round(timeout / 1000))
        wh_now = self.driver.window_handles
        wh_then = self.vars["window_handles"]
        if len(wh_now) > len(wh_then):
            return set(wh_now).difference(set(wh_then)).pop()

    def test_test(self):
        self.driver.get("https://www.jianshu.com/p/7e9e2393cf76")
        self.driver.set_window_size(1500, 925)
        self.driver.find_element(By.CSS_SELECTOR, ".\\_2q13cl").click()
        self.driver.find_element(By.CSS_SELECTOR, ".\\_2q13cl").send_keys("test")
        self.vars["window_handles"] = self.driver.window_handles
        self.driver.find_element(By.CSS_SELECTOR, ".\\_2q13cl").send_keys(Keys.ENTER)
        self.vars["win7143"] = self.wait_for_window(2000)
        self.driver.switch_to.window(self.vars["win7143"])
        self.vars["window_handles"] = self.driver.window_handles
        self.driver.find_element(By.LINK_TEXT, "对于COVID-19，WHO连用test,test,test!").click()
        self.vars["win3964"] = self.wait_for_window(2000)
        self.driver.switch_to.window(self.vars["win3964"])
        self.driver.find_element(By.CSS_SELECTOR, ".\\_3kba3h > span").click()
        self.driver.execute_script("window.scrollTo(0,1660)")
        self.driver.execute_script("window.scrollTo(0,5315.45458984375)")
