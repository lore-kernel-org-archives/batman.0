Message-ID: <2bda28cd0707072316p4dbbddbauaf1a1124b8542918@mail.gmail.com>
Date: Sun, 8 Jul 2007 08:16:02 +0200
From: "Stefano Scipioni" <stefano@one-b.it>
Sender: scipio.it@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] originator timeout
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

I'm testing batman 0.2 rv451 with 6 nodes.


node1                  node2                  node3            node4

10.0.1.1 ------------- | 10.0.1.3 |
                          | 10.1.1.1 |----------- 10.1.1.10 ------ 10.1.1.13
                                          \                        \
         \
                                           \                         \
          \
                                            \
--------------------------10.1.1.20    node 5
                                             \
                                              \--10.1.1.33 node 6


node2 has two interfaces
On node2 after a while node6 (10.1.1.33) originator is deleted.
node2 batman:
  batmand -g 0 -o 2000 -r 3 -s 10.0.1.1 -d 4 wl0 eth0.0

Wireless links are good, with olsrd network has no problem

--- very long log
----------------------------------------------------------------------------------------------------

[        10]

[        94] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46770, TTL 50, V 3, UDF 0, IDF 0)
[        95] Creating new originator: 10.1.1.10
[        95] update_originator(): Searching and updating originator
entry of received packet,
[        95] Creating new last-hop neighbour of originator
[        95] Other host probably restarted !
[        96] updating last_seqno: old 0, new 46770
[        96] update_routes()
[        96] Route to 10.1.1.10 via 10.1.1.10
[        96] Adding new route
[        96] Adding route to 10.1.1.10 via 0.0.0.0 (wl0)
[        97] schedule_forward_packet():
[        97] Forward packet: rebroadcast neighbour packet with direct link flag
[        97] Forwarding packet (originator 10.1.1.10, seqno 46770, TTL
49) on interface wl0
[        98] Forwarding packet (originator 10.1.1.10, seqno 46770, TTL
49) on interface eth0.0
[        99]

[        99] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46770, TTL 49, V 3, UDF 1, IDF 1)
[       100] Drop packet: originator packet with unidirectional flag
[       100]

[       100] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.10, seqno 46770, TTL 49, V 3, UDF 0, IDF 1)
[       100] Drop packet: received my own broadcast (sender: 10.1.1.1)
[       100]

[       100] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46770, TTL 49, V 3, UDF 0, IDF 0)
[       101] Drop packet: received my own broadcast (sender: 10.0.1.3)
[       101]

[       335] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46917, TTL 49, V 3, UDF 0, IDF 1)
[       335] Creating new originator: 10.1.1.13
[       336] update_originator(): Searching and updating originator
entry of received packet,
[       336] Creating new last-hop neighbour of originator
[       336] Other host probably restarted !
[       336] updating last_seqno: old 0, new 46917
[       336] update_routes()
[       337] Route to 10.1.1.13 via 10.1.1.10
[       337] Adding new route
[       337] Adding route to 10.1.1.13/32 via 10.1.1.10 (wl0)
[       337] schedule_forward_packet():
[       338] Forward packet: rebroadcast orginator packet
[       338] Forwarding packet (originator 10.1.1.13, seqno 46917, TTL
48) on interface wl0
[       338] Forwarding packet (originator 10.1.1.13, seqno 46917, TTL
48) on interface eth0.0
[       339]

[       339] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46917, TTL 49, V 3, UDF 1, IDF 1)
[       340] Drop packet: originator packet with unidirectional flag
[       340]

[       340] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.13, seqno 46917, TTL 48, V 3, UDF 0, IDF 0)
[       340] Drop packet: received my own broadcast (sender: 10.1.1.1)
[       340]

[       341] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.13, seqno 46917, TTL 48, V 3, UDF 0, IDF 0)
[       341] Drop packet: received my own broadcast (sender: 10.0.1.3)
[       341]

[       388] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46937, TTL 50, V 3, UDF 0, IDF 0)
[       389] Creating new originator: 10.1.1.20
[       389] update_originator(): Searching and updating originator
entry of received packet,
[       389] Creating new last-hop neighbour of originator
[       389] Other host probably restarted !
[       389] updating last_seqno: old 0, new 46937
[       390] update_routes()
[       390] Route to 10.1.1.20 via 10.1.1.20
[       390] Adding new route
[       390] Adding route to 10.1.1.20 via 0.0.0.0 (wl0)
[       390] schedule_forward_packet():
[       391] Forward packet: rebroadcast neighbour packet with direct link flag
[       391] Forwarding packet (originator 10.1.1.20, seqno 46937, TTL
49) on interface wl0
[       392] Forwarding packet (originator 10.1.1.20, seqno 46937, TTL
49) on interface eth0.0
[       392]

[       393] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46937, TTL 49, V 3, UDF 0, IDF 1)
[       393] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[       393]

[       394] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.20, seqno 46937, TTL 49, V 3, UDF 0, IDF 1)
[       394] Drop packet: received my own broadcast (sender: 10.1.1.1)
[       394]

[       394] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46937, TTL 49, V 3, UDF 0, IDF 0)
[       394] Drop packet: received my own broadcast (sender: 10.0.1.3)
[       394]

[      1237] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6334, TTL 50, V 3, UDF 0, IDF 0)
[      1237] Creating new originator: 10.0.1.1
[      1237] update_originator(): Searching and updating originator
entry of received packet,
[      1237] Creating new last-hop neighbour of originator
[      1237] It seems we missed a lot of packets (6333) !
[      1237] updating last_seqno: old 0, new 6334
[      1237] update_routes()
[      1238] Route to 10.0.1.1 via 10.0.1.1
[      1238] Adding new route
[      1238] Adding route to 10.0.1.1 via 0.0.0.0 (eth0.0)
[      1238] schedule_forward_packet():
[      1239] Forward packet: rebroadcast neighbour packet with direct link flag
[      1239] Forwarding packet (originator 10.0.1.1, seqno 6334, TTL
49) on interface wl0
[      1239] Forwarding packet (originator 10.0.1.1, seqno 6334, TTL
49) on interface eth0.0
[      1240] ------------------ DEBUG ------------------
[      1240] Forward list
[      1240]     10.0.1.3 at 1933
[      1241]     10.1.1.1 at 2100
[      1241] Originator list
[      1241]   Originator           Router (#/128):    Potential routers
[      1241] 10.1.1.20             10.1.1.20 (  1):       10.1.1.20 (  1)
[      1241] 10.1.1.13             10.1.1.10 (  1):       10.1.1.10 (  1)
[      1242] 10.1.1.10             10.1.1.10 (  1):       10.1.1.10 (  1)
[      1242] 10.0.1.1               10.0.1.1 (  1):        10.0.1.1 (  1)
[      1242] ---------------------------------------------- END DEBUG
[      1242]

[      1243] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.1, seqno 6334, TTL 49, V 3, UDF 0, IDF 0)
[      1243] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      1243]

[      1244] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6334, TTL 48, V 3, UDF 0, IDF 0)
[      1244] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      1244]

[      1244] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6334, TTL 48, V 3, UDF 0, IDF 0)
[      1245] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      1245]

[      1245] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6334, TTL 49, V 3, UDF 0, IDF 1)
[      1245] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      1245]

[      1388] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.33, seqno 23186, TTL 50, V 3, UDF 0, IDF 0)
[      1388] Creating new originator: 10.1.1.33
[      1388] update_originator(): Searching and updating originator
entry of received packet,
[      1388] Creating new last-hop neighbour of originator
[      1388] It seems we missed a lot of packets (23185) !
[      1388] updating last_seqno: old 0, new 23186
[      1389] update_routes()
[      1389] Route to 10.1.1.33 via 10.1.1.33
[      1389] Adding new route
[      1389] Adding route to 10.1.1.33 via 0.0.0.0 (wl0)
[      1390] schedule_forward_packet():
[      1390] Forward packet: rebroadcast neighbour packet with direct link flag
[      1390] Forwarding packet (originator 10.1.1.33, seqno 23186, TTL
49) on interface wl0
[      1391] Forwarding packet (originator 10.1.1.33, seqno 23186, TTL
49) on interface eth0.0
[      1391]

[      1392] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.33, seqno 23186, TTL 49, V 3, UDF 0, IDF 1)
[      1392] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      1392]

[      1392] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.33, seqno 23186, TTL 49, V 3, UDF 0, IDF 0)
[      1393] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      1393]

[      1393] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.33, seqno 23186, TTL 48, V 3, UDF 0, IDF 0)
[      1393] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      1393]

[      1394] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.33, seqno 23186, TTL 48, V 3, UDF 0, IDF 0)
[      1394] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      1395]

[      1395] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.33, seqno 23186, TTL 48, V 3, UDF 0, IDF 0)
[      1395] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      1396]

[      1947] Forwarding packet (originator 10.0.1.3, seqno 1, TTL 50)
on interface wl0
[      1947] Forwarding packet (originator 10.0.1.3, seqno 1, TTL 50)
on interface eth0.0
[      1948]

[      1949] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.3, seqno 1, TTL 50, V 3, UDF 0, IDF 0)
[      1949] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      1949]

[      1949] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 1, TTL 50, V 3, UDF 0, IDF 0)
[      1949] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      1950]

[      1950] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 1, TTL 49, V 3, UDF 0, IDF 1)
[      1950] received my own OGM via NB lastTxIfSeqno: 1, currRxSeqno:
1, prevRxSeqno: 0, currRxSeqno-prevRxSeqno 1
[      1950] indicating bidirectional link - updating bidirect_link seqno
[      1950] Drop packet: originator packet from myself (via neighbour)
[      1950]

[      1952] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.3, seqno 1, TTL 49, V 3, UDF 0, IDF 0)
[      1952] received my own OGM via NB lastTxIfSeqno: 0, currRxSeqno:
1, prevRxSeqno: 0, currRxSeqno-prevRxSeqno 1
[      1952] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[      1952] Drop packet: originator packet from myself (via neighbour)
[      1952]

[      2099]

[      2109] Forwarding packet (originator 10.1.1.1, seqno 1, TTL 50)
on interface wl0
[      2110] Forwarding packet (originator 10.1.1.1, seqno 1, TTL 50)
on interface eth0.0
[      2111]

[      2111] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.1, seqno 1, TTL 50, V 3, UDF 0, IDF 0)
[      2111] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      2111]

[      2112] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 1, TTL 50, V 3, UDF 0, IDF 0)
[      2112] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      2112]

[      2112] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 1, TTL 49, V 3, UDF 0, IDF 0)
[      2113] received my own OGM via NB lastTxIfSeqno: 1, currRxSeqno:
1, prevRxSeqno: 1, currRxSeqno-prevRxSeqno 0
[      2113] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[      2113] Drop packet: originator packet from myself (via neighbour)
[      2113]

[      2113] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.1, seqno 1, TTL 49, V 3, UDF 0, IDF 1)
[      2114] received my own OGM via NB lastTxIfSeqno: 1, currRxSeqno:
1, prevRxSeqno: 0, currRxSeqno-prevRxSeqno 1
[      2114] indicating bidirectional link - updating bidirect_link seqno
[      2114] Drop packet: originator packet from myself (via neighbour)
[      2114]

