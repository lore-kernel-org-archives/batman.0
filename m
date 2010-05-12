Return-Path: <linus.luessing@web.de>
Date: Wed, 12 May 2010 23:02:50 +0200 (CEST)
From: =?ISO-8859-15?Q?Linus_L=FCssing?= <linus.luessing@web.de>
Message-ID: <21142356.1006178.1273698170378.JavaMail.fmail@mwmweb072>
References: <20100508170755.GA27599@ritirata.org>
	<201005100147.59454.lindner_marek@yahoo.de>,
	<20100510115755.GA2510@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20100510115755.GA2510@ritirata.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Blocking OGMs from a node for testing purpose
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Antonio,

>Then I tried to block any kind of packets from a known mac (say MACa).
>
># ebtables -A INPUT -s MACa -j DROP
>
>After this I checked with "battctl o" if I was still able to see the other=
 host, and even waiting a few minutes, the host was still in the list.

I tried it on two routers with ebtables and iptables here, too. I fired awa=
y all (redundant and like the forwarding stuff usually even useless) comman=
ds that came to my mind that could possibly block ANY traffic at all:
---
ebtables -A INPUT -j DROP
ebtables -A OUTPUT -j DROP
ebtables -A FORWARD -j DROP
ebtables -t broute -A BROUTING -j DROP
ebtables -t nat -A PREROUTING -j DROP
iptables -I INPUT -m physdev --physdev-is-in -j DROP
iptables -I OUDPUT -m physdev --physdev-is-out -j DROP
iptables -I FORWARD -m physdev --physdev-is-brigded -j DROP
---
Of course, no ssh connection and stuff like that and basically no other com=
munication got through... despite batman-adv's OGMs and batping packets, lo=
oking at that over a serial console! So it looks like batman-adv is getting=
 hold of the OGMs before any filtering rules of the iptables/ebtables modul=
es can get hold of them.

Additionally, the iptables/ebtables packet counts didn't seem to recognise =
any packets.=20

So it looks like either this is intended and batman-adv is also a very stea=
lthy super-trojan (but couldn't find any proof for this in the source code =
yet ;) ) or batman-adv is just mistakenly catching them (and maybe even dro=
pping them although the skb-copy should prevent this?) before the kernel or=
 any other (filtering) kernel modules could have a glance at them.

I'm sorry having said that this should work on IRC before, but filtering (e=
ven bridged) arp/ip-packets over bat0 works like a charm - hadn't tried fil=
tering raw batman-adv ethernet frames yet.

Cheers, Linus
___________________________________________________________
GRATIS: Movie-Flat mit =C3=BCber 300 Top-Videos. F=C3=BCr WEB.DE Nutzer
dauerhaft kostenlos! Jetzt freischalten unter http://movieflat.web.de
