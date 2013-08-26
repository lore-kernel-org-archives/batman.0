Return-Path: <ordex@autistici.org>
Date: Mon, 26 Aug 2013 08:37:51 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130826063751.GF2896@ritirata.org>
References: <1376376232-2178-1-git-send-email-ordex@autistici.org>
 <1376376232-2178-6-git-send-email-ordex@autistici.org>
 <201308260949.42642.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline
In-Reply-To: <201308260949.42642.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 5/9] batman-adv: add
 bat_metric_is_equiv_or_better API function
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


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2013 at 09:49:42AM +0800, Marek Lindner wrote:
> On Tuesday, August 13, 2013 14:43:48 Antonio Quartulli wrote:
> > +static bool batadv_iv_ogm_metric_is_eob(uint32_t metric, uint32_t
> > new_metric) +{
> > +	return (metric - new_metric < BATADV_TQ_SIMILARITY_THRESHOLD);
> > +}
> > +
>=20
> Kernel doc ?
>=20
>=20
> > diff --git a/types.h b/types.h
> > index 2b5b1c1..7a12eef 100644
> > --- a/types.h
> > +++ b/types.h
> > @@ -991,6 +991,8 @@ struct batadv_forw_packet {
> >   * @bat_primary_iface_set: called when primary interface is selected /
> > changed * @bat_ogm_schedule: prepare a new outgoing OGM for the send qu=
eue
> > * @bat_ogm_emit: send scheduled OGM
> > + * @bat_metric_is_equiv_or_better: check if new_metric is good enough =
to
> > be + *  comparable with metric
> >   * @bat_orig_print: print the originator table
> >   */
>=20
> How about this description:=20
> Returns true if new_metric is equally good or better than metric.
>=20
> Actually, you could call the parameters metricA and metricB or something =
along=20
> these lines.

ok, thanks!

>=20
> Cheers,
> Marek

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSGve/AAoJEADl0hg6qKeORGAQALLqAVdLytZWJYuaXUCwk84o
kH7I7LtRcyHVcIlF8JVYaCblLBZ55WEekKVtfzhoMc8bRqaeaNHdLwkzP9wRxDS2
dY/8AxDAcwzWakLnk3GXi86G4k0FlBUO+qQvFvX1kSZx2eP1YW3vHhbiLddrUKHt
EeGOmuhwnG6grEm0Uoiuf4XkhoP0JcqOr/Owtg6nqHIu1eGuC/b7xHeaRFABtZGJ
TAH6cRqFxIqOScWWgKqMh8wj4Bvn8max08rFiCypvbgPqeAJySwmCY4HOg4/nCgG
Mm+E+VzmuQBW6XZgTnR2aBSSgtUxa6EX0U6Z8T0QLPIeig4018t85rVQXs+PC3eA
2zRfG26xopGx5GwDfDHxwDm8RbVQKD488+dvPijLQuQmdzU7vAKHqCPzp2mYD0qZ
Md8mTk7be16+iMiPo7cBnv2U8pm1mDndPqiwxuZjGUbstxj2xxFSAAvjpqPttgJu
01+KVrZYf5VMhStLiTUzjk0pSkaPB6CqZwKV/sidDhsM7Et1YmHwxFGlqZqCW1hx
7OBrpgig/JT70WgK5sGNhYvfXHI5SCYSHR8L32iqWwEwwKeOmFKQX+ArEuA6nw62
RrN3O0j8DYjR+Zo0nP5PIlTDNTHyOgx/15PxltDH7cyUV7tz/W2u+f9fd3sOU/1S
EMNxymraPljAkIALnxDX
=7k5/
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
