Return-Path: <austinxxh-ath9k@yahoo.com>
Message-ID: <600718.39266.qm@web55301.mail.re4.yahoo.com>
Date: Mon, 6 Jul 2009 09:09:07 -0700 (PDT)
From: xxiao <austinxxh-ath9k@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [B.A.T.M.A.N.] batman-adv and 11n speed
Reply-To: austinxxh-ath9k@yahoo.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net


Hi,

I'm using Openwrt/compat-wireless-2009-06-25 on a AR7161 board. I'm using ath9k trying to get 11n speed for batman-adv working. All code is from openwrt trunk.

From the debugfs of mac80211/ath9k, I can see under IBSS mode, the rcstat reports speed up to 300mbps. I have batman-adv enabled.

However after a second board with the same software booted up, both boards' rcstat output showed a speed of 11g only, an immediate drop from 11n to 11g. It's like the second batman-adv somehow forced a 11g speed after it "talked" to the first batman-adv board.

Any help is appreciated!
xxiao


Before the second batman-adv is booted up:
root@OpenWrt:/# cat /mnt/ath9k/phy0/rcstat 
 Rate         Success  Retries  XRetries PER

  1.0:        0        0        0        0
  2.0:        0        0        0        0
  5.5:        0        0        0        0
 11.0:        0        0        0        0
  6.0:        0        0        0        0
  9.0:        0        0        0        0
 12.0:        0        0        0        0
 18.0:        0        0        0        0
 24.0:        0        0        0        0
 36.0:        0        0        0        0
 48.0:        0        0        0        0
 54.0:        0        0        0        0
  6.5:        0        0        0        0
 13.0:        0        0        0        0
 19.5:        0        0        0        0
 26.0:        0        0        0        0
 39.0:        0        0        0        0
 52.0:        0        0        0        0
 58.5:        0        0        0        0
 65.0:        0        0        0        0
 13.0:        0        0        0        0
 26.0:        0        0        0        0
 39.0:        0        0        0        0
 52.0:        0        0        0        0
 78.0:        0        0        0        0
104.0:        0        0        0        0
117.0:        0        0        0        0
130.0:        0        0        0        0
 13.5:        0        0        0        0
 27.5:        0        0        0        0
 40.5:        0        0        0        0
 54.0:        0        0        0        0
 81.5:        0        0        0        0
108.0:        0        0        0        0
121.5:        0        0        0        0
135.0:        0        0        0        0
150.0:        0        0        0        0
 27.0:        0        0        0        0
 54.0:        0        0        0        0
 81.0:        0        0        0        0
108.0:        0        0        0        0
162.0:        0        0        0        0
216.0:        0        0        0        0
243.0:        0        0        0        0
270.0:        0        0        0        0
300.0:        0        0        0        0

after the second batman-adv is up:
root@OpenWrt:/# cat /mnt/ath9k/phy0/rcstat 
 Rate         Success  Retries  XRetries PER

  1.0:        0        0        0        0
  2.0:        0        0        0        0
  5.5:        0        0        0        0
 11.0:        0        0        0        0
  6.0:        0        0        0        0
  9.0:        0        0        0        0
 12.0:        0        0        0        0
 18.0:        0        0        0        0
 24.0:        0        0        0        0
 36.0:        0        0        0        0
 48.0:        0        0        0        0
 54.0:        0        0        0        0

On both boards I have this:
root@OpenWrt:/# iwconfig
lo        no wireless extensions.

eth0      no wireless extensions.

eth1      no wireless extensions.

br-lan    no wireless extensions.

wlan0     IEEE 802.11abgn  ESSID:"xyz"  
          Mode:Ad-Hoc  Frequency:2.432 GHz  Cell: 92:46:0A:A3:8B:39   
          Tx-Power=27 dBm   
          Retry  long limit:7   RTS thr:off   Fragment thr:off
          Encryption key:off
          Power Management:off
          Link Quality:0  Signal level:0  Noise level:0
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

bat0      no wireless extensions.

