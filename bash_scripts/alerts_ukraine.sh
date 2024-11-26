#!/bin/bash
# Use for socks5
#proxy_address="0.0.0.0"
#proxy_port="1234"

# request API, use ur token <<token>>
response=$(curl -s "https://api.alerts.in.ua/v1/iot/active_air_raid_alerts_by_oblast.json?token=<<token>>")

# Use for socks5
#response=$(curl -s --socks5-hostname "$proxy_address:$proxy_port" "https://api.alerts.in.ua/v1/iot/active_air_raid_alerts_by_oblast.json?token=<<token>>")

# Use city number, UID

# 1 - AR. Crimea
# 2 - Volyn region
# 3 - Vinnytsia region
# 4 - Dnipropetrovsk region
# 5 - Donetsk region
# 6 - Zhytomyr region
# 7 - Zakarpattia region
# 8 - Zaporizhia region
# 9 - Ivano-Frankivsk region
#10 - Kyiv city
#11 - Kyiv region
#12 - Kirovohrad region
#13 - Luhansk region
#14 - Lviv region
#15 - Mykolaiv region
#16 - Odessa region
#17 - Poltava region
#18 - Rivne region
#19 - Sevastopol
#20 - Sumy region
#21 - Ternopil region
#22 - Kharkiv region
#23 - Kherson region
#24 - Khmelnytskyi region
#25 - Cherkasy region
#26 - Chernivtsi region
#26 - Chernihiv region

# Now set Kyiv, Kyiv region (10,11) 

first_char=${response:10:1}
second_char=${response:11:1}

# You can use only one City number (UID), set for first_chat and second_char same value

if [[ ( "$first_char" == "A" || "$first_char" == "P" ) && ( "$second_char" == "A" || "$second_char" == "P" ) ]]; then
    echo "ALERT Kyiv & oblast"
    cvlc /home/user/alert.mp3 2>/dev/null; pkill vlc
elif [[ "$first_char" == "A" || "$first_char" == "P" ]]; then
    echo "ALERT Kyiv"
    cvlc /home/user/alert.mp3 2>/dev/null; pkill vlc
elif [[ "$second_char" == "A" || "$second_char" == "P" ]]; then
    echo "ALERT Kyiv oblast"
    cvlc /home/user/alert.mp3 2>/dev/null; pkill vlc
elif [[ "$first_char" == "N" && "$second_char" == "N" ]]; then
    echo "No alerts"
else
    echo "Error alert status"
fi