[      2194] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46771, TTL 50, V 3, UDF 0, IDF 0)
[      2195] update_originator(): Searching and updating originator
entry of received packet,
[      2195] Updating existing last-hop neighbour of originator
[      2195] updating last_seqno: old 46770, new 46771
[      2195] update_routes()
[      2195] schedule_forward_packet():
[      2195] Forward packet: rebroadcast neighbour packet with direct link flag
[      2195] Forwarding packet (originator 10.1.1.10, seqno 46771, TTL
49) on interface wl0
[      2196] Forwarding packet (originator 10.1.1.10, seqno 46771, TTL
49) on interface eth0.0
[      2197]

[      2197] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.10, seqno 46771, TTL 49, V 3, UDF 0, IDF 1)
[      2198] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      2198]

[      2198] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46771, TTL 49, V 3, UDF 0, IDF 1)
[      2198] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      2198]

[      2199] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46771, TTL 49, V 3, UDF 0, IDF 0)
[      2199] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      2199]

[      2200] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46771, TTL 48, V 3, UDF 0, IDF 0)
[      2200] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      2200]

[      2201] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46771, TTL 48, V 3, UDF 0, IDF 0)
[      2201] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      2201]

[      2415] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46918, TTL 49, V 3, UDF 0, IDF 1)
[      2416] update_originator(): Searching and updating originator
entry of received packet,
[      2416] Updating existing last-hop neighbour of originator
[      2416] updating last_seqno: old 46917, new 46918
[      2416] update_routes()
[      2416] schedule_forward_packet():
[      2417] Forward packet: rebroadcast orginator packet
[      2417] Forwarding packet (originator 10.1.1.13, seqno 46918, TTL
48) on interface wl0
[      2417] Forwarding packet (originator 10.1.1.13, seqno 46918, TTL
48) on interface eth0.0
[      2418] ------------------ DEBUG ------------------
[      2418] Forward list
[      2419]     10.0.1.3 at 3957
[      2419]     10.1.1.1 at 4084
[      2419] Originator list
[      2419]   Originator           Router (#/128):    Potential routers
[      2419] 10.1.1.20             10.1.1.20 (  1):       10.1.1.20 (  1)
[      2419] 10.1.1.13             10.1.1.10 (  2):       10.1.1.10 (  2)
[      2420] 10.1.1.10             10.1.1.10 (  2):       10.1.1.10 (  2)
[      2420] 10.1.1.33             10.1.1.33 (  1):       10.1.1.33 (  1)
[      2421] 10.0.1.1               10.0.1.1 (  1):        10.0.1.1 (  1)
[      2421] ---------------------------------------------- END DEBUG
[      2421]

[      2421] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46918, TTL 49, V 3, UDF 0, IDF 1)
[      2421] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      2422]

[      2422] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.13, seqno 46918, TTL 48, V 3, UDF 0, IDF 0)
[      2422] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      2422]

[      2422] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46918, TTL 47, V 3, UDF 0, IDF 0)
[      2423] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      2423]

[      2423] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.13, seqno 46918, TTL 48, V 3, UDF 0, IDF 0)
[      2423] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      2423]

[      2424] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.13, seqno 46918, TTL 47, V 3, UDF 0, IDF 0)
[      2424] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      2424]

[      2490] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46938, TTL 50, V 3, UDF 0, IDF 0)
[      2490] update_originator(): Searching and updating originator
entry of received packet,
[      2490] Updating existing last-hop neighbour of originator
[      2490] updating last_seqno: old 46937, new 46938
[      2490] update_routes()
[      2491] schedule_forward_packet():
[      2491] Forward packet: rebroadcast neighbour packet with direct link flag
[      2491] Forwarding packet (originator 10.1.1.20, seqno 46938, TTL
49) on interface wl0
[      2491] Forwarding packet (originator 10.1.1.20, seqno 46938, TTL
49) on interface eth0.0
[      2492]

[      2493] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.20, seqno 46938, TTL 49, V 3, UDF 0, IDF 1)
[      2493] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      2493]

[      2493] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46938, TTL 49, V 3, UDF 0, IDF 1)
[      2494] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      2494]

[      2494] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46938, TTL 49, V 3, UDF 0, IDF 0)
[      2494] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      2494]

[      2495] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46938, TTL 48, V 3, UDF 0, IDF 0)
[      2495] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      2495]

[      3196] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6335, TTL 50, V 3, UDF 0, IDF 0)
[      3197] update_originator(): Searching and updating originator
entry of received packet,
[      3197] Updating existing last-hop neighbour of originator
[      3197] updating last_seqno: old 6334, new 6335
[      3197] update_routes()
[      3197] schedule_forward_packet():
[      3197] Forward packet: rebroadcast neighbour packet with direct link flag
[      3197] Forwarding packet (originator 10.0.1.1, seqno 6335, TTL
49) on interface wl0
[      3198] Forwarding packet (originator 10.0.1.1, seqno 6335, TTL
49) on interface eth0.0
[      3199]

[      3199] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.1, seqno 6335, TTL 49, V 3, UDF 0, IDF 0)
[      3199] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      3199]

[      3200] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6335, TTL 49, V 3, UDF 0, IDF 1)
[      3200] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      3200]

[      3201] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6335, TTL 48, V 3, UDF 0, IDF 0)
[      3202] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      3202]

[      3202] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6335, TTL 48, V 3, UDF 0, IDF 0)
[      3203] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      3203]

[      3318] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.33, seqno 23187, TTL 50, V 3, UDF 0, IDF 0)
[      3318] update_originator(): Searching and updating originator
entry of received packet,
[      3318] Updating existing last-hop neighbour of originator
[      3318] updating last_seqno: old 23186, new 23187
[      3318] update_routes()
[      3318] schedule_forward_packet():
[      3319] Forward packet: rebroadcast neighbour packet with direct link flag
[      3319] Forwarding packet (originator 10.1.1.33, seqno 23187, TTL
49) on interface wl0
[      3319] Forwarding packet (originator 10.1.1.33, seqno 23187, TTL
49) on interface eth0.0
[      3320]

[      3321] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.33, seqno 23187, TTL 49, V 3, UDF 0, IDF 1)
[      3321] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      3321]

[      3321] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.33, seqno 23187, TTL 49, V 3, UDF 0, IDF 0)
[      3321] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      3322]

[      3322] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.33, seqno 23187, TTL 48, V 3, UDF 0, IDF 0)
[      3322] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      3322]

[      3323] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.33, seqno 23187, TTL 48, V 3, UDF 0, IDF 0)
[      3323] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      3324]

[      3324] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.33, seqno 23187, TTL 48, V 3, UDF 0, IDF 0)
[      3324] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      3324]

[      3959] Forwarding packet (originator 10.0.1.3, seqno 2, TTL 50)
on interface wl0
[      3960] Forwarding packet (originator 10.0.1.3, seqno 2, TTL 50)
on interface eth0.0
[      3961] ------------------ DEBUG ------------------
[      3961] Forward list
[      3961]     10.1.1.1 at 4084
[      3962]     10.0.1.3 at 6004
[      3962] Originator list
[      3962]   Originator           Router (#/128):    Potential routers
[      3962] 10.1.1.20             10.1.1.20 (  2):       10.1.1.20 (  2)
[      3962] 10.1.1.13             10.1.1.10 (  2):       10.1.1.10 (  2)
[      3963] 10.1.1.10             10.1.1.10 (  2):       10.1.1.10 (  2)
[      3963] 10.1.1.33             10.1.1.33 (  2):       10.1.1.33 (  2)
[      3963] 10.0.1.1               10.0.1.1 (  2):        10.0.1.1 (  2)
[      3963] ---------------------------------------------- END DEBUG
[      3963]

[      3964] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.3, seqno 2, TTL 50, V 3, UDF 0, IDF 0)
[      3964] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      3964]

[      3964] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 2, TTL 50, V 3, UDF 0, IDF 0)
[      3965] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      3965]

[      3965] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 2, TTL 49, V 3, UDF 0, IDF 1)
[      3965] received my own OGM via NB lastTxIfSeqno: 2, currRxSeqno:
2, prevRxSeqno: 1, currRxSeqno-prevRxSeqno 1
[      3965] indicating bidirectional link - updating bidirect_link seqno
[      3965] Drop packet: originator packet from myself (via neighbour)
[      3966]

[      3966] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.3, seqno 2, TTL 49, V 3, UDF 0, IDF 0)
[      3966] received my own OGM via NB lastTxIfSeqno: 1, currRxSeqno:
2, prevRxSeqno: 1, currRxSeqno-prevRxSeqno 1
[      3966] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[      3967] Drop packet: originator packet from myself (via neighbour)
[      3967]

[      4079]

[      4089] Forwarding packet (originator 10.1.1.1, seqno 2, TTL 50)
on interface wl0
[      4090] Forwarding packet (originator 10.1.1.1, seqno 2, TTL 50)
on interface eth0.0
[      4091]

[      4091] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.1, seqno 2, TTL 50, V 3, UDF 0, IDF 0)
[      4091] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      4091]

[      4092] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 2, TTL 50, V 3, UDF 0, IDF 0)
[      4092] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      4092]

[      4092] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 2, TTL 49, V 3, UDF 0, IDF 0)
[      4093] received my own OGM via NB lastTxIfSeqno: 2, currRxSeqno:
2, prevRxSeqno: 2, currRxSeqno-prevRxSeqno 0
[      4093] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[      4093] Drop packet: originator packet from myself (via neighbour)
[      4093]

[      4094] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.1, seqno 2, TTL 49, V 3, UDF 0, IDF 1)
[      4094] received my own OGM via NB lastTxIfSeqno: 2, currRxSeqno:
2, prevRxSeqno: 1, currRxSeqno-prevRxSeqno 1
[      4095] indicating bidirectional link - updating bidirect_link seqno
[      4095] Drop packet: originator packet from myself (via neighbour)
[      4095]

[      4197] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46772, TTL 49, V 3, UDF 0, IDF 1)
[      4198] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[      4198]

[      4415] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46919, TTL 49, V 3, UDF 0, IDF 1)
[      4416] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[      4416]

[      4416] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46919, TTL 49, V 3, UDF 0, IDF 1)
[      4417] update_originator(): Searching and updating originator
entry of received packet,
[      4417] Updating existing last-hop neighbour of originator
[      4417] updating last_seqno: old 46918, new 46919
[      4417] update_routes()
[      4417] schedule_forward_packet():
[      4417] Forward packet: rebroadcast orginator packet
[      4417] Forwarding packet (originator 10.1.1.13, seqno 46919, TTL
48) on interface wl0
[      4418] Forwarding packet (originator 10.1.1.13, seqno 46919, TTL
48) on interface eth0.0
[      4419]

[      4420] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.13, seqno 46919, TTL 48, V 3, UDF 0, IDF 0)
[      4420] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      4420]

[      4421] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.13, seqno 46919, TTL 48, V 3, UDF 0, IDF 0)
[      4421] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      4421]

[      4421] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46919, TTL 47, V 3, UDF 0, IDF 0)
[      4422] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[      4422]

[      4426] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.13, seqno 46919, TTL 47, V 3, UDF 0, IDF 0)
[      4426] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      4426]

[      4428] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46939, TTL 50, V 3, UDF 0, IDF 0)
[      4429] schedule_forward_packet():
[      4429] Forward packet: rebroadcast neighbour packet with direct
link and unidirectional flag
[      4429] Forwarding packet (originator 10.1.1.20, seqno 46939, TTL
49) on interface wl0
[      4431]

