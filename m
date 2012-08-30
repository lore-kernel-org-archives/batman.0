Return-Path: <ordex@autistici.org>
Date: Thu, 30 Aug 2012 18:33:52 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120830163352.GK29563@ritirata.org>
References: <1346343747-4010-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="W2ydbIOJmkm74tJ2"
Content-Disposition: inline
In-Reply-To: <1346343747-4010-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: don't rely on positions in
 struct for hashing
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


--W2ydbIOJmkm74tJ2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2012 at 06:22:27PM +0200, Simon Wunderlich wrote:
> The hash functions in the bridge loop avoidance code expects the
> VLAN vid to be right after the mac address, but this is not guaranteed.
>=20
> Fix this by explicitly hashing over the right fields of the struct.
>=20

What about creating a new structure like

struct {
	uint8_t mac[ETH_ALEN];
	short vid;
}

to be used as first field in the batadv_claim object? Then you can easily h=
ash
the first 10 bytes in one shot.
This would also help to avoid code duplication in the future (TT will suppo=
rt
VLAN tagging sooner or later and will need the same trick).

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--W2ydbIOJmkm74tJ2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlA/lfAACgkQpGgxIkP9cwcYkQCfe6AsCd17wRWnfXaQVBwYeZdr
7doAoI5839So5FOHHRlfT79gbuncu1uc
=q/gO
-----END PGP SIGNATURE-----

--W2ydbIOJmkm74tJ2--
