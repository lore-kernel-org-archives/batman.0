Message-ID: <56963.149.5.32.200.1226966194.squirrel@www.rivertowermail.com>
Date: Mon, 17 Nov 2008 23:56:34 -0000 (UTC)
From: "Derek C" <derekbatman@hssl.ie>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] MASQUERADING on the gate0 NIC
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

Hi again,

I'm currently testing with a few openwrt boards - generally its going well
and I'm connected to the Internet via a BATMAN node thats talking to a
gateway node - pretty good stuff.

I've noticed something.  On my (non gateway) node the traffic is going out
the "gate0" tunnel NIC.  My notebook is connected wirelessly to an [V]AP
on the node so I need to have a MASQUERADE rule on the gate0 NIC to allow
my local AP subnet (192.168.100.0/24) Internet access.

In a live network, with lots of nodes, will there still only ever be one
gateX NIC ? - is it enough to just have an "iptables -t nat -A POSTROUTING
-o gate0 -j MASQUERADE" rule ?

thanks very much for all the help

Derek


-- 
Derek C

