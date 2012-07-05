Return-Path: <ordex@autistici.org>
Date: Fri, 6 Jul 2012 00:16:07 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120705221607.GN2917@ritirata.org>
References: <1341235378-3111-1-git-send-email-ordex@autistici.org>
	<201207060000.00086.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3mUD2hqWbnBptYHy"
Content-Disposition: inline
In-Reply-To: <201207060000.00086.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: generalise size in bitarray
 API
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


--3mUD2hqWbnBptYHy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2012 at 11:59:59PM +0200, Marek Lindner wrote:
> On Monday, July 02, 2012 15:22:58 Antonio Quartulli wrote:
> >         /* sequence number is much newer, probably missed a lot of pack=
ets
> > */ -       if (seq_num_diff >=3D BATADV_TQ_LOCAL_WINDOW_SIZE &&
> > +       if (seq_num_diff >=3D size &&
> >             seq_num_diff < BATADV_EXPECTED_SEQNO_RANGE) {
> >                 batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> >                            "We missed a lot of packets (%i) !\n",
> >                            seq_num_diff - 1);
> > -               bitmap_zero(seq_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
> > +               bitmap_zero(seq_bits, size);
> >                 if (set_mark)
> > -                       batadv_set_bit(seq_bits, 0);
> > +                       batadv_set_bit(seq_bits, 0, size);
> >                 return 1;
> >         }
> > =20
> > @@ -80,15 +81,15 @@ int batadv_bit_get_packet(void *priv, unsigned long
> > *seq_bits, * packet should be dropped without calling this function if =
the
> > * seqno window is protected.
> >          */
> > -       if (seq_num_diff <=3D -BATADV_TQ_LOCAL_WINDOW_SIZE ||
> > +       if (seq_num_diff <=3D -size ||
> >             seq_num_diff >=3D BATADV_EXPECTED_SEQNO_RANGE) {
>=20
> Without addressing BATADV_EXPECTED_SEQNO_RANGE this change does not make =
sense=20
> for batadv_bit_get_packet(). Looking at the function as a whole I'd say i=
t is=20
> very specific for the OGM handling. Thus, it will be difficult to use it =
for=20
> anything else or do you have a sample use case ?

Hi,

mh, no we don't. Drop this patch, I'd say we need a more sophisticated chan=
ged
:)

Thank you,

>=20
> Regards,
> Marek

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--3mUD2hqWbnBptYHy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/2EicACgkQpGgxIkP9cwcPwwCfXydwBULsMh/nWQFJ1AvlEByg
+/wAnjXcB7rNgKPZOrwWWp/F9wP4N0i+
=30RB
-----END PGP SIGNATURE-----

--3mUD2hqWbnBptYHy--
