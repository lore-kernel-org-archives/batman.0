Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 22 Jan 2010 19:26:19 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100122182619.GA6956@pandem0nium>
References: <20100119145806.275330@gmx.net> <20100121141227.319490@gmx.net>
	<4B588C35.2020409@gmail.com>
	<201001211932.13914.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <201001211932.13914.sven.eckelmann@gmx.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

maybe just an idea, but could it be that we have a regression from the skb
patch that some skb headers are wrong?=20

An idea would be to compare the behaviour with the batman-adv 0.2 release
or an revision < 1517, which still uses raw sockets instead of working=20
directly on the skb.

regards,
	Simon

On Thu, Jan 21, 2010 at 07:32:10PM +0100, Sven Eckelmann wrote:
> Gus Wirth wrote:
> > Your routes are all messed up. You have class C addresses subsumed
> > inside class A address space, which causes undefined behavior.
> >=20
> > Give your routes different address spaces, something like one in the
> > 192.168.xx.xx, another 172.16.xx.xx, and the 10.xx.xx.xx so the routes
> > can be sorted out properly.
> >=20
> > Also, why does the laptop wlan0 have an IP address? If it is part of the
> > mesh through bat0 it should not have an IP address, only add it as an
> > interface to bat0.
>=20
> Yes, but doesn't explain why there is no batman-adv packet from ARM reach=
ing=20
> the laptop and the other way around. batman-adv is a layer bellow and has=
=20
> nearly nothing to do with the stuff which runs over it (the only thing wh=
ich=20
> accesses the layer over it should be the gateway stuff).
>=20
> @Juha, I found time and looked a little bit at the stuff which came from =
the=20
> ARM in the last log. Wireshark means that it is a Raw ethernet packet. An=
d=20
> thinks that the stuff attached is a IPX packet.... but reading the raw da=
ta=20
> reveals that it should be the batman-packet.... with extra data between t=
he=20
> ethernet header and the actual batman-adv packet. So the problem looks to=
 me a=20
> little bit like hardware of the arm does something very stupid to our pac=
kets.
>=20
> I've attach a small picture to explain what I mean. The green part it the=
=20
> normal receiver and sender stuff for ethernet. The orange part is not=20
> explainable for me... Have we forgot some alignment stuff? Is your card a=
dding=20
> some extra data? I am not sure what that could mean right now.
> The red thing is the ethernet type for batman-adv, pink the type of batma=
n-adv=20
> packet, yellow the protocol version and light blue the flags for that pac=
ket.=20
> I don't know more color - so just marked the rest of the packet blue. The=
=20
> amount of bytes are correct and it looks fine to me.
>=20
> As anyone a good idea? Maybe a small capture of a normal ping test and a=
=20
> rawsend test between the both could help to understand the problem better=
=2E And=20
> can you maybe tell us what kind of hardware is used inside the arm for th=
e=20
> eth1 device?
>=20
> Best regards,
> 	Sven





--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktZ7csACgkQrzg/fFk7axYscgCdF1GMYj44V17JF/7Ky7qT5v7h
RN0AoLmdt/xGxjSDiYb0zAehXqFEUKUa
=t263
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
