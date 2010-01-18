Return-Path: <ylonen@gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 18 Jan 2010 14:29:35 +0100
From: =?iso-8859-1?Q?=22Juha_Yl=F6nen=22?= <ylonen@gmx.net>
In-Reply-To: <20100118113954.GC7844@lunn.ch>
Message-ID: <20100118132935.91200@gmx.net>
MIME-Version: 1.0
References: <20100118112706.91160@gmx.net> <20100118113954.GC7844@lunn.ch>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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

Hi,=20

And thanks for quick responses. Some comments below.

-------- Original-Nachricht --------
> Datum: Mon, 18 Jan 2010 12:39:54 +0100
> Von: Andrew Lunn <andrew@lunn.ch>
>
> What do you see in /proc/net/batman-adv/originiators on the three
> devices?

Here's what I see (or not see) in the laptop:
##:~$ cat /proc/net/batman-adv/interfaces
[  active] wlan0 00:22:fa:dc:9a:ce
##:~$ cat /proc/net/batman-adv/originators
  Originator     (#/255)           Nexthop [outgoingIF]:   Potential nextho=
ps ... [B.A.T.M.A.N. adv 0.2, MainIF/MAC: wlan0/00:22:fa:dc:9a:ce]
No batman nodes in range ...

and in the device:
##> cat /proc/net/batman-adv/interfaces
[  active] eth1 00:11:f6:83:af:1c
##> cat /proc/net/batman-adv/originators
  Originator     (#/255)           Nexthop [outgoingIF]:   Potential nextho=
ps ... [B.A.T.M.A.N. adv 0.2, MainIF/MAC: eth1/00:11:f6:83:af:1c]
No batman nodes in range ...

> Is the ARM device running in big endian or little endian mode?=20

The device is liitle endian. Could it be a problem in endianness? IIRC netw=
ork stuff is usually big endian?
=20
> Any kernel messages?=20
>=20
> You may want to rebuild the modules with debugging enabled, see the
> README and then enable it as described in the README.

I couldn't find any info on debug build in the README, and some instruction=
s I came across in the wiki didn't really work, so I went and modified log.=
c directly to printk everything that is passed to debug_log.

In result I got a screenfulls of messages:
---
batman-adv: Received BATMAN packet via NB: 00:22:fa:dc:9a:ce, IF: eth1 [00:=
11:f6:83:af:1c] (from OG: 00:22:fa:dc:9a:ce, via prev OG: 00:22:fa:dc:9a:ce=
, seqno 30765, tq 255, TTL 50, V 8, IDF 0)
batman-adv: updating last_seqno: old 30764, new 30765
batman-adv: bidirectional: orig =3D 00:22:fa:dc:9a:ce neigh =3D 00:22:fa:dc=
:9a:ce =3D> own_bcast =3D  0, real recv =3D 63, local tq:   0, asym_penalty=
: 255, total tq:   0
batman-adv: Forwarding packet: tq_orig: 0, tq_avg: 0, tq_forw: 0, ttl_orig:=
 49, ttl_forw: 49
batman-adv: Forwarding packet: rebroadcast neighbour packet with direct lin=
k flag
batman-adv: Forwarding packet (originator 00:22:fa:dc:9a:ce, seqno 30765, T=
Q 0, TTL 49, IDF on) on interface eth1 [00:11:f6:83:af:1c]
batman-adv: Sending own packet (originator 00:11:f6:83:af:1c, seqno 1569, T=
Q 255, TTL 50, IDF off) on interface eth1 [00:11:f6:83:af:1c]
batman-adv: Received BATMAN packet via NB: 00:22:fa:dc:9a:ce, IF: eth1 [00:=
11:f6:83:af:1c] (from OG: 00:22:fa:dc:9a:ce, via prev OG: 00:22:fa:dc:9a:ce=
, seqno 30766, tq 255, TTL 50, V 8, IDF 0)
batman-adv: updating last_seqno: old 30765, new 30766
batman-adv: bidirectional: orig =3D 00:22:fa:dc:9a:ce neigh =3D 00:22:fa:dc=
:9a:ce =3D> own_bcast =3D  0, real recv =3D 63, local tq:   0, asym_penalty=
: 255, total tq:   0
batman-adv: Forwarding packet: tq_orig: 0, tq_avg: 0, tq_forw: 0, ttl_orig:=
 49, ttl_forw: 49
batman-adv: Forwarding packet: rebroadcast neighbour packet with direct lin=
k flag
batman-adv: Forwarding packet (originator 00:22:fa:dc:9a:ce, seqno 30766, T=
Q 0, TTL 49, IDF on) on interface eth1 [00:11:f6:83:af:1c]
batman-adv: Sending own packet (originator 00:11:f6:83:af:1c, seqno 1570, T=
Q 255, TTL 50, IDF off) on interface eth1 [00:11:f6:83:af:1c]
batman-adv: Received BATMAN packet via NB: 00:22:fa:dc:9a:ce, IF: eth1 [00:=
11:f6:83:af:1c] (from OG: 00:22:fa:dc:9a:ce, via prev OG: 00:22:fa:dc:9a:ce=
, seqno 30767, tq 255, TTL 50, V 8, IDF 0)
batman-adv: updating last_seqno: old 30766, new 30767
batman-adv: bidirectional: orig =3D 00:22:fa:dc:9a:ce neigh =3D 00:22:fa:dc=
:9a:ce =3D> own_bcast =3D  0, real recv =3D 63, local tq:   0, asym_penalty=
: 255, total tq:   0
batman-adv: Forwarding packet: tq_orig: 0, tq_avg: 0, tq_forw: 0, ttl_orig:=
 49, ttl_forw: 49
batman-adv: Forwarding packet: rebroadcast neighbour packet with direct lin=
k flag
batman-adv: Forwarding packet (originator 00:22:fa:dc:9a:ce, seqno 30767, T=
Q 0, TTL 49, IDF on) on interface eth1 [00:11:f6:83:af:1c]
batman-adv: Sending own packet (originator 00:11:f6:83:af:1c, seqno 1571, T=
Q 255, TTL 50, IDF off) on interface eth1 [00:11:f6:83:af:1c]
batman-adv: Received BATMAN packet via NB: 00:22:fa:dc:9a:ce, IF: eth1 [00:=
11:f6:83:af:1c] (from OG: 00:22:fa:dc:9a:ce, via prev OG: 00:22:fa:dc:9a:ce=
, seqno 30768, tq 255, TTL 50, V 8, IDF 0)
batman-adv: updating last_seqno: old 30767, new 30768
batman-adv: bidirectional: orig =3D 00:22:fa:dc:9a:ce neigh =3D 00:22:fa:dc=
:9a:ce =3D> own_bcast =3D  0, real recv =3D 63, local tq:   0, asym_penalty=
: 255, total tq:   0
batman-adv: Forwarding packet: tq_orig: 0, tq_avg: 0, tq_forw: 0, ttl_orig:=
 49, ttl_forw: 49
batman-adv: Forwarding packet: rebroadcast neighbour packet with direct lin=
k flag
batman-adv: Forwarding packet (originator 00:22:fa:dc:9a:ce, seqno 30768, T=
Q 0, TTL 49, IDF on) on interface eth1 [00:11:f6:83:af:1c]
batman-adv: Sending own packet (originator 00:11:f6:83:af:1c, seqno 1572, T=
Q 255, TTL 50, IDF off) on interface eth1 [00:11:f6:83:af:1c]
batman-adv: Received BATMAN packet via NB: 00:22:fa:dc:9a:ce, IF: eth1 [00:=
11:f6:83:af:1c] (from OG: 00:22:fa:dc:9a:ce, via prev OG: 00:22:fa:dc:9a:ce=
, seqno 30769, tq 255, TTL 50, V 8, IDF 0)
batman-adv: updating last_seqno: old 30768, new 30769
batman-adv: bidirectional: orig =3D 00:22:fa:dc:9a:ce neigh =3D 00:22:fa:dc=
:9a:ce =3D> own_bcast =3D  0, real recv =3D 63, local tq:   0, asym_penalty=
: 255, total tq:   0
batman-adv: Forwarding packet: tq_orig: 0, tq_avg: 0, tq_forw: 0, ttl_orig:=
 49, ttl_forw: 49
batman-adv: Forwarding packet: rebroadcast neighbour packet with direct lin=
k flag
batman-adv: Forwarding packet (originator 00:22:fa:dc:9a:ce, seqno 30769, T=
Q 0, TTL 49, IDF on) on interface eth1 [00:11:f6:83:af:1c]
batman-adv: Sending own packet (originator 00:11:f6:83:af:1c, seqno 1573, T=
Q 255, TTL 50, IDF off) on interface eth1 [00:11:f6:83:af:1c]
batman-adv: Received BATMAN packet via NB: 00:22:fa:dc:9a:ce, IF: eth1 [00:=
11:f6:83:af:1c] (from OG: 00:22:fa:dc:9a:ce, via prev OG: 00:22:fa:dc:9a:ce=
, seqno 30770, tq 255, TTL 50, V 8, IDF 0)
batman-adv: updating last_seqno: old 30769, new 30770
batman-adv: bidirectional: orig =3D 00:22:fa:dc:9a:ce neigh =3D 00:22:fa:dc=
:9a:ce =3D> own_bcast =3D  0, real recv =3D 63, local tq:   0, asym_penalty=
: 255, total tq:   0
---

Interestingly there seems to be packets coming and going from my laptop?

-Juha

--=20
GRATIS f=FCr alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
