Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 15 Aug 2010 10:23:39 +0200
References: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
	<1281820085-13507-9-git-send-email-sven.eckelmann@gmx.de>
	<201008142332.28067.lindner_marek@yahoo.de>
In-Reply-To: <201008142332.28067.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1568035.u0q89OpiLF";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008151023.41755.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 9/9] batman-adv: Don't increase mtu of
	interface automatically
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1568035.u0q89OpiLF
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> On Saturday 14 August 2010 23:08:05 Sven Eckelmann wrote:
> > The user usually sets a mtu by hand and don't want to have software to
> > change it automatically. This is only needed when we must reduce the mtu
> > due to a low mtu of an active slave device, but we should not increase
> > it when any other action is made on the system related to the used
> > interfaces.
>=20
> I fear that this might lead to a strange user experience. If the mtu on
> batX wasn't set explicitely but the mtu of an interface used by batman is
> increased while batman uses it the user has to know that he/she now needs
> to manually modify the batX mtu before it becomes effective.
>=20
> What about a flag which remembers whether the mtu on batX was modified by
> the user. If so, batman-adv does not increase the mtu otherwise we keep
> the current behaviour ?

Ok, then drop that patch. The user seems to be familiar with that behavior=
=20
because bridge handles it the same way.

Best regards,
	Sven

--nextPart1568035.u0q89OpiLF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMZ6QMAAoJEF2HCgfBJntGOq0QAK/6JSup6hrWVlPLnFe2FGzb
KBxhG8OtjJ3BnUdsDRvMI7J7xwbubIygVEe2l4Tw4/lGFyYfkcXDmZ7uEsUOKC34
LuG9Bsm1iWgeysmzMJQyazBJkxsHDeACiGK+pHWfwDZsbCONHlh19kLcHOswazx/
MAdobUByt3DrHLg1eLI6w856h6/cW/xvRZAHEv6WbOF0cWDtg/+jbBRIg/LDhTLr
Ahd3uTqiDfCIjMYTgbfXClXYZHt0aeccaXPcHB7nw4Ode2tjj4nd4AEtPiA3CpJS
H27oHdk4tBPSkYClB+PQs6lPZ/AMW8jEfwhDkI6bruKDlZUhm/Ml6d8obwo9kMxU
SuDqsAxdlX1pO/3nI+j+Ul+hxGCODCinyL7DJXJKvgYKZv11gyTouQyx9M4U+jg6
/Pi5uoFsJhm24h8Xrr8Vkjgxdv+3wRFQREOVJubhEExn2B2LGvvTKiBA32h1Xgwv
Oxzm2mT3ZHzu7Rr4wkklFo8dSFTgQl/dyutkkRuuQ5LTvXZEiTslYX+sBwxT0jMK
hFcYqv3Pg/SCjxMsNpOPsDksNafL0nCRVq3Um6q3vyRfBL8sMreFVaZSRSEZo5wp
deuWD2W+zupe/yOKzX+PS87Hk4Rp/fUhn8bjoVfXMGMC3yJh1uylgYlGwBxeIfOX
5Xkr+lKMIz705+2pn/f9
=g3uY
-----END PGP SIGNATURE-----

--nextPart1568035.u0q89OpiLF--