Here is the dmesg dump:
root@OpenWrt:/# dmesg
30fe050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831da04a DA=831da044 BSSID=831da050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8312204a DA=83122044 BSSID=83122050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=8326804a DA=83268044 BSSID=83268050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8319e04a DA=8319e044 BSSID=8319e050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1604
wlan0: RX ProbeReq SA=831ac04a DA=831ac044 BSSID=831ac050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8309604a DA=83096044 BSSID=83096050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831e204a DA=831e2044 BSSID=831e2050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831a204a DA=831a2044 BSSID=831a2050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=832de04a DA=832de044 BSSID=832de050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8324604a DA=83246044 BSSID=83246050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1604
wlan0: RX ProbeReq SA=832fc04a DA=832fc044 BSSID=832fc050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8337604a DA=83376044 BSSID=83376050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=82c6804a DA=82c68044 BSSID=82c68050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8329a04a DA=8329a044 BSSID=8329a050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1004
wlan0: RX ProbeReq SA=830e804a DA=830e8044 BSSID=830e8050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=830ec04a DA=830ec044 BSSID=830ec050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1604
wlan0: RX ProbeReq SA=830be04a DA=830be044 BSSID=830be050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8311004a DA=83110044 BSSID=83110050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8312c04a DA=8312c044 BSSID=8312c050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8312e04a DA=8312e044 BSSID=8312e050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8313a04a DA=8313a044 BSSID=8313a050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=830e604a DA=830e6044 BSSID=830e6050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8313604a DA=83136044 BSSID=83136050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=831d004a DA=831d0044 BSSID=831d0050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831d604a DA=831d6044 BSSID=831d6050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=8329004a DA=83290044 BSSID=83290050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831d204a DA=831d2044 BSSID=831d2050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=8332004a DA=83320044 BSSID=83320050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=8332c04a DA=8332c044 BSSID=8332c050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1604
wlan0: RX ProbeReq SA=8333e04a DA=8333e044 BSSID=8333e050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1604
wlan0: RX ProbeReq SA=8333c04a DA=8333c044 BSSID=8333c050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=832e804a DA=832e8044 BSSID=832e8050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=8333a04a DA=8333a044 BSSID=8333a050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=8334a04a DA=8334a044 BSSID=8334a050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8335204a DA=83352044 BSSID=83352050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=8331204a DA=83312044 BSSID=83312050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=833b804a DA=833b8044 BSSID=833b8050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=8303e04a DA=8303e044 BSSID=8303e050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=8308404a DA=83084044 BSSID=83084050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8307204a DA=83072044 BSSID=83072050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8311604a DA=83116044 BSSID=83116050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8311204a DA=83112044 BSSID=83112050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=831ca04a DA=831ca044 BSSID=831ca050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831c804a DA=831c8044 BSSID=831c8050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=8319c04a DA=8319c044 BSSID=8319c050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831ce04a DA=831ce044 BSSID=831ce050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=831e204a DA=831e2044 BSSID=831e2050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831a204a DA=831a2044 BSSID=831a2050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=832c604a DA=832c6044 BSSID=832c6050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=832cc04a DA=832cc044 BSSID=832cc050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=832d404a DA=832d4044 BSSID=832d4050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8301e04a DA=8301e044 BSSID=8301e050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8338004a DA=83380044 BSSID=83380050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=832b204a DA=832b2044 BSSID=832b2050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=8303a04a DA=8303a044 BSSID=8303a050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831e804a DA=831e8044 BSSID=831e8050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=8311c04a DA=8311c044 BSSID=8311c050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8312004a DA=83120044 BSSID=83120050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1004
wlan0: RX ProbeReq SA=8312a04a DA=8312a044 BSSID=8312a050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8317c04a DA=8317c044 BSSID=8317c050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=8311e04a DA=8311e044 BSSID=8311e050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8321404a DA=83214044 BSSID=83214050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831c804a DA=831c8044 BSSID=831c8050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1604
wlan0: RX ProbeReq SA=832d404a DA=832d4044 BSSID=832d4050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8301e04a DA=8301e044 BSSID=8301e050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1004
wlan0: RX ProbeReq SA=83aac04a DA=83aac044 BSSID=83aac050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8334204a DA=83342044 BSSID=83342050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=832f604a DA=832f6044 BSSID=832f6050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=832de04a DA=832de044 BSSID=832de050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=83a0e04a DA=83a0e044 BSSID=83a0e050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8303404a DA=83034044 BSSID=83034050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8325404a DA=83254044 BSSID=83254050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8306c04a DA=8306c044 BSSID=8306c050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8304604a DA=83046044 BSSID=83046050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1004
wlan0: RX ProbeReq SA=8307804a DA=83078044 BSSID=83078050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8335a04a DA=8335a044 BSSID=8335a050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8312c04a DA=8312c044 BSSID=8312c050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8312e04a DA=8312e044 BSSID=8312e050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=8313804a DA=83138044 BSSID=83138050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=8312204a DA=83122044 BSSID=83122050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831e404a DA=831e4044 BSSID=831e4050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=8314e04a DA=8314e044 BSSID=8314e050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=831fa04a DA=831fa044 BSSID=831fa050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=8320804a DA=83208044 BSSID=83208050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=8321a04a DA=8321a044 BSSID=8321a050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=8321004a DA=83210044 BSSID=83210050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=8321204a DA=83212044 BSSID=83212050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=8324a04a DA=8324a044 BSSID=8324a050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8325c04a DA=8325c044 BSSID=8325c050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=8328604a DA=83286044 BSSID=83286050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=832f004a DA=832f0044 BSSID=832f0050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=8322604a DA=83226044 BSSID=83226050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8326204a DA=83262044 BSSID=83262050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8331e04a DA=8331e044 BSSID=8331e050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=832d204a DA=832d2044 BSSID=832d2050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8335c04a DA=8335c044 BSSID=8335c050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=83aa404a DA=83aa4044 BSSID=83aa4050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=83b2a04a DA=83b2a044 BSSID=83b2a050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=832fa04a DA=832fa044 BSSID=832fa050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8309404a DA=83094044 BSSID=83094050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=830e804a DA=830e8044 BSSID=830e8050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8313c04a DA=8313c044 BSSID=8313c050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8314c04a DA=8314c044 BSSID=8314c050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8315404a DA=83154044 BSSID=83154050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8316004a DA=83160044 BSSID=83160050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8310a04a DA=8310a044 BSSID=8310a050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1004
wlan0: RX ProbeReq SA=830fc04a DA=830fc044 BSSID=830fc050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831a804a DA=831a8044 BSSID=831a8050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=832c804a DA=832c8044 BSSID=832c8050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831c404a DA=831c4044 BSSID=831c4050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1004
wlan0: RX ProbeReq SA=8336c04a DA=8336c044 BSSID=8336c050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8336e04a DA=8336e044 BSSID=8336e050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1004
wlan0: RX ProbeReq SA=83ac604a DA=83ac6044 BSSID=83ac6050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=83b6c04a DA=83b6c044 BSSID=83b6c050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=8337a04a DA=8337a044 BSSID=8337a050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8305c04a DA=8305c044 BSSID=8305c050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1604
wlan0: RX ProbeReq SA=8309e04a DA=8309e044 BSSID=8309e050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=830b004a DA=830b0044 BSSID=830b0050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=831ec04a DA=831ec044 BSSID=831ec050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8310604a DA=83106044 BSSID=83106050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1604
phy0: Adding new IBSS station 8324e04a (dev=wlan0)
phy0: Allocated STA 830c8224
phy0: Inserted STA 830c8224
wlan0: RX ProbeReq SA=832aa04a DA=832aa044 BSSID=832aa050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=832ae04a DA=832ae044 BSSID=832ae050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=8323004a DA=83230044 BSSID=83230050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=832e004a DA=832e0044 BSSID=832e0050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8323804a DA=83238044 BSSID=83238050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=832d804a DA=832d8044 BSSID=832d8050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8330e04a DA=8330e044 BSSID=8330e050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8331c04a DA=8331c044 BSSID=8331c050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1004
wlan0: RX ProbeReq SA=8334204a DA=83342044 BSSID=83342050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8397004a DA=83970044 BSSID=83970050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=830ba04a DA=830ba044 BSSID=830ba050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=830bc04a DA=830bc044 BSSID=830bc050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=830f804a DA=830f8044 BSSID=830f8050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=8309004a DA=83090044 BSSID=83090050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=8310204a DA=83102044 BSSID=83102050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=832ea04a DA=832ea044 BSSID=832ea050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=8311404a DA=83114044 BSSID=83114050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=8310804a DA=83108044 BSSID=83108050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=831b804a DA=831b8044 BSSID=831b8050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831ba04a DA=831ba044 BSSID=831ba050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=8310e04a DA=8310e044 BSSID=8310e050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=830e604a DA=830e6044 BSSID=830e6050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831d804a DA=831d8044 BSSID=831d8050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831e404a DA=831e4044 BSSID=831e4050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831ee04a DA=831ee044 BSSID=831ee050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8310604a DA=83106044 BSSID=83106050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8322804a DA=83228044 BSSID=83228050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8322a04a DA=8322a044 BSSID=8322a050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=8303204a DA=83032044 BSSID=83032050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=832e004a DA=832e0044 BSSID=832e0050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=83b6c04a DA=83b6c044 BSSID=83b6c050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8334204a DA=83342044 BSSID=83342050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1804
wlan0: RX ProbeReq SA=839ae04a DA=839ae044 BSSID=839ae050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=830c004a DA=830c0044 BSSID=830c0050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1a04
wlan0: RX ProbeReq SA=8309204a DA=83092044 BSSID=83092050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831e404a DA=831e4044 BSSID=831e4050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=831ee04a DA=831ee044 BSSID=831ee050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1204
wlan0: RX ProbeReq SA=832d804a DA=832d8044 BSSID=832d8050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8326804a DA=83268044 BSSID=83268050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1004
wlan0: RX ProbeReq SA=832fe04a DA=832fe044 BSSID=832fe050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8330204a DA=83302044 BSSID=83302050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8324204a DA=83242044 BSSID=83242050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8332a04a DA=8332a044 BSSID=8332a050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=832ca04a DA=832ca044 BSSID=832ca050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=83b9804a DA=83b98044 BSSID=83b98050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1604
wlan0: RX ProbeReq SA=8305804a DA=83058044 BSSID=83058050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8311004a DA=83110044 BSSID=83110050 (tx_last_beacon=1)
wlan0: RX ProbeReq SA=8303a04a DA=8303a044 BSSID=8303a050 (tx_last_beacon=1)
wlan0: Sending ProbeResp to 838e1604
root@OpenWrt:/# 
 CTRL-A Z for help |115200 8N1 | NOR | Minicom 2.3-rc | VT102 |      Offline

