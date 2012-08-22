Return-Path: <ordex@autistici.org>
Date: Wed, 22 Aug 2012 02:07:53 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120822000753.GB27849@ritirata.org>
References: <1343736871-7131-1-git-send-email-ordex@autistici.org>
 <1344638599-31985-1-git-send-email-ordex@autistici.org>
 <201208220203.50737.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <201208220203.50737.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] batman-adv: pass the WIFI flag from
 the local to global entry
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


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 22, 2012 at 02:03:50 +0200, Marek Lindner wrote:
> On Saturday, August 11, 2012 00:43:19 Antonio Quartulli wrote:
> > +static void __batadv_tt_local_remove(struct batadv_priv *bat_priv,
> > +                                    struct batadv_tt_local_entry
> > *tt_local, +                                    const char *message, bo=
ol
> > roaming) +{
> > +       uint16_t flags;
> > +
> > +       flags =3D BATADV_TT_CLIENT_DEL;
> > +       if (roaming)
> > +               flags |=3D BATADV_TT_CLIENT_ROAM;
> > +
> > +       batadv_tt_local_set_pending(bat_priv, tt_local, flags, message);
> > +}
>=20
> How about adding some kernel documentation ?  :)

I agree :) We discussed kernel documentation after I sent this patch. Will =
add
and send version 4.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlA0ItkACgkQpGgxIkP9cwfnRgCeNVV9jVFKwnNBKd/9bU2dEhlz
YpcAn2JHA9Lbcs0J8++/JC6VJ9JMcmHM
=x2Mg
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
