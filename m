Message-Id: <6.2.5.6.2.20090409001324.0390cd00@gmail.com>
Date: Thu, 09 Apr 2009 00:23:00 -0700
From: leongmzlist <leongmzlist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: [B.A.T.M.A.N.] default routes not set
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

Hi,
new at batman. I've got the following done:

1. got an airlink ar430w and wrt54gl to ping each other over ad-hoc network
2. setup br-lan:0 on each router.  ar430w has is 192.168.100.1; 
wrt54gl is 192.168.100.2
3. was able to ping each other via br-lan:0 IP
4. using openwrt 8.09 on both routers.

The wrt54gl got the wan/internet link up.  I started "batmand -g 
1mbit/128kbit br-lan:0"
the ar430w doesn't have internet; I started "batmand -r 3 -d 3 br-lan:0"

got this on the ar430w logs:

Interface activated: br-lan:0
Using interface br-lan:0 with address 192.168.100.1 and broadcast 
address 192.168.100.255
B.A.T.M.A.N. 0.3.1 rv1206 (compatibility version 5)
Adding throw route to 127.0.0.0/8 via 0.0.0.0 (table 68 - lo)
Adding throw route to 192.168.1.0/24 via 0.0.0.0 (table 68 - br-lan)
Adding throw route to 192.168.100.0/24 via 0.0.0.0 (table 68 - br-lan:0)
debug level: 3
routing class: 3
Adding route to 192.168.100.2 via 0.0.0.0 (table 66 - br-lan:0)
Found new gateway 192.168.100.2 -> class: 32 - 1024KBit/128KBit
Adding default route to 192.168.100.2 (gw_flags: 32, tq: 217, gw_product: 0)
Gateway client - got IP (169.254.0.1) from gateway: 192.168.100.2
Adding default route via gate0 (table 68)


When I run route -n on the ar430w, there's no default route set.  I 
manually ran:
route add default gw 169.254.0.1

Next I tried to ping the outside world on the ar430w but it gets no 
where.  Any ideas?

thx
mike

