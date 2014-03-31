Return-Path: <baantunes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
From: Bruno Antunes <baantunes@gmail.com>
In-Reply-To: <20140312182046.GT1629@pengutronix.de>
Date: Mon, 31 Mar 2014 12:06:24 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <233537AD-6FBF-4ACB-A224-8B5B889E4627@gmail.com>
References: <20140310212525.GU24339@pengutronix.de>
 <201403121136.16430.sw@simonwunderlich.de>
 <20140312125329.GJ1629@pengutronix.de>
 <201403121451.09760.sw@simonwunderlich.de>
 <20140312142507.GO1629@pengutronix.de> <20140312145448.GC15090@lunn.ch>
 <20140312182046.GT1629@pengutronix.de>
Subject: Re: [B.A.T.M.A.N.] Line of Nodes
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

On 12 Mar, 2014, at 18:20 , Robert Schwebel <r.schwebel@pengutronix.de> =
wrote:

> On Wed, Mar 12, 2014 at 03:54:48PM +0100, Andrew Lunn wrote:
>>>> I'd definitely recommend to buy WiFi modules (e.g. pci-e) or =
off-the-shelf=20
>>>> boards with WiFi SoCs on it. If you don't have experience in =
building WiFi=20
>>>> routers, you might have a lot of fun otherwise. :)
>>>=20
>>> The issue is that the stations need to be very low power, so I'd =
like to
>>> leave everything out which draws power but isn't absolutely needed. =
The
>>> HF part should be solvable, that's something the hardware developers
>>> have experience with. I'm aiming for a low power ARM cpu, which
>>> basically rules out anything that needs PCIe and leaves us with SDIO =
or
>>> USB for the connection of the transmitters.
>>=20
>> I'm hoping i can get my hands on one of these soon:
>>=20
>> =
http://www.logicpd.com/products/system-on-modules/dm3730-torpedo-wireless-=
som/
>>=20
>> There is a kernel patch around for one of the Yocto kernels, which i
>> expect you guys would have no trouble cleaning up.
>=20
> Nice little system. I already have the TI WiLink chips on my list of
> possible devices (we have an older one on an SDIO card for testing).
>=20
> Thanks for the pointer!

For an complete solution you can have this nice device:

http://8devices.com/carambola-2

Appart from GPS it has all the features

Bruno

>=20
> rsc=20
> --=20
> Pengutronix e.K.                           |                           =
  |
> Industrial Linux Solutions                 | =
http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   =
+49-5121-206917-5555 |

