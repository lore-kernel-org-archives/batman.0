Return-Path: <alessandro@mediaspot.net>
From: Alessandro Bolletta <alessandro@mediaspot.net>
Date: Sat, 14 Nov 2015 16:50:23 +0000
Message-ID: <F52F175DFC537F48A43937B50B44BCA2820C5F2A@EXCHANGE.mediaspot.local>
References: <F52F175DFC537F48A43937B50B44BCA2820C1278@EXCHANGE.mediaspot.local>
 <1899407.TVXecW4so9@prime>
 <F52F175DFC537F48A43937B50B44BCA2820C1D1B@EXCHANGE.mediaspot.local>
 <1712822.pO4f8xYhfX@prime>
In-Reply-To: <1712822.pO4f8xYhfX@prime>
Content-Language: it-IT
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] R: RE:  bridge detaching crash
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Hi Simon,
sorry for my delay but I couldn't reply before then now.

Here is the brctl show:

bridge name     bridge id               STP enabled     interfaces
br-mgmt         7fff.0cc47a2006d0       no                  eth0.6
                                                        			bat0.2

batctl if:

eth0.50: active
eth0.40: active
eth0.20: active
eth0.90: active
eth0.80: active
eth0.70: active
eth0.60: active
eth1.30: active
eth1.10: active

Every time I try to restart networking stack on OpenWRT or everytime I simp=
ly disconnect ethernet cable on eth0 network card I get this dump on dmesg =
and I can't estabilish new ethernet connection if I don't reboot the whole =
system.

Now I'm trying to reproduce this behaviour in another node, we'll keep in t=
ouch about it.

Any idea?

Thank you guys,
Alessandro

-----Messaggio originale-----
Da: Simon Wunderlich [mailto:sw@simonwunderlich.de]=20
Inviato: marted=EC 10 novembre 2015 17.47
A: Alessandro Bolletta <alessandro@mediaspot.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Oggetto: Re: RE: [B.A.T.M.A.N.] bridge detaching crash

Hi Alessandro,

one question unanswered is which interfaces are used for batman-adv in your=
 setup. In your kernel log we see eth0.90 and eth0.20.

Also was puzzling me is the message "tried to remove device eth0 from bat0.=
2".=20
This is coming from __netdev_adjacent_dev_remove(), but I don't see how eth=
0 would be adjacent to bat0.2 ...

Can you please post batctl if and brctl show while your setup is running?

How repeatable is this problem? Is one node sufficient to reproduce?

Thanks,
    Simon

On Monday 09 November 2015 22:21:51 Alessandro Bolletta wrote:
> Hi Simon,
>=20
> - batman-adv 2015.1.0 with patches from OpenWRT feeds
> - the unique bridge present on this machine is between eth0.6 and=20
> bat0.2
> - /etc/init.d/network restart
> - OS: OpenWRT 15.05 stable downloaded from git repo with lastest=20
> patches ________________________________________
> Da: Simon Wunderlich [sw@simonwunderlich.de]
> Inviato: luned=EC 9 novembre 2015 16.31
> A: b.a.t.m.a.n@lists.open-mesh.org
> Cc: Alessandro Bolletta
> Oggetto: Re: [B.A.T.M.A.N.] bridge detaching crash
>=20
> Hi,
>=20
> On Sunday 08 November 2015 23:45:14 Alessandro Bolletta wrote:
> > Hi,
> > in my Openwrt x86 testbed, I created a bridge between a vlan over=20
> > eth0 and a vlan over bat0. It works as expected but, when I try to=20
> > restart network, bridge seems to be not correctly detached and=20
> > networking stack gets hanged.
> >=20
> >=20
> >=20
> > Can you help me to debug this crash?
>=20
> Could you please post:
>=20
>  * batman-adv version
>  * your network setup (batctl if, brctl show, etc)
>  * commands you use to restart network (OpenWRT or something else?)
>=20
> Thanks,
>     Simon

