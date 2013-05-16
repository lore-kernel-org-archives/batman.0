Return-Path: <ordex@autistici.org>
Date: Thu, 16 May 2013 21:41:20 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130516194120.GI3350@ritirata.org>
References: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
 <1368293014-30742-3-git-send-email-linus.luessing@web.de>
 <20130511231113.GE901@ritirata.org>
 <20130516181945.GC22374@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fUvfsPTz/SzOZDdw"
Content-Disposition: inline
In-Reply-To: <20130516181945.GC22374@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Announce new capability
 via multicast TVLV
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


--fUvfsPTz/SzOZDdw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2013 at 08:19:45PM +0200, Linus L=C3=BCssing wrote:
> >=20
> > > +
> > > +	if (!(mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) &&
> > > +	    orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT) {
> > > +		atomic_inc(&bat_priv->mcast_num_non_aware);
> > > +	} else if (mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT &&
> > > +		   !(orig->mcast_flags & BATADV_MCAST_LISTENER_ANNOUNCEMENT)) {
> > > +		atomic_dec(&bat_priv->mcast_num_non_aware);
> > > +	}
> > > +
> > > +	orig->mcast_flags =3D mcast_flags;
> > > +}
> >=20
> > > diff --git a/originator.c b/originator.c
> > > index 5d53d2f..acc0c2d 100644
> > > --- a/originator.c
> > > +++ b/originator.c
> > > @@ -257,6 +257,9 @@ struct batadv_orig_node *batadv_get_orig_node(str=
uct batadv_priv *bat_priv,
> > >  	reset_time =3D jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTI=
ON_MS);
> > >  	orig_node->bcast_seqno_reset =3D reset_time;
> > >  	orig_node->batman_seqno_reset =3D reset_time;
> > > +#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
> > > +	orig_node->mcast_flags =3D BATADV_MCAST_LISTENER_ANNOUNCEMENT;
> > > +#endif
> >=20
> > why do you start assuming that an originator has the optimisation enabl=
ed? would
> > it be better to wait for the first mcast tvlv from it to claim this?
>=20
> Because it is easier code-wise. I had it the other way round first
> and issuing an atomic_inc(&bat_priv->mcast_num_non_ware) in
> batadv_get_orig_node(), but then I ended up counting up too many
> times because I was increasing that counter for secondary
> interface originators, too while not decreasing it again because
> no TVLV handler will be called for these. And within
> batadv_get_orig_node() I don't see an easy way to determine
> whether I was called for a primary or secondary interface
> originator.
>=20

mh..I don't really understand this (maybe because I don't have a deep knowl=
edge
of this code). My idea was to start with:

orig_node->mcast_flags =3D BATADV_NO_FLAGS;

and to set

orig_node->mcast_flags =3D BATADV_MCAST_LISTENER_ANNOUNCEMENT;

only in the received TVLV parsing function (if any TVLV has been received).
Is this inconsistent with what you have in the code?


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--fUvfsPTz/SzOZDdw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRlTZgAAoJEADl0hg6qKeOD3QQAIzHv+NU9j2NHjBJBW1VVzZW
BAlKlDjyFR3aVe64pXbxqLE8ngF9DIaJMmwK1cdWfv5FFqBSjQgL00b+/OQWpMc9
lGaj0PDugQ33BTF+Fq9Ssd1i/L/oqHURbyNtjUVnGXxChrCdpvGNVsvBXti6GX6J
JbcT6UlafMetUSspdLfYvkom8831JGFZDCYXES7Pyx0KJaTSzSrzua1vLl+8p0x2
h0aFitV8NL+ftIWq4EzL0ZyJb1xXJ3amwT9NOLjhWwsumSq2w6bMvR2vRw8pfcBF
19Vd3/lXVgCNTBnO0JogEWffL+0KUO7J77J2nu3R6qPMpbWjawt/E9rI159BarJp
8BE0R/v7saEEG0kXwvIUJGQB4FbQTSF5wlGO+byLkO9bde3hrdZZ/OUeINYNluxq
Y97tS4z27JVVfilQwIuLDzsVxdekw0y//AbDHQGZxTdb4F2BpIwtsXeCQDmealo9
tuVK/65HEmPUu8xeoIRpnipR63dbiW9/dzo5+v3B1wWYWqw2j0Dw4hKSF+AJfZ5r
stQ0KEYpjoL8SuiBFQ/MrMMGEiRCuM5wE/sH3bPDFWbZhhp3mjjHq22vBqoE/fzm
gK/Ou9cs3HZFLGXkM25pImViyO6Px3vgWTKQxPmtolUTVCBG01ft6RiowytfLP9z
iyCyG81/PkuvYqGCd1WP
=IE56
-----END PGP SIGNATURE-----

--fUvfsPTz/SzOZDdw--