[      4431] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.20, seqno 46939, TTL 49, V 3, UDF 1, IDF 1)
[      4431] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      4432]

[      4432] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46939, TTL 49, V 3, UDF 0, IDF 1)
[      4432] update_originator(): Searching and updating originator
entry of received packet,
[      4432] Creating new last-hop neighbour of originator
[      4432] updating last_seqno: old 46938, new 46939
[      4433] update_routes()
[      4433] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      4433]

[      5156] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6336, TTL 50, V 3, UDF 0, IDF 0)
[      5157] update_originator(): Searching and updating originator
entry of received packet,
[      5157] Updating existing last-hop neighbour of originator
[      5157] updating last_seqno: old 6335, new 6336
[      5157] update_routes()
[      5157] schedule_forward_packet():
[      5157] Forward packet: rebroadcast neighbour packet with direct link flag
[      5157] Forwarding packet (originator 10.0.1.1, seqno 6336, TTL
49) on interface wl0
[      5158] Forwarding packet (originator 10.0.1.1, seqno 6336, TTL
49) on interface eth0.0
[      5159] ------------------ DEBUG ------------------
[      5159] Forward list
[      5159]     10.0.1.3 at 6004
[      5159]     10.1.1.1 at 6070
[      5159] Originator list
[      5159]   Originator           Router (#/128):    Potential routers
[      5160] 10.1.1.20             10.1.1.20 (  2):       10.1.1.20 (
2)       10.1.1.10 (  1)
[      5160] 10.1.1.13             10.1.1.10 (  3):       10.1.1.10 (  3)
[      5160] 10.1.1.10             10.1.1.10 (  2):       10.1.1.10 (  2)
[      5160] 10.1.1.33             10.1.1.33 (  2):       10.1.1.33 (  2)
[      5161] 10.0.1.1               10.0.1.1 (  3):        10.0.1.1 (  3)
[      5161] ---------------------------------------------- END DEBUG
[      5161]

[      5162] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.1, seqno 6336, TTL 49, V 3, UDF 0, IDF 0)
[      5162] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      5162]

[      5163] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6336, TTL 48, V 3, UDF 0, IDF 0)
[      5163] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      5163]

[      5163] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6336, TTL 48, V 3, UDF 0, IDF 0)
[      5164] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[      5164]

[      5164] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6336, TTL 49, V 3, UDF 0, IDF 1)
[      5164] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      5164]

[      5368] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.33, seqno 23188, TTL 50, V 3, UDF 0, IDF 0)
[      5368] schedule_forward_packet():
[      5368] Forward packet: rebroadcast neighbour packet with direct
link and unidirectional flag
[      5368] Forwarding packet (originator 10.1.1.33, seqno 23188, TTL
49) on interface wl0
[      5369]

[      5369] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.33, seqno 23188, TTL 49, V 3, UDF 1, IDF 1)
[      5370] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      5370]

[      6009] Forwarding packet (originator 10.0.1.3, seqno 3, TTL 50)
on interface wl0
[      6010] Forwarding packet (originator 10.0.1.3, seqno 3, TTL 50)
on interface eth0.0
[      6011]

[      6011] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.3, seqno 3, TTL 50, V 3, UDF 0, IDF 0)
[      6011] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      6012]

[      6012] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 3, TTL 50, V 3, UDF 0, IDF 0)
[      6012] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      6012]

[      6012] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 3, TTL 49, V 3, UDF 0, IDF 1)
[      6013] received my own OGM via NB lastTxIfSeqno: 3, currRxSeqno:
3, prevRxSeqno: 2, currRxSeqno-prevRxSeqno 1
[      6013] indicating bidirectional link - updating bidirect_link seqno
[      6013] Drop packet: originator packet from myself (via neighbour)
[      6013]

[      6014] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.0.1.3, seqno 3, TTL 49, V 3, UDF 0, IDF 0)
[      6014] received my own OGM via NB lastTxIfSeqno: 2, currRxSeqno:
3, prevRxSeqno: 0, currRxSeqno-prevRxSeqno 3
[      6014] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[      6015] Drop packet: originator packet from myself (via neighbour)
[      6015]

[      6015] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.3, seqno 3, TTL 49, V 3, UDF 0, IDF 0)
[      6015] received my own OGM via NB lastTxIfSeqno: 2, currRxSeqno:
3, prevRxSeqno: 2, currRxSeqno-prevRxSeqno 1
[      6015] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[      6016] Drop packet: originator packet from myself (via neighbour)
[      6016]

[      6069]

[      6079] Forwarding packet (originator 10.1.1.1, seqno 3, TTL 50)
on interface wl0
[      6080] Forwarding packet (originator 10.1.1.1, seqno 3, TTL 50)
on interface eth0.0
[      6081]

[      6081] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.1, seqno 3, TTL 50, V 3, UDF 0, IDF 0)
[      6081] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      6081]

[      6082] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 3, TTL 50, V 3, UDF 0, IDF 0)
[      6082] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      6082]

[      6082] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 3, TTL 49, V 3, UDF 0, IDF 0)
[      6082] received my own OGM via NB lastTxIfSeqno: 3, currRxSeqno:
3, prevRxSeqno: 3, currRxSeqno-prevRxSeqno 0
[      6083] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[      6083] Drop packet: originator packet from myself (via neighbour)
[      6083]

[      6084] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.1, seqno 3, TTL 49, V 3, UDF 0, IDF 1)
[      6084] received my own OGM via NB lastTxIfSeqno: 3, currRxSeqno:
3, prevRxSeqno: 0, currRxSeqno-prevRxSeqno 3
[      6085] indicating bidirectional link - updating bidirect_link seqno
[      6085] Drop packet: originator packet from myself (via neighbour)
[      6085]

[      6254] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46773, TTL 50, V 3, UDF 0, IDF 0)
[      6254] update_originator(): Searching and updating originator
entry of received packet,
[      6255] Updating existing last-hop neighbour of originator
[      6255] updating last_seqno: old 46771, new 46773
[      6255] update_routes()
[      6255] schedule_forward_packet():
[      6255] Forward packet: rebroadcast neighbour packet with direct link flag
[      6255] Forwarding packet (originator 10.1.1.10, seqno 46773, TTL
49) on interface wl0
[      6256] Forwarding packet (originator 10.1.1.10, seqno 46773, TTL
49) on interface eth0.0
[      6257] ------------------ DEBUG ------------------
[      6257] Forward list
[      6257]     10.0.1.3 at 8006
[      6257]     10.1.1.1 at 8106
[      6257] Originator list
[      6257]   Originator           Router (#/128):    Potential routers
[      6258] 10.1.1.20             10.1.1.20 (  2):       10.1.1.20 (
2)       10.1.1.10 (  1)
[      6258] 10.1.1.13             10.1.1.10 (  3):       10.1.1.10 (  3)
[      6258] 10.1.1.10             10.1.1.10 (  3):       10.1.1.10 (  3)
[      6259] 10.1.1.33             10.1.1.33 (  2):       10.1.1.33 (  2)
[      6259] 10.0.1.1               10.0.1.1 (  3):        10.0.1.1 (  3)
[      6259] ---------------------------------------------- END DEBUG
[      6259]

[      6260] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.10, seqno 46773, TTL 49, V 3, UDF 0, IDF 1)
[      6260] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      6260]

[      6260] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46773, TTL 49, V 3, UDF 0, IDF 1)
[      6260] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      6261]

[      6261] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46773, TTL 49, V 3, UDF 0, IDF 0)
[      6261] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      6261]

[      6262] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46773, TTL 48, V 3, UDF 0, IDF 0)
[      6262] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      6262]

[      6335] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46920, TTL 49, V 3, UDF 0, IDF 1)
[      6336] update_originator(): Searching and updating originator
entry of received packet,
[      6336] Updating existing last-hop neighbour of originator
[      6336] updating last_seqno: old 46919, new 46920
[      6336] update_routes()
[      6337] schedule_forward_packet():
[      6337] Forward packet: rebroadcast orginator packet
[      6337] Forwarding packet (originator 10.1.1.13, seqno 46920, TTL
48) on interface wl0
[      6337] Forwarding packet (originator 10.1.1.13, seqno 46920, TTL
48) on interface eth0.0
[      6338]

[      6338] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46920, TTL 49, V 3, UDF 0, IDF 1)
[      6339] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      6339]

[      6339] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.13, seqno 46920, TTL 48, V 3, UDF 0, IDF 0)
[      6339] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      6340]

[      6340] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46920, TTL 47, V 3, UDF 0, IDF 0)
[      6340] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[      6341]

[      6341] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.13, seqno 46920, TTL 48, V 3, UDF 0, IDF 0)
[      6341] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      6341]

[      6341] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.13, seqno 46920, TTL 47, V 3, UDF 0, IDF 0)
[      6342] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      6342]

[      6408] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46940, TTL 50, V 3, UDF 0, IDF 0)
[      6409] update_originator(): Searching and updating originator
entry of received packet,
[      6409] Updating existing last-hop neighbour of originator
[      6409] updating last_seqno: old 46939, new 46940
[      6409] update_routes()
[      6409] schedule_forward_packet():
[      6409] Forward packet: rebroadcast neighbour packet with direct link flag
[      6410] Forwarding packet (originator 10.1.1.20, seqno 46940, TTL
49) on interface wl0
[      6410] Forwarding packet (originator 10.1.1.20, seqno 46940, TTL
49) on interface eth0.0
[      6411]

[      6412] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.20, seqno 46940, TTL 49, V 3, UDF 0, IDF 1)
[      6412] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      6412]

[      6412] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46940, TTL 49, V 3, UDF 0, IDF 1)
[      6412] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      6413]

[      6413] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46940, TTL 49, V 3, UDF 0, IDF 0)
[      6413] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      6413]

[      6414] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46940, TTL 48, V 3, UDF 0, IDF 0)
[      6414] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      6414]

[      6414] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46940, TTL 48, V 3, UDF 0, IDF 0)
[      6415] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[      6415]

[      7076] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6337, TTL 50, V 3, UDF 0, IDF 0)
[      7076] update_originator(): Searching and updating originator
entry of received packet,
[      7077] Updating existing last-hop neighbour of originator
[      7077] updating last_seqno: old 6336, new 6337
[      7077] update_routes()
[      7077] schedule_forward_packet():
[      7077] Forward packet: rebroadcast neighbour packet with direct link flag
[      7077] Forwarding packet (originator 10.0.1.1, seqno 6337, TTL
49) on interface wl0
[      7078] Forwarding packet (originator 10.0.1.1, seqno 6337, TTL
49) on interface eth0.0
[      7078]

[      7079] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.1, seqno 6337, TTL 49, V 3, UDF 0, IDF 0)
[      7079] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      7079]

[      7080] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6337, TTL 49, V 3, UDF 0, IDF 1)
[      7080] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      7080]

[      7081] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6337, TTL 48, V 3, UDF 0, IDF 0)
[      7081] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      7082]

