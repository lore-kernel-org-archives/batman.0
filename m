Return-Path: <ordex@autistici.org>
Date: Thu, 30 Aug 2012 18:46:27 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120830164627.GL29563@ritirata.org>
References: <1346343747-4010-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <20120830163352.GK29563@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="DXIF1lRUlMsbZ3S1"
Content-Disposition: inline
In-Reply-To: <20120830163352.GK29563@ritirata.org>
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


--DXIF1lRUlMsbZ3S1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2012 at 06:33:52PM +0200, Antonio Quartulli wrote:
> On Thu, Aug 30, 2012 at 06:22:27PM +0200, Simon Wunderlich wrote:
> > The hash functions in the bridge loop avoidance code expects the
> > VLAN vid to be right after the mac address, but this is not guaranteed.
> >=20
> > Fix this by explicitly hashing over the right fields of the struct.
> >=20
>=20
> What about creating a new structure like
>=20
> struct {
> 	uint8_t mac[ETH_ALEN];
> 	short vid;
> }
>=20
> to be used as first field in the batadv_claim object? Then you can easily=
 hash
> the first 10 bytes in one shot.
> This would also help to avoid code duplication in the future (TT will sup=
port
> VLAN tagging sooner or later and will need the same trick).

Sorry,
but my proposal is wrong. In the new structure we could still have some pad=
ding
between the two fields (and we can't know), therefore we cannot hash 10byte=
s in
one shot as I said.

Drop my idea :)

Cheers,




--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--DXIF1lRUlMsbZ3S1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlA/mOMACgkQpGgxIkP9cwdcsgCfUGKQC9rY6P8OJmxvJaO6eQO8
Hb4AmwTXKrPMhPwBy+LPoMZ5AEi31t32
=lyrR
-----END PGP SIGNATURE-----

--DXIF1lRUlMsbZ3S1--
