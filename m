MIME-Version: 1.0
Date: Tue, 28 Apr 2009 12:42:19 -0500
Message-ID: <4313f3060904281042l39d51140we6440d1cff0b74c7@mail.gmail.com>
From: Nathan Wharton <naw@greptar.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Gateway on multiple interfaces
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: B.A.T.M.A.N@open-mesh.net

I am using B.A.T.M.A.N. 0.3.2-beta rv1246 with the batgat module.
Internet tunneling works well on the first interface mentioned on the
command line.  Tunneling does not work on the secondary interface, and
it floods the log file on the gateway with:

Apr 28 17:38:09 OpenWrt user.debug kernel: batgat: [get_ip_addr:645]
found client in hash
Apr 28 17:38:09 OpenWrt user.debug kernel: batgat: [get_ip_addr:645]
found client in hash
Apr 28 17:38:09 OpenWrt user.debug kernel: batgat: [get_ip_addr:645]
found client in hash
Apr 28 17:38:09 OpenWrt user.debug kernel: batgat: [get_ip_addr:645]
found client in hash
Apr 28 17:38:09 OpenWrt user.debug kernel: batgat: [get_ip_addr:645]
found client in hash
Apr 28 17:38:09 OpenWrt user.debug kernel: batgat: [get_ip_addr:645]
found client in hash
Apr 28 17:38:09 OpenWrt user.debug kernel: batgat: [get_ip_addr:645]
found client in hash
Apr 28 17:38:09 OpenWrt user.debug kernel: batgat: [get_ip_addr:645]
found client in hash
Apr 28 17:38:09 OpenWrt user.debug kernel: batgat: [get_ip_addr:645]
found client in hash
Apr 28 17:38:09 OpenWrt user.debug kernel: batgat: [get_ip_addr:645]
found client in hash
Apr 28 17:38:09 OpenWrt user.debug kernel: batgat: [get_ip_addr:645]
found client in hash
Apr 28 17:38:09 OpenWrt user.debug kernel: batgat: [get_ip_addr:645]
found client in hash

And on the client with:

Apr 28 17:33:10 OpenWrt user.notice batmand: Error - can't receive ip
request: sender IP is not gateway IP
Apr 28 17:33:10 OpenWrt user.notice batmand: Error - can't receive ip
request: sender IP is not gateway IP
Apr 28 17:33:10 OpenWrt user.notice batmand: Error - can't receive ip
request: sender IP is not gateway IP
Apr 28 17:33:10 OpenWrt user.notice batmand: Error - can't receive ip
request: sender IP is not gateway IP
Apr 28 17:33:10 OpenWrt user.notice batmand: Error - can't receive ip
request: sender IP is not gateway IP
Apr 28 17:33:10 OpenWrt user.notice batmand: Error - can't receive ip
request: sender IP is not gateway IP
Apr 28 17:33:10 OpenWrt user.notice batmand: Error - can't receive ip
request: sender IP is not gateway IP
Apr 28 17:33:10 OpenWrt user.notice batmand: Error - can't receive ip
request: sender IP is not gateway IP
Apr 28 17:33:10 OpenWrt user.notice batmand: Error - can't receive ip
request: sender IP is not gateway IP
Apr 28 17:33:10 OpenWrt user.notice batmand: Error - can't receive ip
request: sender IP is not gateway IP
Apr 28 17:33:10 OpenWrt user.notice batmand: Error - can't receive ip
request: sender IP is not gateway IP
Apr 28 17:33:10 OpenWrt user.notice batmand: Error - can't receive ip
request: sender IP is not gateway IP
Apr 28 17:33:10 OpenWrt user.notice batmand: Error - can't receive ip
from gateway: number of maximum retries reached

Is there something I can do to get it to work on the secondary interface?

On the gateway, I am using:
batmand -d 3 -g 11000 -a 10.2.1.0/24 --disable-client-nat
--hop-penalty 5 --purge-timeout 10000 ath0 eth0
ath0 is IP 10.0.2.1/16
eth0 is IP 10.255.2.1/16

On the client, I am using:
batmand -d 3 -r 2 -a 10.1.11.0/24 --disable-client-nat --hop-penalty 5
--purge-timeout 10000 ath0 eth0
ath0 is IP 10.0.1.11/16
eth0 is IP 10.255.1.11/16

Thanks in advance for any help on this.
