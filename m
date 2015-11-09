Return-Path: <alessandro@mediaspot.net>
From: Alessandro Bolletta <alessandro@mediaspot.net>
Date: Mon, 9 Nov 2015 22:21:51 +0000
Message-ID: <F52F175DFC537F48A43937B50B44BCA2820C1D1B@EXCHANGE.mediaspot.local>
References: <F52F175DFC537F48A43937B50B44BCA2820C1278@EXCHANGE.mediaspot.local>,
 <1899407.TVXecW4so9@prime>
In-Reply-To: <1899407.TVXecW4so9@prime>
Content-Language: it-IT
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] bridge detaching crash
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Hi Simon,=0A=
=0A=
- batman-adv 2015.1.0 with patches from OpenWRT feeds=0A=
- the unique bridge present on this machine is between eth0.6 and bat0.2=0A=
- /etc/init.d/network restart=0A=
- OS: OpenWRT 15.05 stable downloaded from git repo with lastest patches=0A=
________________________________________=0A=
Da: Simon Wunderlich [sw@simonwunderlich.de]=0A=
Inviato: luned=EC 9 novembre 2015 16.31=0A=
A: b.a.t.m.a.n@lists.open-mesh.org=0A=
Cc: Alessandro Bolletta=0A=
Oggetto: Re: [B.A.T.M.A.N.] bridge detaching crash=0A=
=0A=
Hi,=0A=
=0A=
On Sunday 08 November 2015 23:45:14 Alessandro Bolletta wrote:=0A=
> Hi,=0A=
> in my Openwrt x86 testbed, I created a bridge between a vlan over eth0 an=
d a=0A=
> vlan over bat0. It works as expected but, when I try to restart network,=
=0A=
> bridge seems to be not correctly detached and networking stack gets hange=
d.=0A=
>=0A=
>=0A=
>=0A=
> Can you help me to debug this crash?=0A=
=0A=
Could you please post:=0A=
=0A=
 * batman-adv version=0A=
 * your network setup (batctl if, brctl show, etc)=0A=
 * commands you use to restart network (OpenWRT or something else?)=0A=
=0A=
Thanks,=0A=
    Simon=0A=

