Message-ID: <49B825BE.4040605@java-system.com>
Date: Wed, 11 Mar 2009 21:57:34 +0100
From: marco tozzini <lists@java-system.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Unable to connect to internet
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
To: b.a.t.m.a.n@open-mesh.net

Hi All,
I have 2 fonera router running openwrt and batman
wireless IP are 192.168.2.200 and 192.168.2.203

Routers have separete wifi and eth interfaces

Here it is openwrt network config file:

root@OpenWrt:~# cat /etc/config/network
config 'interface' 'loopback'
        option 'ifname' 'lo'
        option 'proto' 'static'
        option 'ipaddr' '127.0.0.1'
        option 'netmask' '255.0.0.0'

config 'interface' 'lan'
        option 'ifname' 'eth0'
        option 'type' 'bridge'
        option 'proto' 'static'
        option 'ifname' 'eth0'
        option 'ipaddr' '192.168.0.203'
        option 'netmask' '255.255.255.0'
        option 'gateway' '192.168.0.1'
        option 'dns' '192.168.0.1'

config 'interface' 'wifi'
        option 'ifname' 'ath0'
        option 'proto' 'static'
        option 'ipaddr' '192.168.2.203'
        option 'netmask' '255.255.255.0'

other router has br-lan 192.168.1.200 and 192.168.0.200

router 192.168.2.203 is connected to my ADSL modem (IP 192.168.0.1) 
through ethernet port (br-lan in openwrt)
I would like to connect to internet (and at least to ADSL modem) but 
something doesn't work...

I used this command on node 200:
root@OpenWrt:~# batmand ath0

I used this command on node 203:
root@OpenWrt:~# batmand -a 192.168.0.1/24 ath0
Interface activated: ath0
Using interface ath0 with address 192.168.2.203 and broadcast address 
192.168.2.255


Here it is result from ping command issued from node 200

root@OpenWrt:~# ping -c 3 192.168.2.203
PING 192.168.2.203 (192.168.2.203): 56 data bytes
64 bytes from 192.168.2.203: seq=0 ttl=64 time=3.539 ms
64 bytes from 192.168.2.203: seq=1 ttl=64 time=2.875 ms
64 bytes from 192.168.2.203: seq=2 ttl=64 time=6.233 ms

--- 192.168.2.203 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 2.875/4.215/6.233 ms
root@OpenWrt:~# ping -c 3 192.168.0.203
PING 192.168.0.203 (192.168.0.203): 56 data bytes
64 bytes from 192.168.0.203: seq=0 ttl=64 time=4.981 ms
64 bytes from 192.168.0.203: seq=1 ttl=64 time=2.991 ms
64 bytes from 192.168.0.203: seq=2 ttl=64 time=3.119 ms

--- 192.168.0.203 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 2.991/3.697/4.981 ms
root@OpenWrt:~# ping -c 3 192.168.0.1
PING 192.168.0.1 (192.168.0.1): 56 data bytes

--- 192.168.0.1 ping statistics ---
3 packets transmitted, 0 packets received, 100% packet loss
root@OpenWrt:~# ssh root@192.168.0.203
root@192.168.0.203's password:


BusyBox v1.11.2 (2008-10-07 13:44:59 UTC) built-in shell (ash)
Enter 'help' for a list of built-in commands.

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 KAMIKAZE (8.09, r13118) ----------------------------
  * 10 oz Vodka       Shake well with ice and strain
  * 10 oz Triple sec  mixture into 10 shot glasses.
  * 10 oz lime juice  Salute!
 ---------------------------------------------------
root@OpenWrt:~# ping -c 3 192.168.0.1
PING 192.168.0.1 (192.168.0.1): 56 data bytes
64 bytes from 192.168.0.1: seq=0 ttl=255 time=4.106 ms
64 bytes from 192.168.0.1: seq=1 ttl=255 time=2.193 ms
64 bytes from 192.168.0.1: seq=2 ttl=255 time=2.187 ms

--- 192.168.0.1 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 2.187/2.828/4.106 ms
root@OpenWrt:~#

As you can see from node 200 I can ping node 203 (wireless interface 
192.168.2.203 and wired interface 192.168.0.203), but I'm unable to go 
through adsl modem (192.168.0.1)
But I can connect to adsl modem from node 203

Any Hints?

Thanks

Ciao
Marco


