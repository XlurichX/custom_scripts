#!/usr/bin/python3
# v.0.3
# req. selenium, firefox
import time
import logging
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.firefox.webdriver import WebDriver

# func for read domains in CSV
def read_domains_from_csv(file_path):
    with open(file_path, 'r') as file:
        return [line.strip() for line in file]

# load domains 
domains = read_domains_from_csv("domain.csv")

def auto_purchase_test(domain):
    options = webdriver.FirefoxOptions() # web driver set FireFox
    # disable window browse
    # options.add_argument('--headless')

    #logging    
    logging.basicConfig(filename='buy.log', level=logging.INFO, format='%(asctime)s - %(message)s' )

    # proxy
    #options.add_argument('--proxy-server=socks5://ip:port')
    
    driver = webdriver.Firefox(options=options)
    
    try:
        # Load domain
        driver.get(f"https://{domain}")
        # move to card product apple
        select_item = WebDriverWait(driver, 20).until(
            EC.element_to_be_clickable((By.XPATH, "//a[contains(@href, '/product/product=apple')]"))
        )
        select_item.click()

        # add to card         
        add_order_button = WebDriverWait(driver, 10).until(
	    EC.element_to_be_clickable((By.XPATH, "//div[@id='12']/div[2]/a/span[2]"))
        )
        add_order_button.click()

        # go to shopping cart
        go_shopping = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.XPATH, "//a[contains(.,'ShopCart')]"))
        )
        go_shopping.click()

        # Email
        e_mail_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "e-mail"))
        )
        e_mail_element.send_keys("test@test.mail")

        # FirstName
        first_name_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "First_Name"))
        )
        first_name_element.send_keys("First Name")
        
        # LastNmae
        last_name_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "Last_Name"))
        )
        last_name_element.send_keys("Last Name")

        # Address
        shipp_addr_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "Ship_Address"))
        )
        shipp_addr_element.send_keys("Ozie St, ap. 77")

        # Country
        shipp_country_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "Your_Country"))
        )
        shipp_country_element.send_keys("Ukraine")
        # City
        shipp_city_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "Your_City"))
        )
        shipp_city_element.send_keys("Kyiv")

        # ZipCode
        shipp_zip_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "Zip_code"))
        )
        shipp_zip_element.send_keys("0404")

        # Phone
        shipp_mphone_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "Mobile_phone"))
        )
        shipp_mphone_element.send_keys("+3800000000")

        #Continue to paym
        continue_to_pay_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.XPATH, "//span[contains(.,'Go to pay')]"))
       )
        continue_to_pay_element.click()

        # Card Number
        number_of_card_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "Card_Number"))
        )
        number_of_card_element.send_keys("0404 0404 0404 0404")

        # Expire card
        card_exp_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "Date_EXP_M_Y"))
        )
        card_exp_element.send_keys("12 / 24")

        # Card CVV
        card_cvv_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "CVV_code"))
        )
        card_cvv_element.send_keys("404")

        # Date Birthday day
        date_birth_d_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "Birth_Day_day"))
        )
        date_birth_d_element.send_keys("12")

        # Date Birthday month
        date_birth_m_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "Birth_Day_mon"))
        )
        date_birth_m_element.send_keys("12")

        # Date Birthday year
        date_birth_y_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "Birth_Day_year"))
        )
        date_birth_y_element.send_keys("2404")

        # Place order
        place_order_ship = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.XPATH, "//span[contains(.,'Get my order now')]"))
        )
        place_order_ship.click()

        # time for load
        time.sleep(15)
        
        # check success order
        success_message = driver.find_element(By.CLASS_NAME, "order__date").text
        if success_message:
            logging.info(f"Order in {domain} sucessfull")
            print(f"Order in {domain} sucessfull")
        else:
            logging.info(f"Order Error in {domain}")
            print(f"Order Error in {domain}")
        
        # for unknow error 
    except Exception as e:
        logging.error(f"Error: {e}")
        print(f"order (domain) UNKOWN Error")        
        
    finally:
        # Close browser
        driver.quit()

# go to next domain 
for domain in domains:
    auto_purchase_test(domain)

