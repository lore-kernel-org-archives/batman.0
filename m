Message-ID: <56609.70.128.180.22.1205356972.squirrel@webmail.reglue.org>
In-Reply-To: <47D82E1B.1040802@gmx.net>
References: <49584.70.128.180.22.1205342204.squirrel@webmail.reglue.org>	<47D8148D.600@gmx.net>
	<35440.70.128.180.22.1205347786.squirrel@webmail.reglue.org>
	<47D82E1B.1040802@gmx.net>
Date: Wed, 12 Mar 2008 14:22:52 -0700 (PDT)
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
> Which interfaces did you (or the system that you have installed) assign
> to br-lan? You shouldn't assign a interface to batman twice (by itself
> and as part of a bridge)

I'm a bit unsure about which interface to use.  Now, I've switched to
freifunk to try to facilitate things.  It's a new set of interfaces
(similar but different).

br0
eth0
eth1
vlan0
vlan1
lo

and on the machine with the internet connection

tun0
tun1

netstat -rn for the machine with an internet connection tells me:
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt
Iface
192.168.1.0     0.0.0.0         255.255.255.0   U         0 0          0 br0
10.0.2.0        0.0.0.0         255.255.255.0   U         0 0          0
vlan1
0.0.0.0         10.0.2.1        0.0.0.0         UG        0 0          0
vlan1

Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt
Iface
192.168.1.0     0.0.0.0         255.255.255.0   U         0 0          0 br0
10.0.2.0        0.0.0.0         255.255.255.0   U         0 0          0
vlan1

or most recently....
Destination     Gateway         Genmask         Flags   MSS Window  irtt
Iface
10.0.2.100      192.168.1.2     255.255.255.255 UGH       0 0          0 br0
192.168.1.2     0.0.0.0         255.255.255.255 UH        0 0          0 br0
192.168.1.0     0.0.0.0         255.255.255.0   U         0 0          0 br0
10.0.2.0        0.0.0.0         255.255.255.0   U         0 0          0
vlan1




