Return-Path: <a@unstable.cc>
Date: Fri, 27 May 2016 21:57:29 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160527135729.GS13048@prodigo>
References: <20160525152736.9031-1-a@unstable.cc>
 <20160525152736.9031-6-a@unstable.cc> <1623801.mhGnxyytJi@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jllsgs4PL/sXFNaa"
Content-Disposition: inline
In-Reply-To: <1623801.mhGnxyytJi@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 5/6] batman-adv: B.A.T.M.A.N. V -
 implement GW selection logic
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--jllsgs4PL/sXFNaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 27, 2016 at 03:48:37PM +0200, Sven Eckelmann wrote:
> On Wednesday 25 May 2016 23:27:35 Antonio Quartulli wrote:
> > +#ifdef CONFIG_BATMAN_ADV_BATMAN_V
> > +struct batadv_gw_node *batadv_gw_node_get(struct batadv_priv *bat_priv,
> > +                                         struct batadv_orig_node *orig=
_node);
> > +#endif /* CONFIG_BATMAN_ADV_BATMAN_V */
>=20
> This is rather odd because the function is also compiled (and used) even =
when
> CONFIG_BATMAN_ADV_BATMAN_V is not enabled.
>=20
> Here is the relevant diff:
>=20
> > @@ -356,9 +360,8 @@ static void batadv_gw_node_add(struct batadv_priv *=
bat_priv,
> >   *
> >   * Return: gateway node if found or NULL otherwise.
> >   */
> > -static struct batadv_gw_node *
> > -batadv_gw_node_get(struct batadv_priv *bat_priv,
> > -                  struct batadv_orig_node *orig_node)
> > +struct batadv_gw_node *batadv_gw_node_get(struct batadv_priv *bat_priv,
> > +                                         struct batadv_orig_node *orig=
_node)
> >  {
> >         struct batadv_gw_node *gw_node_tmp, *gw_node =3D NULL;
> > =20
>=20
> Maybe you should drop the CONFIG_BATMAN_ADV_BATMAN_V check.
>=20
> But I should at least whitelist the batadv_gw_node_get for the unused sym=
bols
> check.

This is exactly the point: when CONFIG_BATMAN_ADV_BATMAN_V is not selected =
this
exported symbol is not used. Therefore I was not confident if the right way=
 to
go was to put the declaration within the #ifdef block or not..

Do you think it makes more sense to keep the declaration and whitelist the
function in your test ?

Cheers,


--=20
Antonio Quartulli

--jllsgs4PL/sXFNaa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXSFJJAAoJEJ4aZjxxc6bKqVoQAJBlY7j2E1cDtJC4e2kPgv+s
YZBZfDGbFiPFyxAHbOx4CSCM8ZsDEzGUVfkRyh1akwnCZwGIzq9sUPTN3HEK7f7Z
gFiV2Xqais2X/CaVM2oSPX4IoGsBJC+/62813wJVpcjQ3TZ+nKI8oWygHDA+Edc1
WL7kujfOvtCuf3VUAVWY3siNX0dXbSjRFJCvfvkP95AdssXhhq1AFQ7xJL9kGvZ/
zZ0dtaUcud6JljilrFFGiV7fgUsRinKfUueFmhDUznTVuJfoiN237+uyN0VCW7tT
+sBTQbDO2RM90CGv3tNYsKd+zLrSczHZUoaEEGpF0dX9sKhVu0A1pNE963hUhYpA
K2MI9lzFRpwp5GjqiLee5xxWANg1Apm0G+LrNBAIwhGPYONamqTjWs7moqjUSqXf
0BiMDe62KJoIekNqn90NbNNWRqfNGiO4mlt45TE8SMLtYc665BZ48RV47Ktas/5E
5/XqXMbtDDOyK+wpQ76lI0DfcFjXC0MM6SZo3376SLTQWRtalN0EL4CeNI2cd51p
0Eewr0qbNVIvWyMIIKA2qziqqiteOYYuVJ0WXXi/gGtMSxmD8/RSkBcUgXIPiiBf
F/H8lCMDVvPo+GGMa1Ryi+iubRoeV5DiRgVP7PmeUjjgkPVT6VcfljssZvgYu7kZ
5nzmhqZeESrLxycX64nt
=qBTv
-----END PGP SIGNATURE-----

--jllsgs4PL/sXFNaa--