[      7368] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.33, seqno 23189, TTL 50, V 3, UDF 0, IDF 0)
[      7368] schedule_forward_packet():
[      7368] Forward packet: rebroadcast neighbour packet with direct
link and unidirectional flag
[      7368] Forwarding packet (originator 10.1.1.33, seqno 23189, TTL
49) on interface wl0
[      7369] ------------------ DEBUG ------------------
[      7369] Forward list
[      7369]     10.0.1.3 at 8006
[      7369]     10.1.1.1 at 8106
[      7370] Originator list
[      7370]   Originator           Router (#/128):    Potential routers
[      7370] 10.1.1.20             10.1.1.20 (  3):       10.1.1.20 (
3)       10.1.1.10 (  1)
[      7370] 10.1.1.13             10.1.1.10 (  4):       10.1.1.10 (  4)
[      7370] 10.1.1.10             10.1.1.10 (  3):       10.1.1.10 (  3)
[      7371] 10.1.1.33             10.1.1.33 (  2):       10.1.1.33 (  2)
[      7371] 10.0.1.1               10.0.1.1 (  4):        10.0.1.1 (  4)
[      7371] ---------------------------------------------- END DEBUG
[      7371]

[      7371] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.33, seqno 23189, TTL 49, V 3, UDF 1, IDF 1)
[      7372] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      7372]

[      8009] Forwarding packet (originator 10.0.1.3, seqno 4, TTL 50)
on interface wl0
[      8010] Forwarding packet (originator 10.0.1.3, seqno 4, TTL 50)
on interface eth0.0
[      8011]

[      8011] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.3, seqno 4, TTL 50, V 3, UDF 0, IDF 0)
[      8011] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      8012]

[      8012] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 4, TTL 50, V 3, UDF 0, IDF 0)
[      8012] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      8012]

[      8012] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 4, TTL 49, V 3, UDF 0, IDF 1)
[      8013] received my own OGM via NB lastTxIfSeqno: 4, currRxSeqno:
4, prevRxSeqno: 3, currRxSeqno-prevRxSeqno 1
[      8013] indicating bidirectional link - updating bidirect_link seqno
[      8013] Drop packet: originator packet from myself (via neighbour)
[      8013]

[      8014] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.0.1.3, seqno 4, TTL 49, V 3, UDF 0, IDF 0)
[      8014] received my own OGM via NB lastTxIfSeqno: 3, currRxSeqno:
4, prevRxSeqno: 3, currRxSeqno-prevRxSeqno 1
[      8014] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[      8014] Drop packet: originator packet from myself (via neighbour)
[      8014]

[      8109] Forwarding packet (originator 10.1.1.1, seqno 4, TTL 50)
on interface wl0
[      8110] Forwarding packet (originator 10.1.1.1, seqno 4, TTL 50)
on interface eth0.0
[      8111]

[      8111] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.1, seqno 4, TTL 50, V 3, UDF 0, IDF 0)
[      8111] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      8112]

[      8112] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 4, TTL 50, V 3, UDF 0, IDF 0)
[      8112] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      8112]

[      8112] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 4, TTL 49, V 3, UDF 0, IDF 0)
[      8113] received my own OGM via NB lastTxIfSeqno: 4, currRxSeqno:
4, prevRxSeqno: 4, currRxSeqno-prevRxSeqno 0
[      8113] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[      8113] Drop packet: originator packet from myself (via neighbour)
[      8113]

[      8114] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.1, seqno 4, TTL 49, V 3, UDF 0, IDF 1)
[      8114] received my own OGM via NB lastTxIfSeqno: 4, currRxSeqno:
4, prevRxSeqno: 3, currRxSeqno-prevRxSeqno 1
[      8114] indicating bidirectional link - updating bidirect_link seqno
[      8114] Drop packet: originator packet from myself (via neighbour)
[      8115]

[      8115] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.1, seqno 4, TTL 49, V 3, UDF 1, IDF 1)
[      8115] received my own OGM via NB lastTxIfSeqno: 4, currRxSeqno:
4, prevRxSeqno: 2, currRxSeqno-prevRxSeqno 2
[      8115] indicating bidirectional link - updating bidirect_link seqno
[      8115] Drop packet: originator packet from myself (via neighbour)
[      8115]

[      8294] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46774, TTL 50, V 3, UDF 0, IDF 0)
[      8294] update_originator(): Searching and updating originator
entry of received packet,
[      8295] Updating existing last-hop neighbour of originator
[      8295] updating last_seqno: old 46773, new 46774
[      8295] update_routes()
[      8295] schedule_forward_packet():
[      8295] Forward packet: rebroadcast neighbour packet with direct link flag
[      8296] Forwarding packet (originator 10.1.1.10, seqno 46774, TTL
49) on interface wl0
[      8296] Forwarding packet (originator 10.1.1.10, seqno 46774, TTL
49) on interface eth0.0
[      8297]

[      8297] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46921, TTL 49, V 3, UDF 0, IDF 1)
[      8298] update_originator(): Searching and updating originator
entry of received packet,
[      8298] Creating new last-hop neighbour of originator
[      8299] updating last_seqno: old 46920, new 46921
[      8299] update_routes()
[      8299] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      8299]

[      8299] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.10, seqno 46774, TTL 49, V 3, UDF 0, IDF 1)
[      8300] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      8300]

[      8300] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46921, TTL 49, V 3, UDF 1, IDF 1)
[      8300] Drop packet: originator packet with unidirectional flag
[      8300]

[      8301] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46774, TTL 49, V 3, UDF 0, IDF 1)
[      8301] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      8301]

[      8301] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46774, TTL 48, V 3, UDF 0, IDF 0)
[      8302] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[      8302]

[      8302] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46774, TTL 49, V 3, UDF 0, IDF 0)
[      8302] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      8302]

[      8302] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46774, TTL 48, V 3, UDF 0, IDF 0)
[      8303] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      8303]

[      8318] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46941, TTL 50, V 3, UDF 0, IDF 0)
[      8319] update_originator(): Searching and updating originator
entry of received packet,
[      8319] Updating existing last-hop neighbour of originator
[      8319] updating last_seqno: old 46940, new 46941
[      8319] update_routes()
[      8319] schedule_forward_packet():
[      8319] Forward packet: rebroadcast neighbour packet with direct link flag
[      8319] Forwarding packet (originator 10.1.1.20, seqno 46941, TTL
49) on interface wl0
[      8320] Forwarding packet (originator 10.1.1.20, seqno 46941, TTL
49) on interface eth0.0
[      8321]

[      8321] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.20, seqno 46941, TTL 49, V 3, UDF 0, IDF 1)
[      8321] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      8321]

[      8322] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46941, TTL 49, V 3, UDF 0, IDF 0)
[      8322] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      8323]

[      8323] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46941, TTL 49, V 3, UDF 0, IDF 1)
[      8323] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      8323]

[      8324] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46941, TTL 48, V 3, UDF 0, IDF 0)
[      8324] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[      8324]

[      8324] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46941, TTL 48, V 3, UDF 0, IDF 0)
[      8325] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      8325]

[      9176] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6338, TTL 50, V 3, UDF 0, IDF 0)
[      9176] update_originator(): Searching and updating originator
entry of received packet,
[      9176] Updating existing last-hop neighbour of originator
[      9176] updating last_seqno: old 6337, new 6338
[      9177] update_routes()
[      9177] schedule_forward_packet():
[      9177] Forward packet: rebroadcast neighbour packet with direct link flag
[      9177] Forwarding packet (originator 10.0.1.1, seqno 6338, TTL
49) on interface wl0
[      9178] Forwarding packet (originator 10.0.1.1, seqno 6338, TTL
49) on interface eth0.0
[      9178] ------------------ DEBUG ------------------
[      9179] Forward list
[      9179]     10.0.1.3 at 9918
[      9179]     10.1.1.1 at 10158
[      9179] Originator list
[      9179]   Originator           Router (#/128):    Potential routers
[      9179] 10.1.1.20             10.1.1.20 (  4):       10.1.1.20 (
4)       10.1.1.10 (  1)
[      9180] 10.1.1.13             10.1.1.10 (  4):       10.1.1.10 (
4)       10.1.1.20 (  1)
[      9180] 10.1.1.10             10.1.1.10 (  4):       10.1.1.10 (  4)
[      9180] 10.1.1.33             10.1.1.33 (  2):       10.1.1.33 (  2)
[      9180] 10.0.1.1               10.0.1.1 (  5):        10.0.1.1 (  5)
[      9181] ---------------------------------------------- END DEBUG
[      9181]

[      9181] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.1, seqno 6338, TTL 49, V 3, UDF 0, IDF 0)
[      9182] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      9182]

[      9182] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6338, TTL 48, V 3, UDF 0, IDF 0)
[      9182] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      9183]

[      9183] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6338, TTL 48, V 3, UDF 0, IDF 0)
[      9183] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[      9183]

[      9184] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6338, TTL 49, V 3, UDF 0, IDF 1)
[      9184] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      9184]

[      9318] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.33, seqno 23190, TTL 50, V 3, UDF 0, IDF 0)
[      9318] schedule_forward_packet():
[      9318] Forward packet: rebroadcast neighbour packet with direct
link and unidirectional flag
[      9318] Forwarding packet (originator 10.1.1.33, seqno 23190, TTL
49) on interface wl0
[      9319]

[      9319] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.33, seqno 23190, TTL 49, V 3, UDF 1, IDF 1)
[      9319] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      9320]

[      9919] Forwarding packet (originator 10.0.1.3, seqno 5, TTL 50)
on interface wl0
[      9920] Forwarding packet (originator 10.0.1.3, seqno 5, TTL 50)
on interface eth0.0
[      9921]

[      9921] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.3, seqno 5, TTL 50, V 3, UDF 0, IDF 0)
[      9921] Drop packet: received my own broadcast (sender: 10.1.1.1)
[      9922]

[      9922] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 5, TTL 50, V 3, UDF 0, IDF 0)
[      9922] Drop packet: received my own broadcast (sender: 10.0.1.3)
[      9922]

[      9922] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 5, TTL 49, V 3, UDF 0, IDF 1)
[      9923] received my own OGM via NB lastTxIfSeqno: 5, currRxSeqno:
5, prevRxSeqno: 4, currRxSeqno-prevRxSeqno 1
[      9923] indicating bidirectional link - updating bidirect_link seqno
[      9923] Drop packet: originator packet from myself (via neighbour)
[      9923]

[      9924] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.3, seqno 5, TTL 49, V 3, UDF 0, IDF 0)
[      9924] received my own OGM via NB lastTxIfSeqno: 4, currRxSeqno:
5, prevRxSeqno: 4, currRxSeqno-prevRxSeqno 1
[      9924] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[      9925] Drop packet: originator packet from myself (via neighbour)
[      9925]

[      9925] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.0.1.3, seqno 5, TTL 49, V 3, UDF 0, IDF 0)
[      9925] received my own OGM via NB lastTxIfSeqno: 4, currRxSeqno:
5, prevRxSeqno: 4, currRxSeqno-prevRxSeqno 1
[      9925] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[      9925] Drop packet: originator packet from myself (via neighbour)
[      9926]

[     10159] Forwarding packet (originator 10.1.1.1, seqno 5, TTL 50)
on interface wl0
[     10160] Forwarding packet (originator 10.1.1.1, seqno 5, TTL 50)
on interface eth0.0
[     10161]

[     10161] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.1, seqno 5, TTL 50, V 3, UDF 0, IDF 0)
[     10161] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     10162]

