Message-ID: <57356.149.5.32.200.1227370855.squirrel@www.rivertowermail.com>
Date: Sat, 22 Nov 2008 16:20:55 -0000 (UTC)
From: "Derek C" <derekbatman@hssl.ie>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] BATMAN routing (via gate0)
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

Hi [yet] again!

Can someone detail how BATMAN routes?

For example if I have nodes with IPs like:
     5.255.0.1
     5.255.0.2
     5.255.0.3
       etc

I see that BATMAN makes a tunnel to the gateway and then routes traffic
via the 169.254 gate0 subnet

Does this mean that all outgoing from the node should be NATed?  or is it
possible for the upstream node(s) to ping the node via its true IP address
(5.255.XXX.XXX) ?

thanks again,

Derek


-- 
Derek C

