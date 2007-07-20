Message-ID: <20070720172531.tjq2at48zqo048sk@webmail.ddmesh.de>
Date: Fri, 20 Jul 2007 17:25:31 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] TTL-Interface specific
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

Hello,

In the documentation was written that a specific TTL can be assigned  
to each interface. How can I do this from command line?
I have two interfaces eth1 (wlan) and bbs (a VPN tap tunnel used as backbone).

Those interfaces are not bridged and have different ip ranges
eth1: 10.12.x.x
bbs: 172.16.x.x

My aim is only to propagate the 10.12.x.x ip range and not the 172.16er.
The 172.16 of any foreign router should not be listed in any routing  
table of any other router. Only the local interface address of bbs  
should be seen in the routing table.
I have read that this can be solved by setting the TTL for bbs to a  
value of 1.
I need to know how I can do this.

Questions 2:
  batman on mipsel runs in three instances independed of number of  
interfaces listen. on i386 only one instance is running (three  
interfaces). How does this work?

ddmesh (dresden freifunk)

