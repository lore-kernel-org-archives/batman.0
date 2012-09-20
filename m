Return-Path: <ordex@autistici.org>
Date: Thu, 20 Sep 2012 13:42:50 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120920114250.GA29329@ritirata.org>
References: <CANMkaozByUVfK9h_UAY08UDCZd6xJWg7NqPpCTWJfsyaBnEJEA@mail.gmail.com>
 <1860743.fUGhpHrPxd@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <1860743.fUGhpHrPxd@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix change mac address of
 soft iface.
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


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Def,


On Tue, Sep 18, 2012 at 04:55:32PM +0200, Sven Eckelmann wrote:
> On Tuesday 18 September 2012 16:41:58 Def wrote:
> >  Into function interface_set_mac_addr, the function tt_local_add
> >  was invoked before updating dev->dev_addr. The new MAC
> >  addresse was not tagged as NoPurge.
> >=20
>=20
> Please don't add extra whitespaces before your commit message.
>=20
> Your Signed-off-by: is missing.
>=20
> [...]
> > -
> > -	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
> > +=09
>=20
> Please don't add trailing whitespaces.
>=20
> I have no idea whether this works... *looks at Antonio*. But thanks for
> bringing this up in the issue tracker and sending this first version of t=
he
> patch.

sorry for the delay. Overall the patch is correct, I also tested it and it
correctly fixes the problem.

Please, address what Sven just said so that the patch is clean (you can als=
o use
checkpatch.pl --strict to check for this style things..it is in your
linux/scripts/ directory as documented in the file cited by Sven)

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlBbAToACgkQpGgxIkP9cwehdwCeO4akXGRMxZ2xZZO0DSIEKWQ4
XkwAnjtHMbwxmcEn+AiMumglVObD0gqx
=bmv5
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
