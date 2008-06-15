Date: Mon, 16 Jun 2008 01:18:07 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Securing batman networks
Message-ID: <20080615231807.GC9736@hrz.tu-chemnitz.de>
References: <1213487132.5782.14.camel@damian-x31.damian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
In-Reply-To: <1213487132.5782.14.camel@damian-x31.damian.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Damian,

maybe WPA-NONE can help you. It is basicly WPA with pre-shared keys
which works on Ad-Hoc, but misses a lot of security features like replay
attack detection (would not make sense in adhoc networks) or having
different session keys, as usually access points manage these. So i
don't know how "secure" this actually is.

Furthermore, WPA-NONE is not included in any standard afaik. But at
least wpa_supplicant and Windows support it. However it is not
guaranteed that it works with any driver ... at least madwifi did not
work with it out of the box (but after some patches ;) when i tried it.

best regards,
	Simon

On Sun, Jun 15, 2008 at 09:45:32AM +1000, Damian Ivereigh wrote:
> Does anyone have any experience with securing batman networks (or more
> to the point the adhoc networks it is based on)? My setup will be a
> relatively planned infrastructure with all units controlled by myself,
> so embedding keys etc won't really be an issue.
>=20
> Can you use WPA2 with adhoc networks? How does this work with
> wpa_supplicant & hostapd (which are obviously designed for use with
> access point infrastructure).
>=20
> When I use the term "security" I am looking at it at several levels:-
>=20
> 1) Stopping rogue units joining the network.
> 2) Encrypting the traffic to stop eavesdropping.
> 3) Stopping others from hijacking the connections (either between nodes
> or via the gateways).=20
>=20
> I realise this is a different style from the community mesh network,
> open to everyone, that Batman appears to have been part of up to now. In
> Australia bandwidth is so limited (and expensive) that people here are
> generally not willing to share it, so there is almost no chance of a
> community arising of its own accord.
>=20
> Damian
>=20
> --=20
> Launtel - Plugging Tassie into the world
> Tel: 1800LAUNTEL (1800528683)
> Mob: 0418217582
> Fax: 1300784109
> http://www.launtel.net.au
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIVaMvrzg/fFk7axYRAkvdAJ4vikd/aBVN/Rd0xpnP/jHZtM5QKACfT+z7
0CyLtePLAza/y/7XCgdYfGQ=
=RwIx
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
