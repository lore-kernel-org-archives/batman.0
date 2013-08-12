Return-Path: <ordex@autistici.org>
Date: Mon, 12 Aug 2013 19:51:02 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130812175102.GK849@ritirata.org>
References: <1376224403-2494-1-git-send-email-ordex@autistici.org>
 <1376224403-2494-8-git-send-email-ordex@autistici.org>
 <20130812143129.GB18832@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gTY1JhLGodeuSBqf"
Content-Disposition: inline
In-Reply-To: <20130812143129.GB18832@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 7/9] batman-adv: adapt the neighbor
 purging routine to use the new API functions
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
Cc: Marek Lindner <lindner_marek@yahoo.de>


--gTY1JhLGodeuSBqf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2013 at 04:31:29PM +0200, Simon Wunderlich wrote:
> On Sun, Aug 11, 2013 at 02:33:21PM +0200, Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@open-mesh.com>
> >=20
> > Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> > ---
> >  originator.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/originator.c b/originator.c
> > index b3f6910..3ee8806 100644
> > --- a/originator.c
> > +++ b/originator.c
> > @@ -380,6 +380,8 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat=
_priv,
> >  	bool neigh_purged =3D false;
> >  	unsigned long last_seen;
> >  	struct batadv_hard_iface *if_incoming;
> > +	struct batadv_algo_ops *bao =3D bat_priv->bat_algo_ops;
> > +	uint32_t neigh_metric, best_metric;
> > =20
> >  	*best_neigh_node =3D NULL;
> > =20
> > @@ -414,10 +416,11 @@ batadv_purge_orig_neighbors(struct batadv_priv *b=
at_priv,
> >  			batadv_bonding_candidate_del(orig_node, neigh_node);
> >  			batadv_neigh_node_free_ref(neigh_node);
> >  		} else {
> > -			if ((!*best_neigh_node) ||
> > -			    (neigh_node->bat_iv.tq_avg >
> > -			     (*best_neigh_node)->bat_iv.tq_avg))
> > +			neigh_metric =3D bao->bat_metric_get(neigh_node);
> > +			if (!*best_neigh_node || (neigh_metric > best_metric)) {
>=20
> Shouldn't you initialize best_metric at some point?

Actually I did initialise it with UINT_MAX but I have the feeling I forgot =
to
"add" the change to the commit. However this is only saving us from a warni=
ng
(which means the initialisation is needed) but not from any other problem:
best_metric will always have a value when best_neigh_node will be not NULL.

Anyhow, good catch :)
Thanks for raising the point.

Do you think I should send the entire patchset again? Or can I just resend =
this
patch only? Marek?

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--gTY1JhLGodeuSBqf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSCSCGAAoJEADl0hg6qKeOlfwP/10Cr0iuf4WRqUXETwgiKJOA
d00O/Zz5zoYvhf3wC2SNMTXH7LPbJnZupEVOhKeI9TLKIjvsN3EVF+HP4NvBIznT
BFoVayO/6jPiJ8uVaIwwELGLC2nNXGSY/M2RxLNih41YD4W5A1yh096/iM1OBov1
3kWl3gp8d+kRx6TRVtbsPxHlE50HrtsSjEyhr7LupVjW+IyiF+QKCMfZKiwwB3cv
s4dXxWEm33NQD7DbMy9FlE79adpCbMOlJZf+gbbvy7IhtlOm+3rQgWsAut4OakvM
zzB+RJ7MAN/HQXnlB5B/3JaHL3izhu0Dfh0azesCOL2JLtCD1aIQ5VV7nWfIm16q
7sV0DHKa1SrvhaM+IYLUe5Gg+H9SkQLf85Hh20PZykKL3CsydmAYgsLoE1hR6jGY
6TXuNrMSosWjLzIRYSw47KxnIyQJoFFWqqqnC9UX/MxCyvSFQUH7VL4y2ZuffPzZ
IXQZqcJI8trHcYK7ueFyzBBF31YvnfrLrdQtAzvilM9to/nW+JqY5YYga2YrxHB2
Cc0h1iwwle9ceQQR4OWLVoKBOdMAdtpnaXnzzRiPaZIl0r1+6idgrIFBePWqBNfg
mrRGImPdfimiHy4c2Yte2lM4VG0jcY1GPbaKtyZVYCyjdexjrxBH5R9aUnMOlMJC
RggsYhMJxTJ2xYHzUPQv
=S2/O
-----END PGP SIGNATURE-----

--gTY1JhLGodeuSBqf--
