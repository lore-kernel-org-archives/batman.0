Return-Path: <antonio@meshcoding.com>
Date: Sat, 16 Nov 2013 10:11:08 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131116091108.GJ1663@neomailbox.net>
References: <1384360685-366-1-git-send-email-antonio@meshcoding.com>
 <1384360685-366-3-git-send-email-antonio@meshcoding.com>
 <6858187.HqJ4FjDvbE@diderot>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mFHiwr52TKrxpkjc"
Content-Disposition: inline
In-Reply-To: <6858187.HqJ4FjDvbE@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/6] batman-adv: mark a local client as
 isolated when needed
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


--mFHiwr52TKrxpkjc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2013 at 01:31:11PM +0800, Marek Lindner wrote:
> On Wednesday 13 November 2013 17:38:01 Antonio Quartulli wrote:
> > @@ -474,7 +474,7 @@ static void batadv_tt_global_free(struct batadv_priv
> > *bat_priv, * Returns true if the client was successfully added, false
> > otherwise. */
> >  bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t
> > *addr, -                        unsigned short vid, int ifindex)
> > +                        unsigned short vid, int ifindex, uint32_t mark)
> >  {
> >         struct batadv_priv *bat_priv =3D netdev_priv(soft_iface);
> >         struct batadv_tt_local_entry *tt_local;
>=20
> Kernel doc ?

argh, I tried to escape the kerneldoc tradition :D

Will do. Thanks a lot!

Cheers,

--=20
Antonio Quartulli

--mFHiwr52TKrxpkjc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJShzasAAoJEADl0hg6qKeOxfIP/3qOVPKLkmAdnBBPn+m7NNsl
QlQM0fx7inCCuL76Tc777Wyqa1s6FikODcvrVAykHtKzWtWUWr4S1p/1hfg5oGvS
ZNENYphZljOy/IfODYs6W7SdIaZ+De6NqAlXowErxD21NSGSMPDAS0I1jjXeIbng
NkVNB3ovYxXqJg7etrYNbEANJMm5xdj3DYuwuh3QYCKjBvZvdSQaPYUZ+v8gUi6v
iajzvLo/NsdlurCa9whqH3jrGN/uegXfYGFGn/Pt8mMkccqCcaUlctl4sGT7JEnT
C9RJYyiAQXIKVIdIFALMpLYNtLlCl/R/RnBUwrf1HHR5QkCrazfduT1EOFGGlxfD
0GcPsMGU78GXFg6PNIU+C6d6/9MTJQ/Jsmiz0IJtv3nkyUBHaIdxoQdt1j8ty03F
c/pwI8UnjT9mtFuX0nOYRXFeSdafb3+3G9v9gTsM3qNC/iJ33GBrzNJcFA+TH3o8
UBmazO7bEkqkIG82AsaXI+yA8fJVtVLWM1gVotdv6b7lC0YlGPmZV678joxc7miR
7Wb3gpvdEhE07NlsKoZngq88xo36SewbO4mhPlfo216+VqP9SQopEhNFlMEIofRa
2I+HUoSP2R0D5Mbj3dh3YLqV/Zgt4xDhaaHEbxWDHUVJ4NJ8vUdDizam7ZP0krF7
uUv6M4n105uWs5F1/5kC
=s6h/
-----END PGP SIGNATURE-----

--mFHiwr52TKrxpkjc--
