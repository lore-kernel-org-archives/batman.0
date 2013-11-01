Return-Path: <bittorf@bluebottle.com>
Date: Fri, 1 Nov 2013 08:55:58 +0100
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20131101075558.GI6252@medion.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] lost connection to a client / Q: transglobal-table
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

in my small office-network we have _often_ the situation,
that my laptop 8-) has no internet. if this happens, i can
connect via ssh hop by hop and can see, that the network
itself (wireless/wired) is working, but the 'routes' are wrong.

here the transglobal-table in the master, my laptop is '00:21:6a:32:7c:1c'

root@EG-labor-AP:~ batctl tg
Globally announced TT entries received via the mesh bat0
       Client        (TTVN)       Originator      (Curr TTVN) (CRC   )
Flags
 * 02:00:c0:ca:c0:1a  (  8) via 02:00:ca:b1:00:15     (  8)   (0xe285) [...]
 * 06:2f:65:8a:d2:b7  (  1) via 02:00:ca:b1:00:02     (  1)   (0x50f6) [...]
 * 46:0a:75:3c:f2:47  (  1) via 02:00:ca:b1:00:15     (  8)   (0xe285) [...]
 * 5e:27:29:d8:ee:b4  (  1) via 02:00:ca:b1:00:76     (  1)   (0xc9fc) [...]
 * 72:f7:18:80:9d:9d  ( 86) via 02:00:de:ad:00:03     ( 86)   (0x7651) [...]
 * ae:d9:0f:ef:01:c3  (  1) via 02:00:ca:b1:02:22     (  5)   (0x6456) [...]
 * 56:fb:55:27:b2:63  (  1) via 02:00:ca:b1:00:58     (  5)   (0xac7c) [...]
 * 46:13:bf:2a:53:1e  (  1) via 02:00:ca:b1:00:13     (  5)   (0x8133) [...]
 * 0a:c6:fd:60:5d:5f  (  1) via 02:00:de:ad:02:23     (  1)   (0xa1c1) [...]
### interesting part:
 * 00:21:6a:32:7c:1c  (  4) via 02:00:ca:b1:02:22     (  5)   (0x6456) [.W.]
 + 00:21:6a:32:7c:1c  (  5) via 02:00:ca:b1:00:13     (  5)   [.W.]
###
 * e6:ad:ca:24:f6:10  (  1) via 02:00:ca:b1:00:45     (  3)   (0x6182) [...]

root@EG-labor-AP:~ batctl -v
batctl 2013.4.0 [batman-adv: 2013.4.0]

root@EG-labor-AP:~ cat /etc/openwrt_version 
r38568

the interesting thing is, that my laptop seems to be reachable via
*:02:22 and *:00:13 - the 2nd entry has no hash (?), but 'batctl t 00:21:6a:32:7c:1c'
outputs *:00:13 as originator. from the topology, it is impossible to be
near this node, so no roaming can happen AND i can see on my laptop,
that there was no roaming. the situation recovers without interaction after some
minutes. the transglobal table does not change, but 'batctl t 00:21:6a:32:7c:1c' 
outputs the correct *:02:22

what can i do for more debugging or is this bug already solved in trunk?

bye, bastian
