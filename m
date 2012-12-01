Return-Path: <ordex@autistici.org>
Date: Sat, 1 Dec 2012 12:07:12 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121201110712.GJ24115@ritirata.org>
References: <cover.1354287613.git.martin@hundeboll.net>
 <2a90563738c699d122040dde59841e4eb7750f0b.1354287613.git.martin@hundeboll.net>
 <20121201110150.GI24115@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yzvKDKJiLNESc64M"
Content-Disposition: inline
In-Reply-To: <20121201110150.GI24115@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: Save overheard and tx
 packets for decoding.
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
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--yzvKDKJiLNESc64M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 01, 2012 at 12:01:50PM +0100, Antonio Quartulli wrote:
> Hi Martin,
>=20
> On Fri, Nov 30, 2012 at 04:08:34PM +0100, Martin Hundeb=C3=B8ll wrote:
> > @@ -47,8 +48,9 @@ static void batadv_nc_start_timer(struct batadv_priv =
*bat_priv)
> >  int batadv_nc_init(struct batadv_priv *bat_priv)
> >  {
> >  	bat_priv->nc.timestamp_fwd_flush =3D jiffies;
> > +	bat_priv->nc.timestamp_sniffed_purge =3D jiffies;
> > =20
> > -	if (bat_priv->nc.coding_hash)
> > +	if (bat_priv->nc.coding_hash || bat_priv->nc.decoding_hash)
> >  		return 0;
> > =20
> >  	bat_priv->nc.coding_hash =3D batadv_hash_new(128);
> > @@ -58,6 +60,13 @@ int batadv_nc_init(struct batadv_priv *bat_priv)
> >  	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
> >  				   &batadv_nc_coding_hash_lock_class_key);
> > =20
> > +	bat_priv->nc.decoding_hash =3D batadv_hash_new(128);
> > +	if (!bat_priv->nc.decoding_hash)
> > +		goto err;
>=20
> the label err brings the flow to a lonely "return -ENOMEM". However if yo=
u it
> the case above it means that you already allocated "bat_priv->nc.coding_h=
ash"
> successfully. May you need another label so that you can free "coding_has=
h"
> and avoid memory leak?

Sorry, I'm wrong here. Returning -ENOMEM will make the caller function proc=
eed
with the cleaning up. Therefore you can ignore this comment.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--yzvKDKJiLNESc64M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQueTgAAoJEADl0hg6qKeOoVcQAIUGaBBuKUeZhkPoIrPfVIga
kXerNtwtNl+mEVVvB1udwd6rGKvllPdsAKCxoV7Qxw7tqxY0iRulZzRq3HZ60Qyz
7fkHRNhmKFOv6OXNUB6c+K0nmeQntcgwBl7Al4MEyJYJwNNwN/9mpl4RuUCBDLst
0ffgV5CdQn74xQg6VpdG+KoyKkEKMjLvqTZDcxM11goeLKhi7q6AYn+hcc9VsbXH
ZhpeNfnHP1fyJ9RLYAx1aWBuQ6Oaj6DWXsnHGPJ3L3p3UdeCu6UnFV6kSoLzMxvW
5ba+cIn5ACjdZBFCFix+DpFaRWY9xYm0pIZLiURt6tj62Mxcdi6HjBeMrq/mXA6I
h5iIDmtCsNzuGo4hFKQWXh30CgMPxXcmW9PVB1e7ZqZb7QnlCtUYdabVAsJW/iEP
CH13u5gHRrwZ2hCfcK8S/8rAp+CZj6SS3BCqSPnrwKTDN5DxRiJDX9Fd4a5Dj2qK
aKDbaHxKcc/ojWWKJ3vG9CZfn5z7n6giLQkvOWpHkG9PKLYIGfyY2sEbBrmhPBx+
Uz0VRmfD8jo2K4y3cFBh5fM9L7+iP+QT+CS5/gK0aD/EC0hSqH6EIekMmecl/Q1m
eGeScXwZA11CqkxHv58cy3m/Swq0WmUk22I2CIRnoTKLRnCs520/MrSZ7zSbAqbW
hWuA5Cb0g2h7KHkVEJJC
=xf2t
-----END PGP SIGNATURE-----

--yzvKDKJiLNESc64M--