[     10162] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 5, TTL 50, V 3, UDF 0, IDF 0)
[     10162] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     10162]

[     10162] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 5, TTL 49, V 3, UDF 0, IDF 0)
[     10163] received my own OGM via NB lastTxIfSeqno: 5, currRxSeqno:
5, prevRxSeqno: 5, currRxSeqno-prevRxSeqno 0
[     10163] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[     10163] Drop packet: originator packet from myself (via neighbour)
[     10163]

[     10164] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.1, seqno 5, TTL 49, V 3, UDF 0, IDF 1)
[     10164] received my own OGM via NB lastTxIfSeqno: 5, currRxSeqno:
5, prevRxSeqno: 4, currRxSeqno-prevRxSeqno 1
[     10164] indicating bidirectional link - updating bidirect_link seqno
[     10165] Drop packet: originator packet from myself (via neighbour)
[     10165]

[     10165] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.1, seqno 5, TTL 49, V 3, UDF 0, IDF 1)
[     10165] received my own OGM via NB lastTxIfSeqno: 5, currRxSeqno:
5, prevRxSeqno: 4, currRxSeqno-prevRxSeqno 1
[     10165] indicating bidirectional link - updating bidirect_link seqno
[     10165] Drop packet: originator packet from myself (via neighbour)
[     10166]

[     10244] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46775, TTL 50, V 3, UDF 0, IDF 0)
[     10244] update_originator(): Searching and updating originator
entry of received packet,
[     10245] Updating existing last-hop neighbour of originator
[     10245] updating last_seqno: old 46774, new 46775
[     10245] update_routes()
[     10245] schedule_forward_packet():
[     10245] Forward packet: rebroadcast neighbour packet with direct link flag
[     10245] Forwarding packet (originator 10.1.1.10, seqno 46775, TTL
49) on interface wl0
[     10246] Forwarding packet (originator 10.1.1.10, seqno 46775, TTL
49) on interface eth0.0
[     10247] ------------------ DEBUG ------------------
[     10247] Forward list
[     10247]     10.0.1.3 at 11854
[     10247]     10.1.1.1 at 12255
[     10247] Originator list
[     10247]   Originator           Router (#/128):    Potential routers
[     10248] 10.1.1.20             10.1.1.20 (  4):       10.1.1.20 (
4)       10.1.1.10 (  1)
[     10249] 10.1.1.13             10.1.1.10 (  4):       10.1.1.10 (
4)       10.1.1.20 (  1)
[     10249] 10.1.1.10             10.1.1.10 (  5):       10.1.1.10 (  5)
[     10249] 10.1.1.33             10.1.1.33 (  2):       10.1.1.33 (  2)
[     10250] 10.0.1.1               10.0.1.1 (  5):        10.0.1.1 (  5)
[     10250] ---------------------------------------------- END DEBUG
[     10251]

[     10251] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.10, seqno 46775, TTL 49, V 3, UDF 0, IDF 1)
[     10251] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     10251]

[     10252] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46775, TTL 49, V 3, UDF 0, IDF 1)
[     10252] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     10252]

[     10252] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46775, TTL 48, V 3, UDF 0, IDF 0)
[     10253] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[     10253]

[     10253] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46775, TTL 49, V 3, UDF 0, IDF 0)
[     10253] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     10253]

[     10253] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46775, TTL 48, V 3, UDF 0, IDF 0)
[     10254] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     10254]

[     10278] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46942, TTL 50, V 3, UDF 0, IDF 0)
[     10279] update_originator(): Searching and updating originator
entry of received packet,
[     10279] Updating existing last-hop neighbour of originator
[     10279] updating last_seqno: old 46941, new 46942
[     10279] update_routes()
[     10279] schedule_forward_packet():
[     10279] Forward packet: rebroadcast neighbour packet with direct link flag
[     10279] Forwarding packet (originator 10.1.1.20, seqno 46942, TTL
49) on interface wl0
[     10280] Forwarding packet (originator 10.1.1.20, seqno 46942, TTL
49) on interface eth0.0
[     10281]

[     10281] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.20, seqno 46942, TTL 49, V 3, UDF 0, IDF 1)
[     10281] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     10282]

[     10282] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46942, TTL 49, V 3, UDF 0, IDF 0)
[     10283] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     10283]

[     10283] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46942, TTL 49, V 3, UDF 0, IDF 1)
[     10283] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     10284]

[     10284] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46942, TTL 48, V 3, UDF 0, IDF 0)
[     10284] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[     10284]

[     10284] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46942, TTL 48, V 3, UDF 0, IDF 0)
[     10285] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     10285]

[     11248] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.33, seqno 23191, TTL 50, V 3, UDF 0, IDF 0)
[     11248] schedule_forward_packet():
[     11248] Forward packet: rebroadcast neighbour packet with direct
link and unidirectional flag
[     11248] Forwarding packet (originator 10.1.1.33, seqno 23191, TTL
49) on interface wl0
[     11249] ------------------ DEBUG ------------------
[     11249] Forward list
[     11249]     10.0.1.3 at 11854
[     11249]     10.1.1.1 at 12255
[     11250] Originator list
[     11250]   Originator           Router (#/128):    Potential routers
[     11250] 10.1.1.20             10.1.1.20 (  5):       10.1.1.20 (
5)       10.1.1.10 (  1)
[     11250] 10.1.1.13             10.1.1.10 (  4):       10.1.1.10 (
4)       10.1.1.20 (  1)
[     11251] 10.1.1.10             10.1.1.10 (  5):       10.1.1.10 (  5)
[     11251] 10.1.1.33             10.1.1.33 (  2):       10.1.1.33 (  2)
[     11251] 10.0.1.1               10.0.1.1 (  5):        10.0.1.1 (  5)
[     11251] ---------------------------------------------- END DEBUG
[     11251]

[     11252] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.33, seqno 23191, TTL 49, V 3, UDF 1, IDF 1)
[     11252] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     11252]

[     11266] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6339, TTL 50, V 3, UDF 0, IDF 0)
[     11266] update_originator(): Searching and updating originator
entry of received packet,
[     11266] Updating existing last-hop neighbour of originator
[     11266] updating last_seqno: old 6338, new 6339
[     11266] update_routes()
[     11267] schedule_forward_packet():
[     11267] Forward packet: rebroadcast neighbour packet with direct link flag
[     11267] Forwarding packet (originator 10.0.1.1, seqno 6339, TTL
49) on interface wl0
[     11267] Forwarding packet (originator 10.0.1.1, seqno 6339, TTL
49) on interface eth0.0
[     11268]

[     11268] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.1, seqno 6339, TTL 49, V 3, UDF 0, IDF 0)
[     11269] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     11269]

[     11269] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6339, TTL 49, V 3, UDF 0, IDF 1)
[     11269] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     11269]

[     11271] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6339, TTL 48, V 3, UDF 0, IDF 0)
[     11271] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     11271]

[     11859] Forwarding packet (originator 10.0.1.3, seqno 6, TTL 50)
on interface wl0
[     11860] Forwarding packet (originator 10.0.1.3, seqno 6, TTL 50)
on interface eth0.0
[     11861]

[     11861] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.3, seqno 6, TTL 50, V 3, UDF 0, IDF 0)
[     11861] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     11862]

[     11862] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 6, TTL 50, V 3, UDF 0, IDF 0)
[     11862] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     11862]

[     11863] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 6, TTL 49, V 3, UDF 0, IDF 1)
[     11863] received my own OGM via NB lastTxIfSeqno: 6, currRxSeqno:
6, prevRxSeqno: 5, currRxSeqno-prevRxSeqno 1
[     11863] indicating bidirectional link - updating bidirect_link seqno
[     11863] Drop packet: originator packet from myself (via neighbour)
[     11863]

[     12194] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46776, TTL 50, V 3, UDF 0, IDF 0)
[     12195] update_originator(): Searching and updating originator
entry of received packet,
[     12195] Updating existing last-hop neighbour of originator
[     12195] updating last_seqno: old 46775, new 46776
[     12195] update_routes()
[     12195] schedule_forward_packet():
[     12195] Forward packet: rebroadcast neighbour packet with direct link flag
[     12195] Forwarding packet (originator 10.1.1.10, seqno 46776, TTL
49) on interface wl0
[     12196] Forwarding packet (originator 10.1.1.10, seqno 46776, TTL
49) on interface eth0.0
[     12197]

[     12197] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.10, seqno 46776, TTL 49, V 3, UDF 0, IDF 1)
[     12198] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     12198]

[     12198] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46776, TTL 49, V 3, UDF 0, IDF 1)
[     12198] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     12199]

[     12199] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46776, TTL 48, V 3, UDF 0, IDF 0)
[     12199] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[     12199]

[     12200] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46776, TTL 49, V 3, UDF 0, IDF 0)
[     12200] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     12200]

[     12200] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46776, TTL 48, V 3, UDF 0, IDF 0)
[     12201] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     12201]

[     12259] Forwarding packet (originator 10.1.1.1, seqno 6, TTL 50)
on interface wl0
[     12260] Forwarding packet (originator 10.1.1.1, seqno 6, TTL 50)
on interface eth0.0
[     12261] ------------------ DEBUG ------------------
[     12261] Forward list
[     12261]     10.0.1.3 at 13873
[     12261]     10.1.1.1 at 14227
[     12261] Originator list
[     12261]   Originator           Router (#/128):    Potential routers
[     12262] 10.1.1.20             10.1.1.20 (  5):       10.1.1.20 (
5)       10.1.1.10 (  1)
[     12262] 10.1.1.13             10.1.1.10 (  4):       10.1.1.10 (
4)       10.1.1.20 (  1)
[     12262] 10.1.1.10             10.1.1.10 (  6):       10.1.1.10 (  6)
[     12263] 10.1.1.33             10.1.1.33 (  2):       10.1.1.33 (  2)
[     12263] 10.0.1.1               10.0.1.1 (  6):        10.0.1.1 (  6)
[     12263] ---------------------------------------------- END DEBUG
[     12263]

[     12263] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.1, seqno 6, TTL 50, V 3, UDF 0, IDF 0)
[     12264] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     12264]

[     12264] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 6, TTL 50, V 3, UDF 0, IDF 0)
[     12264] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     12264]

[     12264] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 6, TTL 49, V 3, UDF 0, IDF 0)
[     12265] received my own OGM via NB lastTxIfSeqno: 6, currRxSeqno:
6, prevRxSeqno: 6, currRxSeqno-prevRxSeqno 0
[     12265] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[     12265] Drop packet: originator packet from myself (via neighbour)
[     12265]

[     12325] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46923, TTL 49, V 3, UDF 1, IDF 1)
[     12326] Drop packet: originator packet with unidirectional flag
[     12326]

[     12326] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46923, TTL 49, V 3, UDF 0, IDF 1)
[     12327] update_originator(): Searching and updating originator
entry of received packet,
[     12327] Updating existing last-hop neighbour of originator
[     12327] updating last_seqno: old 46921, new 46923
[     12327] update_routes()
[     12327] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     12327]

