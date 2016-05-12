Return-Path: <a@unstable.cc>
Date: Fri, 13 May 2016 05:07:18 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160512210718.GG21549@prodigo.lan>
References: <1462962557-23950-1-git-send-email-a@unstable.cc>
 <2789203.91ASHWIDJV@bentobox> <20160511104730.GB21549@prodigo.lan>
 <5284085.o6G6OjSAFN@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NPukt5Otb9an/u20"
Content-Disposition: inline
In-Reply-To: <5284085.o6G6OjSAFN@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: remove forward
 declaration by including proper header
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


--NPukt5Otb9an/u20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2016 at 02:24:04PM +0200, Sven Eckelmann wrote:
> On Wednesday 11 May 2016 18:47:30 Antonio Quartulli wrote:
> [...]
> > Maybe I could include it only when really needed, i.e.
> >  * net/batman-adv/bat_algo.h
> >  * net/batman-adv/bat_v_ogm.h
> >=20
> > (netlink.h does not seem to be requiring it)
>=20
> This is rather vague and hard to detect automatically. Potentially all
> files may require it because it has things like:
>=20
>     /* Debug Messages */
>     #ifdef pr_fmt
>     #undef pr_fmt
>     #endif
>     /* Append 'batman-adv: ' before kernel messages */
>     #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>=20

ok, how about adding it to any header file than (which is probably what you=
 were
suggesting in the first place)?


Cheers,


--=20
Antonio Quartulli

--NPukt5Otb9an/u20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXNPCGAAoJEJ4aZjxxc6bKWkEP/3Bbz41uWef+Ou6agw4o74XN
6XLzLPy/XH55uZWKshwm+ZXJB+kLRfZiYUcqd8lJQ22NjqGshJYpJ9s4IP6Iz79B
tpj6wPRR2GTg6sVU683j73lISpgk+M30Eu84lsO6uumyfAv6bfcwmKAQIi8+NDFO
UQdU3BIXAWF1/vCeWY8F/hMv6Q9wKFyEp4wc1w2bqOY6LIPKLHygv6L0+2bQK3yw
TwLRCtGeABIgBDK4NWh4tTuGdNeaLQqJFXRoPdGNimG+hu9wv55OWktfi4o1yPIT
+YaCi17KAWyNtZG/W7XGbQjbmbryDRDHUaPxEMurpZXBeMrrcg4e25KI9vsYdR+q
U7Pux7SblzkHJSW2jeK2VhtmG/NDlH4rD5XN2jZ60wgz3/v0IbeP40wLNIne3AfQ
ZIQsn7mL3gzU6q+fSw4dJibtn2VpkUyb/QAr6SSNO61YLoWIHn1VTULAEtth4/f+
A8WDb7Vc5U6T9JUwNIkT6WuQosByOehfp+/k8TdJwDC/q+Ewm4U2O6nBe4xFwm/C
MOhnc+8hI16EfDAU0YhklQIGXkeZbxsGxZDKzUcMG9yB9l13pzzHuN2J8e0lrIZy
c872iUh6oc/vxxWUv9hqx1EvyCQoGgFzT99yYbRcT//Pdv0DOtz4MYJEAR0XaHTW
QwEB3nihMCS1lgarC6uQ
=rH5p
-----END PGP SIGNATURE-----

--NPukt5Otb9an/u20--
