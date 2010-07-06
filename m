Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Tue, 6 Jul 2010 23:46:36 +0200
References: <201007061948.05784.clemens-john@gmx.de>
	<201007062215.45412.lindner_marek@yahoo.de>
In-Reply-To: <201007062215.45412.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3448265.fTkZoJ2NUI";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201007062346.43276.clemens-john@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman advanced and internet gateways
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

--nextPart3448265.fTkZoJ2NUI
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Dienstag 06 Juli 2010, 22:15:45 schrieb Marek Lindner:
> It requires each gateway to have a DHCP server running. The clients will
> select their gateway and relay the dhcp requests via unicast to the
> selected gateway only.
> You only need to activate the gateway / client mode and have a dhcp server
> running.

Okay I did this but I have some questions left:

Does the DHCP server on the gateway need to distribute IP-Adresses?
If so I think they have to be distributet on the batman interface right?

Does the Batman advanced interface on the clients need to request an IP-Adr=
ess=20
from the DHCP server or can I also set a static IP adress?

If the clients need to request an IP adress from the DHCP server, where is =
the=20
difference between requesting an IP without Batman advanced and with Batman=
=20
advanced? Does Batman advanced say from wich server to request the IP or wh=
ich=20
default route to choose?

>=20
> > **If so why do you mix Layer 2 and Layer 3 now?
>=20
> If you don't want to mix layer2 / layer3 then just don't use this feature.
> It is disabled per default.
> If you have a better idea how to handle multiple gateways in a layer2 mesh
> we are very open to your suggestions. :)

Sry for this question we just discussed this on the last community meeting =
and=20
somebody wondered if this is the most beautiful way. Maybe it=B4s not but y=
ou=20
are right there is no other way.

> Unfortunately, we did not get around finishing it to the point that we fe=
el
> comfortable with releasing this feature. I think the trunk is quite stable
> but still lacks some things. E.g. blacklisting / whitelisting gateways,
> IPv6, etc.

Okay but it will 	likely be usable without crashing right?

Last but not least:
How can I configure batman advanced in /etc/config/batman-adv to enable gw=
=20
server/client mode?

Greetings
Clemens

--nextPart3448265.fTkZoJ2NUI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwzpDwACgkQZgdHbA22lqPRBACghWDzvlHrJ3lGo9NpEa3/kHhU
YlgAoLL2vg+xbeDoGQfiziyNOXTvNOm0
=0lts
-----END PGP SIGNATURE-----

--nextPart3448265.fTkZoJ2NUI--
