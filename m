Return-Path: <ordex@autistici.org>
Date: Sun, 15 Jul 2012 21:42:54 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120715194254.GE16072@ritirata.org>
References: <1341144314-20995-1-git-send-email-sven@narfation.org>
 <1341766146-21037-1-git-send-email-sven@narfation.org>
 <20120715192630.GD16072@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Content-Disposition: inline
In-Reply-To: <20120715192630.GD16072@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Split batadv_priv in
 sub-structures for features
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


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 15, 2012 at 09:26:30PM +0200, Antonio Quartulli wrote:
> > +	int16_t buff_len;
>=20
> int16_t last_changeset_len;
>=20
> > +	spinlock_t buff_lock; /* protects buff */
>=20
> spinlock_t last_changeset_lock; /* protects buff_lock */


ops, typo :) I meant "/* protects last_changeset */" (thanks Marek :))

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlADHT4ACgkQpGgxIkP9cweF3ACeKDpWVAO+v/VkVFXFliIEG5Wq
S+EAn1DOHYUMHJOJE2nVj/VdQy3yooQb
=lL3e
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--
