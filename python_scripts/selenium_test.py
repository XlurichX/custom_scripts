import logging
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# logging
logging.basicConfig(filename='actions.log', level=logging.INFO, format='%(asctime)s - %(message)s')

# webdriver & url
driver = webdriver.Firefox()
driver.get("https://domain.com")

try:
    # time out, wait
    element = WebDriverWait(driver, 60).until(
        EC.presence_of_element_located((By.ID, "example"))
    )
    # click test 
    button = driver.find_element(By.ID, "example_button")
    button.click()
    
    # click to log
    logging.info("Clicked on button with id 'example_button'")
    
finally:
    driver.quit()