[     12368] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46943, TTL 50, V 3, UDF 0, IDF 0)
[     12369] update_originator(): Searching and updating originator
entry of received packet,
[     12369] Updating existing last-hop neighbour of originator
[     12369] updating last_seqno: old 46942, new 46943
[     12369] update_routes()
[     12369] schedule_forward_packet():
[     12369] Forward packet: rebroadcast neighbour packet with direct link flag
[     12369] Forwarding packet (originator 10.1.1.20, seqno 46943, TTL
49) on interface wl0
[     12370] Forwarding packet (originator 10.1.1.20, seqno 46943, TTL
49) on interface eth0.0
[     12371]

[     12371] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.20, seqno 46943, TTL 49, V 3, UDF 0, IDF 1)
[     12371] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     12371]

[     12372] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46943, TTL 49, V 3, UDF 0, IDF 1)
[     12373] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     12373]

[     12373] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46943, TTL 48, V 3, UDF 0, IDF 0)
[     12373] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[     12373]

[     12374] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46943, TTL 49, V 3, UDF 0, IDF 0)
[     12374] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     12374]

[     12374] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46943, TTL 48, V 3, UDF 0, IDF 0)
[     12375] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     12375]

[     13246] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6340, TTL 50, V 3, UDF 0, IDF 0)
[     13246] update_originator(): Searching and updating originator
entry of received packet,
[     13246] Updating existing last-hop neighbour of originator
[     13246] updating last_seqno: old 6339, new 6340
[     13246] update_routes()
[     13246] schedule_forward_packet():
[     13247] Forward packet: rebroadcast neighbour packet with direct link flag
[     13247] Forwarding packet (originator 10.0.1.1, seqno 6340, TTL
49) on interface wl0
[     13247] Forwarding packet (originator 10.0.1.1, seqno 6340, TTL
49) on interface eth0.0
[     13248]

[     13248] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.1, seqno 6340, TTL 49, V 3, UDF 0, IDF 0)
[     13249] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     13249]

[     13249] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6340, TTL 49, V 3, UDF 0, IDF 1)
[     13249] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     13249]

[     13251] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6340, TTL 48, V 3, UDF 0, IDF 0)
[     13251] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     13251]

[     13252] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6340, TTL 48, V 3, UDF 0, IDF 0)
[     13252] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     13252]

[     13318] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.33, seqno 23192, TTL 50, V 3, UDF 0, IDF 0)
[     13318] schedule_forward_packet():
[     13318] Forward packet: rebroadcast neighbour packet with direct
link and unidirectional flag
[     13318] Forwarding packet (originator 10.1.1.33, seqno 23192, TTL
49) on interface wl0
[     13319] ------------------ DEBUG ------------------
[     13319] Forward list
[     13319]     10.0.1.3 at 13873
[     13320]     10.1.1.1 at 14227
[     13320] Originator list
[     13320]   Originator           Router (#/128):    Potential routers
[     13320] 10.1.1.20             10.1.1.20 (  6):       10.1.1.20 (
6)       10.1.1.10 (  1)
[     13321] 10.1.1.13             10.1.1.10 (  4):       10.1.1.10 (
4)       10.1.1.20 (  2)
[     13321] 10.1.1.10             10.1.1.10 (  6):       10.1.1.10 (  6)
[     13321] 10.1.1.33             10.1.1.33 (  2):       10.1.1.33 (  2)
[     13321] 10.0.1.1               10.0.1.1 (  7):        10.0.1.1 (  7)
[     13321] ---------------------------------------------- END DEBUG
[     13321]

[     13322] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.33, seqno 23192, TTL 49, V 3, UDF 1, IDF 1)
[     13322] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     13322]

[     13879] Forwarding packet (originator 10.0.1.3, seqno 7, TTL 50)
on interface wl0
[     13880] Forwarding packet (originator 10.0.1.3, seqno 7, TTL 50)
on interface eth0.0
[     13881]

[     13881] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.3, seqno 7, TTL 50, V 3, UDF 0, IDF 0)
[     13881] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     13882]

[     13882] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 7, TTL 50, V 3, UDF 0, IDF 0)
[     13882] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     13882]

[     13882] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 7, TTL 49, V 3, UDF 0, IDF 1)
[     13883] received my own OGM via NB lastTxIfSeqno: 7, currRxSeqno:
7, prevRxSeqno: 6, currRxSeqno-prevRxSeqno 1
[     13883] indicating bidirectional link - updating bidirect_link seqno
[     13883] Drop packet: originator packet from myself (via neighbour)
[     13883]

[     13884] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.3, seqno 7, TTL 49, V 3, UDF 0, IDF 0)
[     13884] received my own OGM via NB lastTxIfSeqno: 6, currRxSeqno:
7, prevRxSeqno: 5, currRxSeqno-prevRxSeqno 2
[     13884] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[     13885] Drop packet: originator packet from myself (via neighbour)
[     13885]

[     13885] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.0.1.3, seqno 7, TTL 49, V 3, UDF 0, IDF 0)
[     13885] received my own OGM via NB lastTxIfSeqno: 6, currRxSeqno:
7, prevRxSeqno: 5, currRxSeqno-prevRxSeqno 2
[     13885] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[     13885] Drop packet: originator packet from myself (via neighbour)
[     13886]

[     14164] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46777, TTL 50, V 3, UDF 0, IDF 0)
[     14164] update_originator(): Searching and updating originator
entry of received packet,
[     14165] Updating existing last-hop neighbour of originator
[     14165] updating last_seqno: old 46776, new 46777
[     14165] update_routes()
[     14165] schedule_forward_packet():
[     14165] Forward packet: rebroadcast neighbour packet with direct link flag
[     14165] Forwarding packet (originator 10.1.1.10, seqno 46777, TTL
49) on interface wl0
[     14166] Forwarding packet (originator 10.1.1.10, seqno 46777, TTL
49) on interface eth0.0
[     14167]

[     14167] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.10, seqno 46777, TTL 49, V 3, UDF 0, IDF 1)
[     14167] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     14167]

[     14168] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46777, TTL 49, V 3, UDF 0, IDF 0)
[     14168] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     14168]

[     14169] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46777, TTL 49, V 3, UDF 0, IDF 1)
[     14169] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     14169]

[     14170] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46777, TTL 48, V 3, UDF 0, IDF 0)
[     14170] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     14170]

[     14170] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46777, TTL 48, V 3, UDF 0, IDF 0)
[     14171] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[     14171]

[     14229] Forwarding packet (originator 10.1.1.1, seqno 7, TTL 50)
on interface wl0
[     14230] Forwarding packet (originator 10.1.1.1, seqno 7, TTL 50)
on interface eth0.0
[     14231]

[     14231] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.1, seqno 7, TTL 50, V 3, UDF 0, IDF 0)
[     14231] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     14231]

[     14232] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 7, TTL 50, V 3, UDF 0, IDF 0)
[     14232] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     14232]

[     14232] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 7, TTL 49, V 3, UDF 0, IDF 0)
[     14233] received my own OGM via NB lastTxIfSeqno: 7, currRxSeqno:
7, prevRxSeqno: 7, currRxSeqno-prevRxSeqno 0
[     14233] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[     14233] Drop packet: originator packet from myself (via neighbour)
[     14233]

[     14233] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.1, seqno 7, TTL 49, V 3, UDF 0, IDF 1)
[     14234] received my own OGM via NB lastTxIfSeqno: 7, currRxSeqno:
7, prevRxSeqno: 5, currRxSeqno-prevRxSeqno 2
[     14234] indicating bidirectional link - updating bidirect_link seqno
[     14234] Drop packet: originator packet from myself (via neighbour)
[     14234]

[     14235] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.1, seqno 7, TTL 49, V 3, UDF 0, IDF 1)
[     14235] received my own OGM via NB lastTxIfSeqno: 7, currRxSeqno:
7, prevRxSeqno: 5, currRxSeqno-prevRxSeqno 2
[     14235] indicating bidirectional link - updating bidirect_link seqno
[     14235] Drop packet: originator packet from myself (via neighbour)
[     14235]

[     14316] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46924, TTL 49, V 3, UDF 1, IDF 1)
[     14317] Drop packet: originator packet with unidirectional flag
[     14317]

[     14458] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46944, TTL 50, V 3, UDF 0, IDF 0)
[     14458] update_originator(): Searching and updating originator
entry of received packet,
[     14459] Updating existing last-hop neighbour of originator
[     14459] updating last_seqno: old 46943, new 46944
[     14459] update_routes()
[     14459] schedule_forward_packet():
[     14459] Forward packet: rebroadcast neighbour packet with direct link flag
[     14459] Forwarding packet (originator 10.1.1.20, seqno 46944, TTL
49) on interface wl0
[     14460] Forwarding packet (originator 10.1.1.20, seqno 46944, TTL
49) on interface eth0.0
[     14461] ------------------ DEBUG ------------------
[     14461] Forward list
[     14461]     10.0.1.3 at 15868
[     14461]     10.1.1.1 at 16247
[     14461] Originator list
[     14462]   Originator           Router (#/128):    Potential routers
[     14463] 10.1.1.20             10.1.1.20 (  7):       10.1.1.20 (
7)       10.1.1.10 (  1)
[     14463] 10.1.1.13             10.1.1.10 (  4):       10.1.1.10 (
4)       10.1.1.20 (  2)
[     14463] 10.1.1.10             10.1.1.10 (  7):       10.1.1.10 (  7)
[     14463] 10.1.1.33             10.1.1.33 (  2):       10.1.1.33 (  2)
[     14464] 10.0.1.1               10.0.1.1 (  7):        10.0.1.1 (  7)
[     14464] ---------------------------------------------- END DEBUG
[     14464]

[     14464] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.20, seqno 46944, TTL 49, V 3, UDF 0, IDF 1)
[     14464] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     14465]

[     14465] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46944, TTL 49, V 3, UDF 0, IDF 1)
[     14465] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     14465]

[     14465] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46944, TTL 48, V 3, UDF 0, IDF 0)
[     14466] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[     14466]

[     14466] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46944, TTL 49, V 3, UDF 0, IDF 0)
[     14467] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     14467]

[     14467] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46944, TTL 48, V 3, UDF 0, IDF 0)
[     14467] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     14467]

[     15238] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.33, seqno 23193, TTL 50, V 3, UDF 0, IDF 0)
[     15238] schedule_forward_packet():
[     15238] Forward packet: rebroadcast neighbour packet with direct
link and unidirectional flag
[     15238] Forwarding packet (originator 10.1.1.33, seqno 23193, TTL
49) on interface wl0
[     15239]

[     15239] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.33, seqno 23193, TTL 49, V 3, UDF 1, IDF 1)
[     15240] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     15240]

[     15305] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6341, TTL 50, V 3, UDF 0, IDF 0)
[     15306] update_originator(): Searching and updating originator
entry of received packet,
[     15306] Updating existing last-hop neighbour of originator
[     15306] updating last_seqno: old 6340, new 6341
[     15306] update_routes()
[     15306] schedule_forward_packet():
[     15306] Forward packet: rebroadcast neighbour packet with direct link flag
[     15307] Forwarding packet (originator 10.0.1.1, seqno 6341, TTL
49) on interface wl0
[     15307] Forwarding packet (originator 10.0.1.1, seqno 6341, TTL
49) on interface eth0.0
[     15308]

[     15308] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.1, seqno 6341, TTL 49, V 3, UDF 0, IDF 0)
[     15308] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     15309]

[     15309] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6341, TTL 49, V 3, UDF 0, IDF 1)
[     15309] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     15310]

