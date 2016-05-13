Return-Path: <a@unstable.cc>
Date: Fri, 13 May 2016 21:23:35 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160513132335.GJ21549@prodigo.lan>
References: <1462874769-5077-1-git-send-email-a@unstable.cc>
 <1462874769-5077-4-git-send-email-a@unstable.cc>
 <2870286.TlxMuhjIas@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ublo+h3cBgJ33ahC"
Content-Disposition: inline
In-Reply-To: <2870286.TlxMuhjIas@voltaire>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 4/5] batman-adv: make GW election code
 protocol specific
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--Ublo+h3cBgJ33ahC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 13, 2016 at 07:07:52PM +0800, Marek Lindner wrote:
> On Tuesday, May 10, 2016 18:06:08 Antonio Quartulli wrote:
> > +static struct batadv_gw_node *
> > +batadv_iv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
>=20
> > +static bool batadv_iv_gw_is_eligible(struct batadv_priv *bat_priv,
> > +				     struct batadv_orig_node *curr_gw_orig,
> > +				     struct batadv_orig_node *orig_node)
>=20
> > +/* fails if orig_node has no router */
> > +static int batadv_iv_gw_write_buffer_text(struct batadv_priv *bat_priv,
> > +					  struct seq_file *seq,
> > +					  const struct batadv_gw_node *gw_node)
>=20
> > +static void batadv_iv_gw_print(struct batadv_priv *bat_priv,
> > +			       struct seq_file *seq)
>=20
> How about some kernel doc ?  :)

ok :)

>=20
>=20
> > +211,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv) if
> > (!batadv_atomic_dec_not_zero(&bat_priv->gw.reselect) && curr_gw) goto o=
ut;
> >=20
> > -	next_gw =3D batadv_gw_get_best_gw_node(bat_priv);
> > +	next_gw =3D bat_priv->algo_ops->gw.get_best_gw_node(bat_priv);
>=20
> Either make the gw.get_best_gw_node() ops mandatory or check for its exis=
tence=20
> before using it.

I think we should always check the existence of this function.

However I also wanted to propose to reject any change of the GW mode if we =
do
not have these APIs implemented. But tihs can be done with a later patch.

>=20
>=20
> > @@ -1320,11 +1320,21 @@ struct batadv_algo_orig_ops {
> >=20
> >   * struct batadv_algo_gw_ops - mesh algorithm callbacks (GW specific)
> >   * @store_sel_class: parse and stores a new GW selection class
> >   * @show_sel_class: prints the current GW selection class
> >=20
> > + * @get_best_gw_node: select the best GW from the list of available no=
des
> > + * @is_eligible: check if a newly discovered GW is a potential candida=
te
> > for
> > + *  the election as best GW
> > + * @print: print the gateway table (optional)
> >=20
> >   */
>=20
> Shall we mark all optional ops as optional or .. ?

Dunno...this was a just a copy/paste from other "print" APIs. Maybe we just
remove the "optional" text from here for now.


Cheers,


--=20
Antonio Quartulli

--Ublo+h3cBgJ33ahC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXNdVXAAoJEJ4aZjxxc6bKGdMQALr272q8w4NOUNkRCujz6qrJ
FsvGWcLQxylePQEffsgUOoSBHKD97Iy7WKLFc9w5HV+HtaUkdU8CvHSbJrlAlKe9
/psL9mJNm4Mke5DJSulXroKa/JW+ojwo+DjqO+a7CWvGpAcBqN+/+3T+h24s3Gd/
AtMTWr+ZYS9EjYjGHg/J1MmwIM/K+lSJPFembB/PBaOv63arC0t6WDKHX91dorgp
GtkSJJ9okIpmRS9kdyDnhGNzTkMUy2mdWXVkLT9UzneVCJSUXYGbA441F0jFGVxB
xxrS41yhTgX6AU+1s+1MJjMmn3CjPgcljEVBl7Y4nMp7/USaH4lc0lwz0BwCQ8Ew
C0e9kBXb9sxaLeh4BF1WyEpuiFFXDzZceQwC+rTem82LgmtnKp/5HaSMYQqsNNnx
RhEj2zb1uzHCsh8pE/3HACB6Ynwe13uRoHrH0+0GGLDMgsHhLgtxB4anq5Oj3pjS
xyQh5pDb4s14gaAkxPY2M7PrU7pXrYjjFayo3p9ZHmN0lmBbDahr6rQbVaRihK6y
IsPpsHJsQuwEB/Mw7fJGFUAh2e+lsgfNlXXms1MZVNITHKkTIOG8oyaoChN1o0os
E6ezSdDWC38teI0AwIf9vhvwlAoqk92YkRGkPZI9UH0lkiP3DiA5bP6EE3xyu4lr
FPoFD05vMp9WdSQlZ0/W
=6Uo8
-----END PGP SIGNATURE-----

--Ublo+h3cBgJ33ahC--
