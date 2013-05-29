Return-Path: <ordex@autistici.org>
Date: Wed, 29 May 2013 09:08:59 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130529070859.GL3333@ritirata.org>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
 <51A59E1F.5070204@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JsihDCElWRmQcbOr"
Content-Disposition: inline
In-Reply-To: <51A59E1F.5070204@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [RFC 00/10] Improving the routing protocol
 abstraction
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
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--JsihDCElWRmQcbOr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 08:20:15AM +0200, Martin Hundeb=C3=B8ll wrote:
> Hi Antonio,
>=20
> Great work. We are looking forward to the next generation of Batman=20
> (shouldn't that be Robin?) :)
>=20
> On 2013-05-29 00:20, Antonio Quartulli wrote:
> > Antonio Quartulli (10):
> >    batman-adv: make struct batadv_neigh_node algorithm agnostic
> >    batman-adv: make struct batadv_orig_node algorithm agnostic
> >    batman-adv: add bat_orig_print function API
> >    batman-adv: add bat_metric_get API function
> >    batman-adv: add bat_metric_is_similar API function
> >    batman-adv: add bat_metric_compare API function
> >    batman-adv: adapt bonding to use the new API functions
> >    batman-adv: adapt the gateway feature to use the new API functions
> >    batman-adv: adapt the neighbor purging routine to use the new API
> >      functions
> >    batman-adv: provide orig_node routing API
>=20
> I see that in nc.c you changed the uses of neigh_node->tq_avg to the new=
=20
> private algo-specific struct (neigh_node->bat_iv.tq_avg), but there is=20
> no patch to make nc.c use the new API (bat_algo_ops.bat_metric_get() )...
>=20
> Is this because you were in doubt wether NC will be usable with bat_v or=
=20
> just because you did "make && git-push" ? :)

because I am totally unaware on how this should work in a generic fashion :)
maybe you can try to describe what is needed and then we try together to ma=
ke
the API comfortable for NC too.

Thanks!

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--JsihDCElWRmQcbOr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRpamLAAoJEADl0hg6qKeO4hAQALfDdv3rkMRByt4Zt2ephFCc
B8nAoMED0SDRATJZnTKfHqn+lnwS0FXcVct15TK5rJXqhalFTfBL7eDcF2JLFg4l
Ik2vbdxzNCpIiipcq5inSGGEFTVUdDF7EgAoxCcj/NsrF1b/FbhyUyPhGe/SWwGo
2z/m7Fsi/BQDllNiPFTApq1KjuDYe35/Y3WZT6pyWXilKGn3SCxnLuVo58cmPWEp
1KDRf66/VtJe7Ko6BEtwjrifcPk5+3MR7zQbiQhfqgPorPnkinYWukS2XKpc1u5T
pgc2Cc/6lUcQi5NpRA9xsYsUsViNfR+WO9LJFcoIQl39qDD48pqA0mMPyk1FG+he
J4qzPIjuBSsz2ZkTgZsM0JDJbAAuKiiq4C4yxGPRc7S0Ist48t3ktwVAQqLFbKIk
cXCkeB4HmoYIYB9QWC0bI8rc3MwKRxkQ1hILEEYV52eu8S/L9INBrMS+V94Qg4gk
msOF207wmPFQi4CiUz7f9UGztyU9LsbnBcfdeXhlP7v6mh8zwY+LduIjOS8XgO0h
KquBbS56c3nzkk3yVLtH7qMaa8jVuzT61uQC7leeC5i5xYd00gmiBazyre//QJ38
f2sYWh1ZKJbXegpaYrqXlf7Bgl2zsg4CvcAKNjZ5PDdnk4XoLbrFVVq1DdtzW9Dx
wkT9d87CmPfOsFWNMT5P
=aM3J
-----END PGP SIGNATURE-----

--JsihDCElWRmQcbOr--