[     15311] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6341, TTL 48, V 3, UDF 0, IDF 0)
[     15312] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     15312]

[     15312] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6341, TTL 48, V 3, UDF 0, IDF 0)
[     15313] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     15313]

[     15869] Forwarding packet (originator 10.0.1.3, seqno 8, TTL 50)
on interface wl0
[     15870] Forwarding packet (originator 10.0.1.3, seqno 8, TTL 50)
on interface eth0.0
[     15871] ------------------ DEBUG ------------------
[     15871] Forward list
[     15871]     10.1.1.1 at 16247
[     15871]     10.0.1.3 at 17792
[     15872] Originator list
[     15872]   Originator           Router (#/128):    Potential routers
[     15872] 10.1.1.20             10.1.1.20 (  7):       10.1.1.20 (
7)       10.1.1.10 (  1)
[     15872] 10.1.1.13             10.1.1.10 (  4):       10.1.1.10 (
4)       10.1.1.20 (  2)
[     15873] 10.1.1.10             10.1.1.10 (  7):       10.1.1.10 (  7)
[     15873] 10.1.1.33             10.1.1.33 (  2):       10.1.1.33 (  2)
[     15873] 10.0.1.1               10.0.1.1 (  8):        10.0.1.1 (  8)
[     15873] ---------------------------------------------- END DEBUG
[     15873]

[     15874] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.3, seqno 8, TTL 50, V 3, UDF 0, IDF 0)
[     15874] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     15874]

[     15874] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 8, TTL 50, V 3, UDF 0, IDF 0)
[     15874] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     15875]

[     15875] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 8, TTL 49, V 3, UDF 0, IDF 1)
[     15875] received my own OGM via NB lastTxIfSeqno: 8, currRxSeqno:
8, prevRxSeqno: 7, currRxSeqno-prevRxSeqno 1
[     15875] indicating bidirectional link - updating bidirect_link seqno
[     15875] Drop packet: originator packet from myself (via neighbour)
[     15875]

[     15876] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.0.1.3, seqno 8, TTL 49, V 3, UDF 0, IDF 0)
[     15877] received my own OGM via NB lastTxIfSeqno: 7, currRxSeqno:
8, prevRxSeqno: 0, currRxSeqno-prevRxSeqno 8
[     15877] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[     15877] Drop packet: originator packet from myself (via neighbour)
[     15877]

[     15877] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.3, seqno 8, TTL 49, V 3, UDF 0, IDF 0)
[     15878] received my own OGM via NB lastTxIfSeqno: 7, currRxSeqno:
8, prevRxSeqno: 7, currRxSeqno-prevRxSeqno 1
[     15878] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[     15878] Drop packet: originator packet from myself (via neighbour)
[     15878]

[     16225] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46925, TTL 49, V 3, UDF 1, IDF 1)
[     16226] Drop packet: originator packet with unidirectional flag
[     16226]

[     16226] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46925, TTL 49, V 3, UDF 0, IDF 1)
[     16227] update_originator(): Searching and updating originator
entry of received packet,
[     16227] Updating existing last-hop neighbour of originator
[     16227] updating last_seqno: old 46923, new 46925
[     16227] update_routes()
[     16227] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     16227]

[     16228] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46778, TTL 50, V 3, UDF 0, IDF 0)
[     16229] update_originator(): Searching and updating originator
entry of received packet,
[     16229] Updating existing last-hop neighbour of originator
[     16229] updating last_seqno: old 46777, new 46778
[     16229] update_routes()
[     16229] schedule_forward_packet():
[     16229] Forward packet: rebroadcast neighbour packet with direct link flag
[     16229] Forwarding packet (originator 10.1.1.10, seqno 46778, TTL
49) on interface wl0
[     16230] Forwarding packet (originator 10.1.1.10, seqno 46778, TTL
49) on interface eth0.0
[     16231]

[     16231] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.10, seqno 46778, TTL 49, V 3, UDF 0, IDF 1)
[     16231] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     16232]

[     16232] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46778, TTL 49, V 3, UDF 0, IDF 0)
[     16232] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     16232]

[     16232] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46778, TTL 48, V 3, UDF 0, IDF 0)
[     16233] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     16233]

[     16235] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46778, TTL 48, V 3, UDF 0, IDF 0)
[     16235] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[     16235]

[     16249] Forwarding packet (originator 10.1.1.1, seqno 8, TTL 50)
on interface wl0
[     16250] Forwarding packet (originator 10.1.1.1, seqno 8, TTL 50)
on interface eth0.0
[     16251]

[     16251] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.1, seqno 8, TTL 50, V 3, UDF 0, IDF 0)
[     16251] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     16251]

[     16252] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 8, TTL 50, V 3, UDF 0, IDF 0)
[     16252] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     16252]

[     16252] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 8, TTL 49, V 3, UDF 0, IDF 0)
[     16252] received my own OGM via NB lastTxIfSeqno: 8, currRxSeqno:
8, prevRxSeqno: 8, currRxSeqno-prevRxSeqno 0
[     16253] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[     16253] Drop packet: originator packet from myself (via neighbour)
[     16253]

[     16253] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.1, seqno 8, TTL 49, V 3, UDF 0, IDF 1)
[     16254] received my own OGM via NB lastTxIfSeqno: 8, currRxSeqno:
8, prevRxSeqno: 7, currRxSeqno-prevRxSeqno 1
[     16254] indicating bidirectional link - updating bidirect_link seqno
[     16254] Drop packet: originator packet from myself (via neighbour)
[     16254]

[     16255] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.1, seqno 8, TTL 49, V 3, UDF 0, IDF 1)
[     16255] received my own OGM via NB lastTxIfSeqno: 8, currRxSeqno:
8, prevRxSeqno: 7, currRxSeqno-prevRxSeqno 1
[     16255] indicating bidirectional link - updating bidirect_link seqno
[     16255] Drop packet: originator packet from myself (via neighbour)
[     16255]

[     16508] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46945, TTL 50, V 3, UDF 0, IDF 0)
[     16509] update_originator(): Searching and updating originator
entry of received packet,
[     16509] Updating existing last-hop neighbour of originator
[     16509] updating last_seqno: old 46944, new 46945
[     16509] update_routes()
[     16509] schedule_forward_packet():
[     16509] Forward packet: rebroadcast neighbour packet with direct link flag
[     16509] Forwarding packet (originator 10.1.1.20, seqno 46945, TTL
49) on interface wl0
[     16510] Forwarding packet (originator 10.1.1.20, seqno 46945, TTL
49) on interface eth0.0
[     16511]

[     16511] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.20, seqno 46945, TTL 49, V 3, UDF 0, IDF 1)
[     16511] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     16511]

[     16512] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46945, TTL 49, V 3, UDF 0, IDF 0)
[     16512] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     16513]

[     16513] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46945, TTL 49, V 3, UDF 0, IDF 1)
[     16513] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     16513]

[     16514] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46945, TTL 48, V 3, UDF 0, IDF 0)
[     16514] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[     16514]

[     16514] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46945, TTL 48, V 3, UDF 0, IDF 0)
[     16515] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     16515]

[     17288] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.33, seqno 23194, TTL 50, V 3, UDF 0, IDF 0)
[     17288] schedule_forward_packet():
[     17288] Forward packet: rebroadcast neighbour packet with direct
link and unidirectional flag
[     17288] Forwarding packet (originator 10.1.1.33, seqno 23194, TTL
49) on interface wl0
[     17289] ------------------ DEBUG ------------------
[     17289] Forward list
[     17289]     10.0.1.3 at 17792
[     17290]     10.1.1.1 at 18250
[     17290] Originator list
[     17290]   Originator           Router (#/128):    Potential routers
[     17290] 10.1.1.20             10.1.1.20 (  8):       10.1.1.20 (
8)       10.1.1.10 (  1)
[     17290] 10.1.1.13             10.1.1.10 (  4):       10.1.1.10 (
4)       10.1.1.20 (  3)
[     17291] 10.1.1.10             10.1.1.10 (  8):       10.1.1.10 (  8)
[     17291] 10.1.1.33             10.1.1.33 (  2):       10.1.1.33 (  2)
[     17291] 10.0.1.1               10.0.1.1 (  8):        10.0.1.1 (  8)
[     17291] ---------------------------------------------- END DEBUG
[     17291]

[     17292] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.33, seqno 23194, TTL 49, V 3, UDF 1, IDF 1)
[     17292] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     17292]

[     17325] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6342, TTL 50, V 3, UDF 0, IDF 0)
[     17326] update_originator(): Searching and updating originator
entry of received packet,
[     17326] Updating existing last-hop neighbour of originator
[     17326] updating last_seqno: old 6341, new 6342
[     17326] update_routes()
[     17326] schedule_forward_packet():
[     17326] Forward packet: rebroadcast neighbour packet with direct link flag
[     17326] Forwarding packet (originator 10.0.1.1, seqno 6342, TTL
49) on interface wl0
[     17327] Forwarding packet (originator 10.0.1.1, seqno 6342, TTL
49) on interface eth0.0
[     17328]

[     17328] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.1, seqno 6342, TTL 49, V 3, UDF 0, IDF 0)
[     17328] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     17328]

[     17329] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6342, TTL 49, V 3, UDF 0, IDF 1)
[     17329] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     17329]

[     17333] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6342, TTL 48, V 3, UDF 0, IDF 0)
[     17333] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     17333]

[     17789]

[     17799] Forwarding packet (originator 10.0.1.3, seqno 9, TTL 50)
on interface wl0
[     17800] Forwarding packet (originator 10.0.1.3, seqno 9, TTL 50)
on interface eth0.0
[     17801]

[     17801] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.3, seqno 9, TTL 50, V 3, UDF 0, IDF 0)
[     17801] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     17802]

[     17802] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 9, TTL 50, V 3, UDF 0, IDF 0)
[     17802] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     17802]

[     17802] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.3, seqno 9, TTL 49, V 3, UDF 0, IDF 1)
[     17803] received my own OGM via NB lastTxIfSeqno: 9, currRxSeqno:
9, prevRxSeqno: 8, currRxSeqno-prevRxSeqno 1
[     17803] indicating bidirectional link - updating bidirect_link seqno
[     17803] Drop packet: originator packet from myself (via neighbour)
[     17803]

[     17804] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.0.1.3, seqno 9, TTL 49, V 3, UDF 0, IDF 0)
[     17804] received my own OGM via NB lastTxIfSeqno: 8, currRxSeqno:
9, prevRxSeqno: 8, currRxSeqno-prevRxSeqno 1
[     17805] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[     17805] Drop packet: originator packet from myself (via neighbour)
[     17805]

[     17805] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.3, seqno 9, TTL 49, V 3, UDF 0, IDF 0)
[     17805] received my own OGM via NB lastTxIfSeqno: 8, currRxSeqno:
9, prevRxSeqno: 8, currRxSeqno-prevRxSeqno 1
[     17805] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[     17805] Drop packet: originator packet from myself (via neighbour)
[     17806]

[     18249]

