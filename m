Return-Path: <ditwal001@gmail.com>
From: "Walter Robert Ditzler" <ditwal001@gmail.com>
Date: Thu, 21 Jun 2012 22:44:41 +0200
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPQoTXbPAsVNnz8bVvWo0dwBAAAAAA==@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: de-ch
Subject: [B.A.T.M.A.N.] filling debian log
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@lists.open-mesh.org>

hey list,

how are you today? i just ran into a minor problem with my flashybrid box,
debian 6.0.5, batman-adv 2012.1. batman-adv fills up my logs!

anyone here who knows how to stop loggin or perhaps only "never to miss
stuff"?

i tried to set "batctl loglevel none" but with no help in fact.

anyway, your help are appreciated :-)

thanks walter.




here are the logs from kern.log

***
Jun 21 22:40:41 srv-ldeb-basic2 kernel: [  435.582433] mesh0: RX ProbeReq
SA=3c:d0:f8:73:ee:d1 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:41 srv-ldeb-basic2 kernel: [  435.595048] mesh0: RX ProbeReq
SA=3c:d0:f8:73:ee:d1 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:41 srv-ldeb-basic2 kernel: [  435.605731] mesh0: RX ProbeReq
SA=3c:d0:f8:73:ee:d1 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:41 srv-ldeb-basic2 kernel: [  435.615870] mesh0: RX ProbeReq
SA=3c:d0:f8:73:ee:d1 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:41 srv-ldeb-basic2 kernel: [  435.691987] mesh0: RX ProbeReq
SA=3c:d0:f8:73:ee:d1 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:41 srv-ldeb-basic2 kernel: [  435.702311] mesh0: RX ProbeReq
SA=3c:d0:f8:73:ee:d1 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:42 srv-ldeb-basic2 kernel: [  437.190688] mesh0: RX ProbeReq
SA=04:1e:64:eb:ef:e0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:42 srv-ldeb-basic2 kernel: [  437.214386] mesh0: RX ProbeReq
SA=04:1e:64:eb:ef:e0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:42 srv-ldeb-basic2 kernel: [  437.339164] mesh0: RX ProbeReq
SA=04:1e:64:eb:ef:e0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:42 srv-ldeb-basic2 kernel: [  437.502633] mesh0: RX ProbeReq
SA=04:1e:64:eb:ef:e0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:42 srv-ldeb-basic2 kernel: [  437.526321] mesh0: RX ProbeReq
SA=04:1e:64:eb:ef:e0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:43 srv-ldeb-basic2 kernel: [  438.525654] mesh0: RX ProbeReq
SA=04:1e:64:ed:0a:d0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:44 srv-ldeb-basic2 kernel: [  438.752065] mesh0: RX ProbeReq
SA=04:1e:64:ed:0a:d0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:44 srv-ldeb-basic2 kernel: [  438.775144] mesh0: RX ProbeReq
SA=04:1e:64:ed:0a:d0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:47 srv-ldeb-basic2 kernel: [  441.810516] mesh0: RX ProbeReq
SA=04:1e:64:ed:0a:d0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:47 srv-ldeb-basic2 kernel: [  441.832374] mesh0: RX ProbeReq
SA=04:1e:64:ed:0a:d0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:47 srv-ldeb-basic2 kernel: [  441.995940] mesh0: RX ProbeReq
SA=04:1e:64:ed:0a:d0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:47 srv-ldeb-basic2 kernel: [  442.019572] mesh0: RX ProbeReq
SA=04:1e:64:ed:0a:d0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:55 srv-ldeb-basic2 kernel: [  450.154135] mesh0: RX ProbeReq
SA=00:21:6b:9c:d3:e2 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:40:55 srv-ldeb-basic2 kernel: [  450.154938] mesh0: RX ProbeReq
SA=00:21:6b:9c:d3:e2 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:41:11 srv-ldeb-basic2 kernel: [  465.990674] mesh0: RX ProbeReq
SA=00:1f:e2:c6:80:27 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:41:12 srv-ldeb-basic2 kernel: [  466.690831] mesh0: RX ProbeReq
SA=08:11:96:94:8c:b8 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:41:12 srv-ldeb-basic2 kernel: [  466.691993] mesh0: RX ProbeReq
SA=08:11:96:94:8c:b8 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:41:12 srv-ldeb-basic2 kernel: [  466.692903] mesh0: RX ProbeReq
SA=08:11:96:94:8c:b8 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:41:15 srv-ldeb-basic2 kernel: [  469.647544] mesh0: RX ProbeReq
SA=c8:bc:c8:dc:4e:d8 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:41:15 srv-ldeb-basic2 kernel: [  469.667512] mesh0: RX ProbeReq
SA=c8:bc:c8:dc:4e:d8 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:41:15 srv-ldeb-basic2 kernel: [  470.111427] mesh0: RX ProbeReq
SA=c8:bc:c8:dc:4e:d8 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:41:15 srv-ldeb-basic2 kernel: [  470.130484] mesh0: RX ProbeReq
SA=c8:bc:c8:dc:4e:d8 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:41:15 srv-ldeb-basic2 kernel: [  470.152588] mesh0: RX ProbeReq
SA=c8:bc:c8:dc:4e:d8 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 21 22:41:15 srv-ldeb-basic2 kernel: [  470.172511] mesh0: RX ProbeReq
SA=c8:bc:c8:dc:4e:d8 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
***

here are the logs from sys.log
***
Jun 18 04:00:55 srv-ldeb-basic2 kernel: [110195.351651] mesh0: RX ProbeReq
SA=04:1e:64:eb:ef:e0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 18 04:00:56 srv-ldeb-basic2 kernel: [110196.244933] mesh0: RX ProbeReq
SA=00:1f:e2:c6:80:27 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 18 04:00:56 srv-ldeb-basic2 kernel: [110196.254086] mesh0: RX ProbeReq
SA=00:1f:e2:c6:80:27 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 18 04:00:56 srv-ldeb-basic2 kernel: [110196.264931] mesh0: RX ProbeReq
SA=00:1f:e2:c6:80:27 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 18 04:00:56 srv-ldeb-basic2 kernel: [110196.274060] mesh0: RX ProbeReq
SA=00:1f:e2:c6:80:27 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 18 04:00:58 srv-ldeb-basic2 kernel: [110198.041195] mesh0: RX ProbeReq
SA=04:1e:64:eb:ef:e0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 18 04:00:58 srv-ldeb-basic2 kernel: [110198.064947] mesh0: RX ProbeReq
SA=04:1e:64:eb:ef:e0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 18 04:00:58 srv-ldeb-basic2 kernel: [110198.252067] mesh0: RX ProbeReq
SA=04:1e:64:eb:ef:e0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 18 04:00:58 srv-ldeb-basic2 kernel: [110198.353159] mesh0: RX ProbeReq
SA=04:1e:64:eb:ef:e0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 18 04:00:58 srv-ldeb-basic2 kernel: [110198.377029] mesh0: RX ProbeReq
SA=04:1e:64:eb:ef:e0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
Jun 18 04:00:58 srv-ldeb-basic2 kernel: [110198.540414] mesh0: RX ProbeReq
SA=04:1e:64:eb:ef:e0 DA=ff:ff:ff:ff:ff:ff BSSID=ff:ff:ff:ff:ff:ff
(tx_last_beacon=0)
***

