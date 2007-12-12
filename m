Date: Wed, 12 Dec 2007 17:32:26 +0100
Message-ID: <001d01c83cdc$a15dcd50$e41967f0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
From: Predrag Balorda <predrag.balorda@gmail.com>
Subject: [B.A.T.M.A.N.] Some issues in ahdemo and intra-mesh traffic (slow)
Reply-To: pele@balorda.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@open-mesh.net>

I'm running 5 nodes in 11b ahdemo + vap configuration, everything unbridged
and on separate subnets, even lan ports. It's really self-explanatory, but
for the uninitiated - being poor and not having money for a "proper" mesh
router with two or more wireless cards I'm running batman on ahdemo
interface for mesh routing and each router also has a vap for client access
(atheros hardware here, Broadcom routers 105.0.4.4 and 105.0.4.5 attach to
the mesh via another vap). I have chosen 11b over 11g for slightly better
range and better stability.

I'm experiencing strange behavior. Throughput between notes is roughly
2mbits (around 300KB/sec scp transfers).

I have included my digraph in PS so that you can better visualize my
network.

After a minute, for example node 5 would stop responding to pings from node
3, or node 1 from 4 etc, so basically two-hop nodes, direct neighbours
always seem ok. But the funny thing is that hosts on the internet, i.e.
traffic that goes to the tunnel always respond to pings. I have tried
experimenting with one-way tunnel mode but I have been unsuccessfull. Tried
"--one-way-tunnel 1 --two-way-tunnel 0" on both gw and client batman nodes
but nothing happens, batmand -c -d 2 always shows 2WT capability for the
gateway.

I have tried --dups-ttl 2 --re-brc-delay 15 --window-size 100 (reading from
bmx tutorial pdf) and it has helped somewhat, but not completely. The
problem is still there but to a lesser extent.

I don't know whether this is down to ahdemo (maybe Antonio can help here
with his experience) or down to batman. Any ideas?

Also, is my throughput ok compared to yours? The most I ever got was around
450KB/s (roughly 5.5mbits data rate, distance 100m outside with 9dbi omni
antennas and atheros 5112 - buffalo whr-hp-ag108 at both ends) but the
11Mbits evades me - even on a -55 signal and 40 rssi! It really is heart
breaking, especially seeing such a good signal. Two nodes roughly 300m apart
get 240KB/s at most. I know better is possible because in ap mode with that
signal I used to get 1MB/s transfers (that was before I started using batman
and ahdemo).

Best regards,

Pele

P.S. 
digraph topology
{
"105.0.4.4" -> "105.0.4.5"[label="1.15"]
"105.0.4.4" -> "105.0.3.3"[label="1.05"]
"105.0.4.4" -> "10.0.4.0/255.255.255.0"[label="HNA"]
"105.0.4.4" -> "10.1.4.0/255.255.255.0"[label="HNA"]
"105.0.4.4" -> "105.0.2.4/255.255.255.255"[label="HNA"]
"105.0.3.3" -> "105.0.0.1"[label="1.16"]
"105.0.3.3" -> "105.0.4.4"[label="1.19"]
"105.0.3.3" -> "105.0.3.2"[label="1.05"]
"105.0.3.3" -> "105.0.4.5"[label="1.12"]
"105.0.3.3" -> "10.0.3.0/255.255.255.0"[label="HNA"]
"105.0.3.3" -> "10.1.3.0/255.255.255.0"[label="HNA"]
"105.0.3.3" -> "105.0.0.3/255.255.255.255"[label="HNA"]
"105.0.3.3" -> "105.0.2.3/255.255.255.255"[label="HNA"]
"105.0.3.3" -> "105.0.1.3/255.255.255.255"[label="HNA"]
"105.0.4.5" -> "105.0.4.4"[label="1.27"]
"105.0.4.5" -> "105.0.3.3"[label="1.03"]
"105.0.4.5" -> "10.0.5.0/255.255.255.0"[label="HNA"]
"105.0.4.5" -> "105.0.2.5/255.255.255.255"[label="HNA"]
"105.0.3.2" -> "105.0.0.1"[label="1.03"]
"105.0.3.2" -> "105.0.3.3"[label="1.03"]
"105.0.3.2" -> "10.0.2.0/255.255.255.0"[label="HNA"]
"105.0.3.2" -> "10.1.2.0/255.255.255.0"[label="HNA"]
"105.0.3.2" -> "105.0.0.2/255.255.255.255"[label="HNA"]
"105.0.3.2" -> "105.0.2.2/255.255.255.255"[label="HNA"]
"105.0.3.2" -> "105.0.1.2/255.255.255.255"[label="HNA"]
"105.0.0.1" -> "105.0.3.3"[label="1.03"]
"105.0.0.1" -> "105.0.3.2"[label="1.01"]
"105.0.0.1" -> "10.0.1.0/255.255.255.0"[label="HNA"]
"105.0.0.1" -> "10.1.1.0/255.255.255.0"[label="HNA"]
"105.0.0.1" -> "105.0.2.1/255.255.255.255"[label="HNA"]
"105.0.0.1" -> "105.0.1.1/255.255.255.255"[label="HNA"]
"105.0.0.1" -> "0.0.0.0/0.0.0.0"[label="HNA"]
}

