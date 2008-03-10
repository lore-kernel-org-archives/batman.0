Message-ID: <52469.70.253.200.118.1205190931.squirrel@webmail.reglue.org>
Date: Mon, 10 Mar 2008 16:15:31 -0700 (PDT)
Subject: Re: [B.A.T.M.A.N.] b.a.t.m.a.n. + wrt54gl + OpenWrt Kamikaze +     
	X-wrt]
From: dondavis@reglue.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net



I got batmand working with this startup script:
(but I lost internet connectivity, even setting the gateway to 103.0.0.3)


killall batmand
iwconfig wl0 channel 10 essid project mode Ad-Hoc
ifconfig eth0.0 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig eth0.1 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig eth0 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig wl0 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
iptables -t filter -I INPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
batmand eth0.0 eth0.1 wl0 eth0 br-lan &


