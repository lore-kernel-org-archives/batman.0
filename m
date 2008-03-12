Message-ID: <35440.70.128.180.22.1205347786.squirrel@webmail.reglue.org>
In-Reply-To: <47D8148D.600@gmx.net>
References: <49584.70.128.180.22.1205342204.squirrel@webmail.reglue.org>
	<47D8148D.600@gmx.net>
Date: Wed, 12 Mar 2008 11:49:46 -0700 (PDT)
Subject: Re: [B.A.T.M.A.N.] Gateway routing / finding
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

>
>
> I wrote that newer versions of Batman (Experimental and Beta) use ports
> 4305-4307, but you are using the stable version. So if you didn't
> upgrade you have to open ports 1966-1967, not 4305.


Sorry, I wasn't sure what constituted 'newer.'  My apologies.  I thought
the ports were okay beacuse I was getting Batman info.  I just wasn't able
to send ip packets through the gateway.  I've tried to amend the script to
reflect your advice but I get

batmand -d 3 -r 3 -p 10.0.2.115 eth0 eth0.0 wl0 br-lan
B.A.T.M.A.N. 0.2 (compability version 3)
Using interface eth0 with address 103.0.0.31 and broadcast address
103.255.255.255
Using interface eth0.0 with address 103.0.0.32 and broadcast address
103.255.255.255
Using interface wl0 with address 103.0.0.33 and broadcast address
103.255.255.255
Using interface br-lan with address 103.0.0.3 and broadcast address
103.0.0.255
debug level: 3
routing class: 3
preferred gateway: 10.0.2.115
Adding route to 103.0.0.8 via 0.0.0.0 (br-lan)
Adding route to 103.0.0.81/32 via 103.0.0.8 (br-lan)
Adding route to 10.0.2.115/32 via 103.0.0.8 (br-lan)
Adding route to 103.0.0.82/32 via 103.0.0.8 (br-lan)
Adding route to 103.0.0.83/32 via 103.0.0.8 (br-lan)

and no internet.

I can ping the gateway.

I've tried to upgrade the script:
(I know there are some extra ports...)

killall batmand
iwconfig wl0 channel 10 essid project mode Ad-Hoc
ifconfig eth0 103.0.0.31 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig eth0.0 103.0.0.32 netmask 255.0.0.0 broadcast 103.255.255.255
# ifconfig eth0.1 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig wl0 103.0.0.33 netmask 255.0.0.0 broadcast 103.255.255.255
iptables -t filter -I INPUT 2 -p udp --dport 1965 --sport 1965 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 1966 --sport 1966 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 1967 --sport 1967 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 1965 --sport 1965 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 1966 --sport 1966 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 1967 --sport 1967 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
batmand eth0 eth0.0 eth0.1 wl0 br-lan &


