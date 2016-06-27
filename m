Return-Path: <a@unstable.cc>
Date: Mon, 27 Jun 2016 10:41:42 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160627024142.GZ10666@prodigo>
References: <20160612041426.26339-1-a@unstable.cc>
 <20160612041426.26339-4-a@unstable.cc>
 <3127928.zeFBqT8Kuq@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="znFrcFTOc9PDN8kJ"
Content-Disposition: inline
In-Reply-To: <3127928.zeFBqT8Kuq@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 3/4] batman-adv: B.A.T.M.A.N. V -
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


--znFrcFTOc9PDN8kJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2016 at 01:12:52PM +0200, Sven Eckelmann wrote:
> On Sunday 12 June 2016 12:14:25 Antonio Quartulli wrote:
> > --- a/net/batman-adv/gateway_client.c
> > +++ b/net/batman-adv/gateway_client.c
> > @@ -215,6 +215,10 @@ void batadv_gw_election(struct batadv_priv *bat_pr=
iv)
> >         if (!batadv_atomic_dec_not_zero(&bat_priv->gw.reselect) && curr=
_gw)
> >                 goto out;
> > =20
> > +       /* if gw.reselect is set to 1 it means that a previous call to
> > +        * gw.is_eligible() said that we have a new best GW, therefore =
it can
> > +        * now be picked from the list and selected
> > +        */
> >         next_gw =3D bat_priv->algo_ops->gw.get_best_gw_node(bat_priv);
>=20
> I would guess that this should be either in patch 2/4 on in an extra patc=
h. At
> least it is about nothing which is touched otherwise in this patch

Good catch :) Thanks !

I am moving the comment to patch 2/4.

Cheers,

--=20
Antonio Quartulli

--znFrcFTOc9PDN8kJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXcJJmAAoJEJ4aZjxxc6bK/KsP/j3DzyMtMWABOIHEvrmu5nST
UBc2foa+J7ulHthHgsV7yqq6yDaJlSi7VmdIh3DD3jANKg/1SlWU4o8Y/3fVzE3O
B3xN2/+aDLpS6S2+8YQrr/HUs8uM+r1GSYdYIwCqLgARxlDhGl0Rpt5Dzss1TVbb
voLs6Fs3EBAzeiqVJOWGeWOMXlx0PPYL+ulECxvWX62X4TtEsjZsWFWLu/Vsb9bj
JUDolE9hvZpP2ljgiCXUlW/e6pZ7wJsgPaXzY7Xeq4OYxyhqJrGyIPWsyJBJyaAX
AXCIFfHuqoLLNIvxroGBZORomAd1F6WVlhLUCscWXSvGi9Arm9kPH2aKnCBNB2WN
x5EEVHqBpYf9LbPsQqtpmkBQ6EACiHlUOfvk4cGEObOpQTpRLjaDzb26PeV8AzTC
MgEQ5GomaTFOSd2fWQvFNp0nFiWf1p1F2gu5BWjbpL0pu8Rwl5XUM1o752hGOSRw
RLNcaZNnFIjs1etWzRuvZyAkczJjal9VoIwDwzIfuAQDSLRL5R0QpvYdadhWlMfp
4oo4JTG1RDRLg6q8eSDocORc2v8jsA9dpQIIhwJeEnzHWfD5EIcQ+N25kA+rRNs1
RptO/z6WOh9DNEiwWaFub4nE2bFHl/g4Hs8ocHaI6ObeMknCyo0M2ZpcPQPGr28B
T/lL728kculqthJcaofp
=7+lo
-----END PGP SIGNATURE-----

--znFrcFTOc9PDN8kJ--
