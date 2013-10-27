Return-Path: <antonio@meshcoding.com>
Date: Sun, 27 Oct 2013 10:53:25 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131027095325.GA510@neomailbox.net>
References: <1382774343-3316-1-git-send-email-antonio@meshcoding.com>
 <92195114.hafFiLUq8s@diderot>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <92195114.hafFiLUq8s@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: deselect current GW on
 client mode switch off
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


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2013 at 05:46:13PM +0800, Marek Lindner wrote:
> On Saturday 26 October 2013 09:59:03 Antonio Quartulli wrote:
> > diff --git a/gateway_client.c b/gateway_client.c
> > index 2449afa..2903bdb 100644
> > --- a/gateway_client.c
> > +++ b/gateway_client.c
> > @@ -207,6 +207,10 @@ void batadv_gw_check_client_stop(struct batadv_priv
> > *bat_priv) if (!curr_gw)
> >  		return;
> >=20
> > +	/* deselect the current gateway so that next time that client mode is
> > +	 * enabled a proper GW_ADD event can be sent */
> > +	batadv_gw_select(bat_priv, NULL);
> > +
> >  	/* if batman-adv is switching the gw client mode off and a gateway was
> >  	 * already selected, send a DEL uevent
> >  	 */
>=20
> Right above the batadv_gw_check_client_stop() call in batadv_store_gw_mod=
e() a=20
> very similar function is called: batadv_gw_deselect().
>=20
> Calling batadv_gw_deselect() is not enough to ensure an ADD event is sent=
 ?

no. this function is used in several points and it is just an indicator that
tells the GW code to perform a re-election. It does not guarantee that an e=
vent
is going to be sent (on re-election the same GW could be elected once again=
=2E.)

> In
> case the old gateway =3D=3D new gateway we have no event ? If so, that sh=
ould be=20
> documented somehwere ..

did you expect an event in case of (old gw =3D=3D new gw) ?
It's neither an ADD nor a CHANGE nor a DEL...


Cheers,

--=20
Antonio Quartulli

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSbOKVAAoJEADl0hg6qKeOYdsQAJQN8Lp8FwlWi0CJ0s4TcQ6i
MlkEybCNybLE5JD7lt1bf05cdDUsZkyIwcaaDyOYmwL5HaPcjahFekDIjM+FrN8T
QB3zq0TuVAqHQM/LBHW1Z2qW+7nFJAcWSm+XMuZJ9tD6zy2urqorWWvlIwuduGpS
ZI6Y2jHlsxboiAaVuHP223YqaPJcjI28hgluUEvTVvw8csFTtEi6Ahcfyz0OO9wK
DOl6S2wAjuSgPh+Gree/34OgYAFtxVxiKwI/KVvAK9hwC6r+w0mIw0DDuDf3j4qq
TJPM2yiUKk8tLD8GY4hmfy/y0ei8zsYDSDfhhrbFlnlTVPtbvKnoQLXAzos/nLmP
NrbdJviWseXu2bvKBFMwNKMTJFyc1Vq5KItqeeSs/pdcFr4Hv5ReiBHWIKrfnm3Y
j2XJxSnqhkr5mMuhlJ5gcFOR6to83o2OkSCbobUjTnbB52L0xEo3ciGxeEXBf6Qu
GXKic+PL1Uhyigg8wij6wkXdr3SKRdLDvcRHvrlmsrFQH5pPENdXKZ8JKbNqPZXg
ERP5A5U0/dEFJ8jjHNJgm4988/M6UXUJ4ZGND+QcsjfEprUAxT2ycufMpW64vUDr
yfoL0PMrJmiZwc6PVNqKR5lPBKK+p206eaa3WI6kS5qLun7MUPHmOqQ3fOzJtv2+
63GcFIQFRHyxeN6zOMvd
=a41V
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
