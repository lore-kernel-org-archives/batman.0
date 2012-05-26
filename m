Return-Path: <puyou.lu@gmail.com>
Message-ID: <4fc0a063.2a04440a.04d9.ffffbef5@mx.google.com>
From: "puyou.lu" <puyou.lu@gmail.com>
Date: Sat, 26 May 2012 17:20:28 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Can't create new originator
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi.
I saw strange batman logs while testing a batman-adv mesh. Batman-adv =
module was continuously generating the same logs including a " Creating =
new originator: b0:c6:9b:80:01:43". But b0:c6:9b:80:01:43 never appears =
in the output of 'batctl o':
admin@HND-Mesh:~# batctl o
[B.A.T.M.A.N. adv 2012.0.0, MainIF/MAC: wlan0/b0:c6:9b:80:01:5b (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   =
Potential nexthops ...
b0:c6:9b:80:01:5c    0.010s   (255) b0:c6:9b:80:01:5c [     wlan0]: =
b0:c6:9b:80:01:5f (209) b0:c6:9b:80:01:6b (231) b0:c6:9b:80:01:6b (227) =
b0:c6:9b:80:01:5c (255) b0:c6:9b:80:01:5c (  0)
b0:c6:9b:80:01:45    3.830s   (223) b0:c6:9b:80:01:5f [     wlan0]: =
b0:c6:9b:80:01:5c (209) b0:c6:9b:80:01:6b (  0) b0:c6:9b:80:01:6b (  0) =
b0:c6:9b:80:01:5f (223)
b0:c6:9b:80:01:6b    4.520s   (255) b0:c6:9b:80:01:6b [     wlan0]: =
b0:c6:9b:80:01:5f (206) b0:c6:9b:80:01:5c (245) b0:c6:9b:80:01:6b (255) =
b0:c6:9b:80:01:6b (251)
b0:c6:9b:80:01:3b    1.570s   (237) b0:c6:9b:80:01:5f [     wlan0]: =
b0:c6:9b:80:01:5c (226) b0:c6:9b:80:01:6b (  0) b0:c6:9b:80:01:6b (  0) =
b0:c6:9b:80:01:5f (237)
b0:c6:9b:80:01:5f    3.520s   (255) b0:c6:9b:80:01:5f [     wlan0]: =
b0:c6:9b:80:01:6b (231) b0:c6:9b:80:01:6b (227) b0:c6:9b:80:01:5c (244) =
b0:c6:9b:80:01:5f (255)

Now I can nerver reach b0:c6:9b:80:01:43. Anyone tell me why this =
happens?
And, what does "Drop packet: packet within seqno protection time" mean? =
What is the "seqno protection time"?
Any help will be appreciated and thanks in advance.

Here is part of the looply generated logs:
[       969] Creating new originator: b0:c6:9b:80:01:43
[       969] old packet received, start protection
[       969] Drop packet: OGM via unknown neighbor!
[       969] Received BATMAN packet via NB: b0:c6:9b:80:01:57, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:43, via prev OG: =
b0:c6:9b:80:01:59, seqno 109828, ttvn 6, crc 5961, changes 0, td 229, =
TTL 48, V 14, IDF 0)
[       969] Drop packet: packet within seqno protection time (sender: =
b0:c6:9b:80:01:57)
[       969] Sending own packet (originator b0:c6:9b:80:01:56, seqno =
1251, TTL 2) on interface wlan1 [b0:c6:9b:80:01:56]
[       969] Received BATMAN packet via NB: b0:c6:9b:80:01:56, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:56, via prev OG: =
b0:c6:9b:80:01:56, seqno 1251, ttvn 2, crc 51283, changes 0, td 255, TTL =
2, V 14, IDF 0)
[       969] Drop packet: received my own broadcast (sender: =
b0:c6:9b:80:01:56)
[       969] Received BATMAN packet via NB: b0:c6:9b:80:01:6b, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:56, via prev OG: =
b0:c6:9b:80:01:56, seqno 1251, ttvn 2, crc 51283, changes 0, td 233, TTL =
1, V 14, IDF 1)
[       969] Drop packet: originator packet from myself (via neighbor)
[       969] Received BATMAN packet via NB: b0:c6:9b:80:01:6b, IF: wlan1 =
[b0:c6:9b:80:01:56] (from OG: b0:c6:9b:80:01:56, via prev OG: =
b0:c6:9b:80:01:56, seqno 1251, ttvn 2, crc 51283, changes 0, td 233, TTL =
1, V 14, IDF 1)
[       969] Drop packet: originator packet from myself (via neighbor)
[       969] Sending own packet (originator b0:c6:9b:80:01:5b, seqno =
1251, TQ 255, TTL 50, IDF off, ttvn 2) on interface wlan0 =
[b0:c6:9b:80:01:5b]
[       969] Sending own packet (originator b0:c6:9b:80:01:5b, seqno =
1251, TQ 255, TTL 50, IDF off, ttvn 2) on interface wlan1 =
[b0:c6:9b:80:01:56]
[       969] Received BATMAN packet via NB: b0:c6:9b:80:01:5b, IF: wlan1 =
[b0:c6:9b:80:01:56] (from OG: b0:c6:9b:80:01:5b, via prev OG: =
b0:c6:9b:80:01:5b, seqno 1251, ttvn 2, crc 51283, changes 0, td 255, TTL =
50, V 14, IDF 0)
[       969] Drop packet: received my own broadcast (sender: =
b0:c6:9b:80:01:5b)
[       969] Received BATMAN packet via NB: b0:c6:9b:80:01:56, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5b, via prev OG: =
b0:c6:9b:80:01:5b, seqno 1251, ttvn 2, crc 51283, changes 0, td 255, TTL =
50, V 14, IDF 0)
[       969] Drop packet: received my own broadcast (sender: =
b0:c6:9b:80:01:56)
[       969] Received BATMAN packet via NB: b0:c6:9b:80:01:5d, IF: wlan1 =
[b0:c6:9b:80:01:56] (from OG: b0:c6:9b:80:01:5d, via prev OG: =
b0:c6:9b:80:01:5d, seqno 1246, ttvn 2, crc 38681, changes 0, td 255, TTL =
2, V 14, IDF 0)
[       969] updating last_seqno: old 1245, new 1246
[       969] bidirectional: orig =3D b0:c6:9b:80:01:5d neigh =3D =
b0:c6:9b:80:01:5d =3D> own_bcast =3D  0, real recv =3D 62, local tq:   =
0, asym_penalty: 255, total tq:   0
[       969] Forwarding packet: tq_orig: 0, tq_avg: 0, tq_forw: 0, =
ttl_orig: 1, ttl_forw: 1
[       969] Forwarding packet: rebroadcast neighbor packet with direct =
link flag
[       969] Received BATMAN packet via NB: b0:c6:9b:80:01:5d, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5d, via prev OG: =
b0:c6:9b:80:01:5d, seqno 1246, ttvn 2, crc 38681, changes 0, td 255, TTL =
2, V 14, IDF 0)
[       969] bidirectional: orig =3D b0:c6:9b:80:01:5d neigh =3D =
b0:c6:9b:80:01:5d =3D> own_bcast =3D  0, real recv =3D 64, local tq:   =
0, asym_penalty: 255, total tq:   0
[       969] Forwarding packet: tq_orig: 0, tq_avg: 0, tq_forw: 0, =
ttl_orig: 1, ttl_forw: 1
[       969] Forwarding packet: rebroadcast neighbor packet with direct =
link flag
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:6b, IF: wlan1 =
[b0:c6:9b:80:01:56] (from OG: b0:c6:9b:80:01:5b, via prev OG: =
b0:c6:9b:80:01:5b, seqno 1251, ttvn 2, crc 51283, changes 0, td 245, TTL =
49, V 14, IDF 1)
[       970] Drop packet: originator packet from myself (via neighbor)
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:6b, IF: wlan1 =
[b0:c6:9b:80:01:56] (from OG: b0:c6:9b:80:01:5d, via prev OG: =
b0:c6:9b:80:01:5d, seqno 1246, ttvn 2, crc 38681, changes 0, td 0, TTL =
1, V 14, IDF 1)
[       970] Drop packet: originator packet with tq equal 0
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:6b, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5b, via prev OG: =
b0:c6:9b:80:01:5b, seqno 1251, ttvn 2, crc 51283, changes 0, td 245, TTL =
49, V 14, IDF 1)
[       970] Drop packet: originator packet from myself (via neighbor)
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:6b, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5d, via prev OG: =
b0:c6:9b:80:01:5d, seqno 1246, ttvn 2, crc 38681, changes 0, td 0, TTL =
1, V 14, IDF 1)
[       970] Drop packet: originator packet with tq equal 0
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:5f, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5b, via prev OG: =
b0:c6:9b:80:01:5b, seqno 1251, ttvn 2, crc 51283, changes 0, td 237, TTL =
49, V 14, IDF 1)
[       970] Drop packet: originator packet from myself (via neighbor)
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:5f, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5d, via prev OG: =
b0:c6:9b:80:01:5d, seqno 1246, ttvn 2, crc 38681, changes 0, td 0, TTL =
1, V 14, IDF 1)
[       970] Drop packet: originator packet with tq equal 0
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:5c, IF: wlan1 =
[b0:c6:9b:80:01:56] (from OG: b0:c6:9b:80:01:5b, via prev OG: =
b0:c6:9b:80:01:5b, seqno 1251, ttvn 2, crc 51283, changes 0, td 245, TTL =
49, V 14, IDF 1)
[       970] Drop packet: originator packet from myself (via neighbor)
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:5c, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5b, via prev OG: =
b0:c6:9b:80:01:5b, seqno 1251, ttvn 2, crc 51283, changes 0, td 245, TTL =
49, V 14, IDF 1)
[       970] Drop packet: originator packet from myself (via neighbor)
[       970] Forwarding packet (originator b0:c6:9b:80:01:5d, seqno =
1246, TTL 1) on interface wlan1 [b0:c6:9b:80:01:56]
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:5d, IF: wlan1 =
[b0:c6:9b:80:01:56] (from OG: b0:c6:9b:80:01:5b, via prev OG: =
b0:c6:9b:80:01:5b, seqno 1251, ttvn 2, crc 51283, changes 0, td 245, TTL =
49, V 14, IDF 0)
[       970] Drop packet: originator packet from myself (via neighbor)
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:5d, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5b, via prev OG: =
b0:c6:9b:80:01:5b, seqno 1251, ttvn 2, crc 51283, changes 0, td 245, TTL =
49, V 14, IDF 0)
[       970] Drop packet: originator packet from myself (via neighbor)
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:56, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5d, via prev OG: =
b0:c6:9b:80:01:5d, seqno 1246, ttvn 2, crc 38681, changes 0, td 0, TTL =
1, V 14, IDF 1)
[       970] Drop packet: received my own broadcast (sender: =
b0:c6:9b:80:01:56)
[       970] Forwarding packet (originator b0:c6:9b:80:01:5d, seqno =
1246, TTL 1) on interface wlan0 [b0:c6:9b:80:01:5b]
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:5b, IF: wlan1 =
[b0:c6:9b:80:01:56] (from OG: b0:c6:9b:80:01:5d, via prev OG: =
b0:c6:9b:80:01:5d, seqno 1246, ttvn 2, crc 38681, changes 0, td 0, TTL =
1, V 14, IDF 1)
[       970] Drop packet: received my own broadcast (sender: =
b0:c6:9b:80:01:5b)
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:5c, IF: wlan1 =
[b0:c6:9b:80:01:56] (from OG: b0:c6:9b:80:01:5c, via prev OG: =
b0:c6:9b:80:01:5c, seqno 1246, ttvn 2, crc 38681, changes 0, td 255, TTL =
50, V 14, IDF 0)
[       970] updating last_seqno: old 1245, new 1246
[       970] bidirectional: orig =3D b0:c6:9b:80:01:5c neigh =3D =
b0:c6:9b:80:01:5c =3D> own_bcast =3D  0, real recv =3D 63, local tq:   =
0, asym_penalty: 255, total tq:   0
[       970] Forwarding packet: tq_orig: 0, tq_avg: 251, tq_forw: 0, =
ttl_orig: 49, ttl_forw: 49
[       970] Forwarding packet: rebroadcast neighbor packet with direct =
link flag
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:5d, IF: wlan1 =
[b0:c6:9b:80:01:56] (from OG: b0:c6:9b:80:01:5c, via prev OG: =
b0:c6:9b:80:01:5c, seqno 1246, ttvn 2, crc 38681, changes 0, td 255, TTL =
50, V 14, IDF 0)
[       970] Drop packet: OGM via unknown neighbor!
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:5c, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5c, via prev OG: =
b0:c6:9b:80:01:5c, seqno 1246, ttvn 2, crc 38681, changes 0, td 255, TTL =
50, V 14, IDF 0)
[       970] bidirectional: orig =3D b0:c6:9b:80:01:5c neigh =3D =
b0:c6:9b:80:01:5c =3D> own_bcast =3D 63, real recv =3D 64, local tq: =
251, asym_penalty: 255, total tq: 251
[       970] update_originator(): Searching and updating originator =
entry of received packet
[       970] Updating existing last-hop neighbor of originator
[       970] Forwarding packet: tq_orig: 251, tq_avg: 251, tq_forw: 241, =
ttl_orig: 49, ttl_forw: 49
[       970] Forwarding packet: rebroadcast neighbor packet with direct =
link flag
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:5d, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5c, via prev OG: =
b0:c6:9b:80:01:5c, seqno 1246, ttvn 2, crc 38681, changes 0, td 255, TTL =
50, V 14, IDF 0)
[       970] Drop packet: OGM via unknown neighbor!
[       970] Originator timeout: originator b0:c6:9b:80:01:43, =
last_valid 0
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:6b, IF: wlan1 =
[b0:c6:9b:80:01:56] (from OG: b0:c6:9b:80:01:5c, via prev OG: =
b0:c6:9b:80:01:5c, seqno 1246, ttvn 2, crc 38681, changes 0, td 233, TTL =
49, V 14, IDF 1)
[       970] bidirectional: orig =3D b0:c6:9b:80:01:5c neigh =3D =
b0:c6:9b:80:01:6b =3D> own_bcast =3D 64, real recv =3D 64, local tq: =
255, asym_penalty: 255, total tq: 233
[       970] update_originator(): Searching and updating originator =
entry of received packet
[       970] Updating existing last-hop neighbor of originator
[       970] Drop packet: duplicate packet received
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:6b, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5c, via prev OG: =
b0:c6:9b:80:01:5c, seqno 1246, ttvn 2, crc 38681, changes 0, td 233, TTL =
49, V 14, IDF 1)
[       970] bidirectional: orig =3D b0:c6:9b:80:01:5c neigh =3D =
b0:c6:9b:80:01:6b =3D> own_bcast =3D 63, real recv =3D 64, local tq: =
251, asym_penalty: 255, total tq: 229
[       970] update_originator(): Searching and updating originator =
entry of received packet
[       970] Updating existing last-hop neighbor of originator
[       970] Drop packet: duplicate packet received
[       970] Forwarding packet (originator b0:c6:9b:80:01:5c, seqno =
1246, TQ 0, TTL 49, IDF off, ttvn 2) on interface wlan0 =
[b0:c6:9b:80:01:5b]
[       970] Forwarding packet (originator b0:c6:9b:80:01:5c, seqno =
1246, TQ 0, TTL 49, IDF on, ttvn 2) on interface wlan1 =
[b0:c6:9b:80:01:56]
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:5b, IF: wlan1 =
[b0:c6:9b:80:01:56] (from OG: b0:c6:9b:80:01:5c, via prev OG: =
b0:c6:9b:80:01:5c, seqno 1246, ttvn 2, crc 38681, changes 0, td 0, TTL =
49, V 14, IDF 0)
[       970] Drop packet: received my own broadcast (sender: =
b0:c6:9b:80:01:5b)
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:56, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5c, via prev OG: =
b0:c6:9b:80:01:5c, seqno 1246, ttvn 2, crc 38681, changes 0, td 0, TTL =
49, V 14, IDF 1)
[       970] Drop packet: received my own broadcast (sender: =
b0:c6:9b:80:01:56)
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:5f, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5c, via prev OG: =
b0:c6:9b:80:01:5c, seqno 1246, ttvn 2, crc 38681, changes 0, td 228, TTL =
49, V 14, IDF 1)
[       970] bidirectional: orig =3D b0:c6:9b:80:01:5c neigh =3D =
b0:c6:9b:80:01:5f =3D> own_bcast =3D 64, real recv =3D 64, local tq: =
255, asym_penalty: 255, total tq: 228
[       970] update_originator(): Searching and updating originator =
entry of received packet
[       970] Updating existing last-hop neighbor of originator
[       970] Drop packet: duplicate packet received
[       970] Forwarding packet (originator b0:c6:9b:80:01:5c, seqno =
1246, TQ 241, TTL 49, IDF on, ttvn 2) on interface wlan0 =
[b0:c6:9b:80:01:5b]
[       970] Forwarding packet (originator b0:c6:9b:80:01:5c, seqno =
1246, TQ 241, TTL 49, IDF off, ttvn 2) on interface wlan1 =
[b0:c6:9b:80:01:56]
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:5b, IF: wlan1 =
[b0:c6:9b:80:01:56] (from OG: b0:c6:9b:80:01:5c, via prev OG: =
b0:c6:9b:80:01:5c, seqno 1246, ttvn 2, crc 38681, changes 0, td 241, TTL =
49, V 14, IDF 1)
[       970] Drop packet: received my own broadcast (sender: =
b0:c6:9b:80:01:5b)
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:56, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:5c, via prev OG: =
b0:c6:9b:80:01:5c, seqno 1246, ttvn 2, crc 38681, changes 0, td 241, TTL =
49, V 14, IDF 0)
[       970] Drop packet: received my own broadcast (sender: =
b0:c6:9b:80:01:56)
[       970] Received BATMAN packet via NB: b0:c6:9b:80:01:6c, IF: wlan0 =
[b0:c6:9b:80:01:5b] (from OG: b0:c6:9b:80:01:43, via prev OG: =
b0:c6:9b:80:01:43, seqno 109829, ttvn 6, crc 5961, changes 0, td 245, =
TTL 49, V 14, IDF 1)
[       970] Creating new originator: b0:c6:9b:80:01:43
[       970] old packet received, start protection
[       970] Drop packet: OGM via unknown neighbor!




