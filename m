Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 6 Dec 2011 10:46:00 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111206094600.GA9559@pandem0nium>
References: <DM__111206165734_29183085106@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <DM__111206165734_29183085106@smtp.gmail.com>
Subject: Re: [B.A.T.M.A.N.] about batman performance
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


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello zb1981gm (btw, do you have a real name?),

On Tue, Dec 06, 2011 at 05:01:13PM +0800, zb1981gm wrote:
> I have used batman on my project for several months.It performs very well=
,stable especially!=20
> But,actually,I am not satisfied with the performance of Batman.I found th=
at the bandwidth would drop sharply with the wireless hop increase.=20
> Now I provide my test result here:=20
>=20
> routerA and routerB is composed of compex wp543ahv mainboard (AR7161 plat=
form) and two AR9220 wireless card.Firmware is Openwrt backfire.=20
> one card is working on 2.4G channel as AP mode,the other is working on 5G=
 channel as mesh backbone =20
> batman version:2.0=20

What is batman version 2.0? We have batmand (layer 3), but I guess you are =
using batman advanced
as you talk about bonding/interface alternating later. These have 0.X (for =
old releases) or 201X.Y.Z
version schemes (since 2 years). Please clarify.

> notebook1 and notebook2 is equiped with 802.11n usb wireless card which a=
ccess to the AP mode card of routerA and routerB=20
>=20
>             channel 1                 channel 36              channel 11=
=20
> notebook1 ---------------  routerA --------------  routerB --------------=
 notebook2=20
>=20
> I use iperf to test bandwidth=20
>=20
> notebook1 ----------- routerA    45Mbps=20
> routerA   ----------- routerB    46Mbps=20
> routerB   ----------- notebook2  45Mbps=20
>=20
> But the bandwidth between notebook1 and notebook2 remains 8Mbps=20
> bandwidth between notebook1 and routerB remain 18Mbps=20

Have you compared this to static routing?

>=20
> So the conclution is that the bandwidth will be halfed with the 1 hop inc=
rease! right?=20

It should not, as different radio modules are used (and correctly tuned on =
different channels).
However, you may have a limitation in your CPU power or something else.=20
You may want to try static routing to find this out.

>=20
> I also found that the interface alternating mode and bonding mode doesn't=
 take effect=20
>=20
>               channel 1=20
> routerA  ------------------  routerB=20
>               channel 36=20
>=20
> The test result is no difference whatever I configured alternating or bon=
ding or just single radio=20

To make bonding work, there are a few conditions:
 * routers must be equipped with multiple radios which can connect to each =
other
 * activate bonding (batctl bonding 1)
 * make sure the transmit qualities are similar (check with batctl o), shou=
ld not be more than a difference of 50

If everything is fine, you can get a boost of approx. 50%.


>=20
> According to the batman official site, alternating or bonding mode would =
improve the performance compared with the single radio mode=20
>=20

Yup, it should help. Alternating is not helping in your scenario as far as =
I understand (your
mesh is only 1 hop long, as notebooks are connected via infrastructure mode=
). Bonding may
help as described above.

best regards,
	Simon



--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7d5FgACgkQrzg/fFk7axbJFwCeIz8H/LwfUzm3WBpupj4l/f6Y
XvwAn0D8bgQxpiT1tzY9/zokgFZRq3Rz
=jW9z
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
