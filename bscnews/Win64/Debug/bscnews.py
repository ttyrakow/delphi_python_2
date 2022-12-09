from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as cond
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time
from selenium.webdriver.edge.options import Options
from selenium.webdriver.edge.service import Service
import subprocess
from delphi_module import form

def get_news(url):

    form.setStatus('Initializing Selenium')
    srv = Service()
    srv.creation_flags += subprocess.CREATE_NO_WINDOW

    opts = Options()
    opts.add_argument("headless")

    driver = webdriver.Edge(options=opts, service=srv)

    form.setStatus(f'Fetching {url}')
    driver.get(url)

    form.setStatus('Waiting for page to render')
    try:
        WebDriverWait(driver, 15.0).until(
            cond.presence_of_element_located(
                (By.CSS_SELECTOR, "div.details-wrap")
            )
        )
        body = driver.find_element(By.CSS_SELECTOR, "body")
        body.send_keys(Keys.END)
        time.sleep(1)

        # all content present

        divs = driver.find_elements(By.CSS_SELECTOR, "div.details-wrap")
        news = [] # empty list

        form.setStatus('Decoding page content')
        for div in divs:
            item = {} # empty dict
            item["url"] = div.find_element(By.CSS_SELECTOR, "a.link-to-post").get_attribute("href")
            item["headline"] = div.find_element(By.CSS_SELECTOR, "h2").text
            item["description"] = div.find_element(By.CSS_SELECTOR, "div.excerpt > p").text
            news.append(item)
        return news
    finally:
        form.setStatus('Waiting for Selenium to shut down')
        driver.quit();