[     18254] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46779, TTL 50, V 3, UDF 0, IDF 0)
[     18255] update_originator(): Searching and updating originator
entry of received packet,
[     18255] Updating existing last-hop neighbour of originator
[     18255] updating last_seqno: old 46778, new 46779
[     18255] update_routes()
[     18255] schedule_forward_packet():
[     18255] Forward packet: rebroadcast neighbour packet with direct link flag
[     18255] Forwarding packet (originator 10.1.1.10, seqno 46779, TTL
49) on interface wl0
[     18256] Forwarding packet (originator 10.1.1.10, seqno 46779, TTL
49) on interface eth0.0
[     18257] Forwarding packet (originator 10.1.1.1, seqno 9, TTL 50)
on interface wl0
[     18258] Forwarding packet (originator 10.1.1.1, seqno 9, TTL 50)
on interface eth0.0
[     18258]

[     18259] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.10, seqno 46779, TTL 49, V 3, UDF 0, IDF 1)
[     18259] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     18260]

[     18260] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46779, TTL 49, V 3, UDF 0, IDF 1)
[     18260] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     18260]

[     18260] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.1, seqno 9, TTL 50, V 3, UDF 0, IDF 0)
[     18261] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     18261]

[     18262] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46779, TTL 48, V 3, UDF 0, IDF 0)
[     18262] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[     18262]

[     18262] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.1, seqno 9, TTL 49, V 3, UDF 0, IDF 1)
[     18263] received my own OGM via NB lastTxIfSeqno: 9, currRxSeqno:
9, prevRxSeqno: 8, currRxSeqno-prevRxSeqno 1
[     18263] indicating bidirectional link - updating bidirect_link seqno
[     18263] Drop packet: originator packet from myself (via neighbour)
[     18263]

[     18263] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.1, seqno 9, TTL 49, V 3, UDF 0, IDF 1)
[     18263] received my own OGM via NB lastTxIfSeqno: 9, currRxSeqno:
9, prevRxSeqno: 8, currRxSeqno-prevRxSeqno 1
[     18264] indicating bidirectional link - updating bidirect_link seqno
[     18264] Drop packet: originator packet from myself (via neighbour)
[     18264]

[     18264] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46779, TTL 49, V 3, UDF 0, IDF 0)
[     18264] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     18264]

[     18265] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.10, seqno 46779, TTL 48, V 3, UDF 0, IDF 0)
[     18265] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     18265]

[     18265] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 9, TTL 50, V 3, UDF 0, IDF 0)
[     18266] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     18266]

[     18266] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.1, seqno 9, TTL 49, V 3, UDF 0, IDF 0)
[     18266] received my own OGM via NB lastTxIfSeqno: 9, currRxSeqno:
9, prevRxSeqno: 9, currRxSeqno-prevRxSeqno 0
[     18266] NOT indicating bidirectional link - NOT updating
bidirect_link seqno
[     18267] Drop packet: originator packet from myself (via neighbour)
[     18267]

[     18296] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46926, TTL 49, V 3, UDF 0, IDF 1)
[     18296] update_originator(): Searching and updating originator
entry of received packet,
[     18296] Updating existing last-hop neighbour of originator
[     18296] updating last_seqno: old 46925, new 46926
[     18297] update_routes()
[     18297] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     18297] ------------------ DEBUG ------------------
[     18297] Forward list
[     18297]     10.0.1.3 at 19845
[     18297]     10.1.1.1 at 20255
[     18297] Originator list
[     18298]   Originator           Router (#/128):    Potential routers
[     18298] 10.1.1.20             10.1.1.20 (  8):       10.1.1.20 (
8)       10.1.1.10 (  1)
[     18298] 10.1.1.13             10.1.1.10 (  4):       10.1.1.10 (
4)       10.1.1.20 (  4)
[     18298] 10.1.1.10             10.1.1.10 (  9):       10.1.1.10 (  9)
[     18299] 10.1.1.33             10.1.1.33 (  2):       10.1.1.33 (  2)
[     18299] 10.0.1.1               10.0.1.1 (  9):        10.0.1.1 (  9)
[     18299] ---------------------------------------------- END DEBUG
[     18299]

[     18299] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46926, TTL 49, V 3, UDF 0, IDF 1)
[     18300] schedule_forward_packet():
[     18300] Forward packet: duplicate packet received via best
neighbour with best ttl
[     18300] Forwarding packet (originator 10.1.1.13, seqno 46926, TTL
48) on interface wl0
[     18301] Forwarding packet (originator 10.1.1.13, seqno 46926, TTL
48) on interface eth0.0
[     18301]

[     18302] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.13, seqno 46926, TTL 48, V 3, UDF 0, IDF 0)
[     18302] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     18302]

[     18302] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.13, seqno 46926, TTL 48, V 3, UDF 0, IDF 0)
[     18303] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     18303]

[     18303] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.13, seqno 46926, TTL 47, V 3, UDF 0, IDF 0)
[     18304] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     18304]

[     18304] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.13, seqno 46926, TTL 47, V 3, UDF 0, IDF 0)
[     18304] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[     18304]

[     18538] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46946, TTL 50, V 3, UDF 0, IDF 0)
[     18539] update_originator(): Searching and updating originator
entry of received packet,
[     18539] Updating existing last-hop neighbour of originator
[     18539] updating last_seqno: old 46945, new 46946
[     18539] update_routes()
[     18539] schedule_forward_packet():
[     18539] Forward packet: rebroadcast neighbour packet with direct link flag
[     18539] Forwarding packet (originator 10.1.1.20, seqno 46946, TTL
49) on interface wl0
[     18540] Forwarding packet (originator 10.1.1.20, seqno 46946, TTL
49) on interface eth0.0
[     18541]

[     18541] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.20, seqno 46946, TTL 49, V 3, UDF 0, IDF 1)
[     18541] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     18541]

[     18542] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46946, TTL 49, V 3, UDF 0, IDF 0)
[     18542] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     18543]

[     18543] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46946, TTL 49, V 3, UDF 0, IDF 1)
[     18543] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     18544]

[     18544] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.20, seqno 46946, TTL 48, V 3, UDF 0, IDF 0)
[     18544] Drop packet: received via bidirectional link:  NO, BNTOG:  NO !
[     18544]

[     18544] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.1.1.20, seqno 46946, TTL 48, V 3, UDF 0, IDF 0)
[     18545] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     18545]

[     19198] Received BATMAN packet via NB: 10.1.1.33, IF: wl0
10.1.1.1 (from OG: 10.1.1.33, seqno 23195, TTL 50, V 3, UDF 0, IDF 0)
[     19198] schedule_forward_packet():
[     19198] Forward packet: rebroadcast neighbour packet with direct
link and unidirectional flag
[     19198] Forwarding packet (originator 10.1.1.33, seqno 23195, TTL
49) on interface wl0
[     19199]

[     19199] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.1.1.33, seqno 23195, TTL 49, V 3, UDF 1, IDF 1)
[     19200] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     19200]

[     19285] Received BATMAN packet via NB: 10.0.1.1, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6343, TTL 50, V 3, UDF 0, IDF 0)
[     19286] update_originator(): Searching and updating originator
entry of received packet,
[     19286] Updating existing last-hop neighbour of originator
[     19286] updating last_seqno: old 6342, new 6343
[     19286] update_routes()
[     19286] schedule_forward_packet():
[     19286] Forward packet: rebroadcast neighbour packet with direct link flag
[     19286] Forwarding packet (originator 10.0.1.1, seqno 6343, TTL
49) on interface wl0
[     19287] Forwarding packet (originator 10.0.1.1, seqno 6343, TTL
49) on interface eth0.0
[     19287]

[     19288] Received BATMAN packet via NB: 10.1.1.1, IF: wl0 10.1.1.1
(from OG: 10.0.1.1, seqno 6343, TTL 49, V 3, UDF 0, IDF 0)
[     19288] Drop packet: received my own broadcast (sender: 10.1.1.1)
[     19288]

[     19288] Received BATMAN packet via NB: 10.0.1.3, IF: eth0.0
10.0.1.3 (from OG: 10.0.1.1, seqno 6343, TTL 49, V 3, UDF 0, IDF 1)
[     19289] Drop packet: received my own broadcast (sender: 10.0.1.3)
[     19289]

[     19290] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6343, TTL 48, V 3, UDF 0, IDF 0)
[     19290] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     19291]

[     19291] Received BATMAN packet via NB: 10.1.1.20, IF: wl0
10.1.1.1 (from OG: 10.0.1.1, seqno 6343, TTL 48, V 3, UDF 0, IDF 0)
[     19291] Drop packet: received via bidirectional link: YES, BNTOG:  NO !
[     19292]

[     20225] Received BATMAN packet via NB: 10.1.1.10, IF: wl0
10.1.1.1 (from OG: 10.1.1.10, seqno 46780, TTL 50, V 3, UDF 0, IDF 0)
[     20225] update_originator(): Searching and updating originator
entry of received packet,
[     20225] Updating existing last-hop neighbour of originator
[     20225] updating last_seqno: old 46779, new 46780
[     20225] update_routes()
[     20225] schedule_forward_packet():
[     20226] Forward packet: rebroadcast neighbour packet with direct link flag
[     20226] Forwarding packet (originator 10.1.1.10, seqno 46780, TTL
49) on interface wl0
[     20226] Forwarding packet (originator 10.1.1.10, seqno 46780, TTL
49) on interface eth0.0
[     20227] Forwarding packet (originator 10.0.1.3, seqno 10, TTL 50)
on interface wl0
[     20228] Forwarding packet (originator 10.0.1.3, seqno 10, TTL 50)
on interface eth0.0
[     20229] ------------------ DEBUG ------------------
[     20229] Forward list
[     20229]     10.1.1.1 at 20255
[     20230]     10.0.1.3 at 22243
[     20230] Originator list
[     20230]   Originator           Router (#/128):    Potential routers
[     20230] 10.1.1.20             10.1.1.20 (  9):       10.1.1.20 (
9)       10.1.1.10 (  1)
[     20231] 10.1.1.13             10.1.1.10 (  4):       10.1.1.10 (
4)       10.1.1.20 (  4)
[     20231] 10.1.1.10             10.1.1.10 ( 10):       10.1.1.10 ( 10)
[     20231] 10.1.1.33             10.1.1.33 (  2):       10.1.1.33 (  2)
[     20231] 10.0.1.1               10.0.1.1 ( 10):        10.0.1.1 ( 10)
[     20231] ---------------------------------------------- END DEBUG
[     20232] Orginator timeout: originator 10.1.1.20, last_valid 18538
[     20232] update_routes()
[     20232] Deleting previous route
[     20232] Deleting route to 10.1.1.20 via 0.0.0.0 (wl0)
[     20233] Orginator timeout: originator 10.1.1.13, last_valid 18299
[     20234] update_routes()
[     20234] Deleting previous route
[     20234] Deleting route to 10.1.1.13/32 via 10.1.1.10 (wl0)
[     20234] Orginator timeout: originator 10.1.1.10, last_valid 20225
[     20235] update_routes()
[     20235] Deleting previous route
[     20235] Deleting route to 10.1.1.10 via 0.0.0.0 (wl0)
[     20236] Orginator timeout: originator 10.1.1.33, last_valid 3318
[     20236] update_routes()
[     20236] Deleting previous route
[     20236] Deleting route to 10.1.1.33 via 0.0.0.0 (wl0)
[     20237] Orginator timeout: originator 10.0.1.1, last_valid 19285
[     20237] update_routes()
[     20237] Deleting previous route
[     20237] Deleting route to 10.0.1.1 via 0.0.0.0 (eth0.0)
