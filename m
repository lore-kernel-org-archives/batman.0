Return-Path: <xbing6@gmail.com>
From: Xuebing Wang <xbing6@gmail.com>
Message-ID: <79817dd4-1fb2-a491-fa9f-9056906cab00@gmail.com>
Date: Mon, 26 Mar 2018 17:02:42 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [B.A.T.M.A.N.] [hostapd] [batman-adv] Is dot11RSNAConfigPMKLifetime
 the correct setting to configure IBSS reauth timer?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: hostap@lists.infradead.org
Cc: j@w1.fi, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>, mareklindner@neomailbox.ch

Hi community,

We have batman-adv mesh network of 136 nodes perfectly running for about 
6 months.

Our configure is:
- OpenWRT tag 15.05.1
- wpa_supplicant hostap_2_4
- 802.11 IBSS
- proto=WPA2
- key_mgmt=WPA-PSK
- pairwise=CCMP
- group=CCMP

The minor issue we have is that memory is fragmented after running 6 
months for a large network of 136 nodes. I am speculating that it is 
because of the periodical RNSA  reauthentication.

If I read 802.11 spec "11.5.10 RSNA authentication in an IBSS" 
correctly, there is reauth timer.  Is dot11RSNAConfigPMKLifetime in 
wpa_supplicant.conf the setting for the reauthentication timer?

The default value is 43200 (12 hours). What about I change this value to 
be 2 weeks or a year?

Thanks.
Xuebing Wang

