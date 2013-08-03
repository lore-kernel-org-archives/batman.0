Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 3 Aug 2013 23:19:07 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130803211907.GG12891@pandem0nium>
References: <1375303667-3018-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Content-Disposition: inline
In-Reply-To: <1375303667-3018-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 00/10] Improving the routing protocol
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Antonio Quartulli <ordex@autistici.org>


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2013 at 10:47:37PM +0200, Antonio Quartulli wrote:
>=20
> Hello list,
>=20
> with this RFC I'd like to introduce some new routing API functions meant =
to
> improve the routing protocol abstraction.
>=20
> This changes have been written while developing batman V. The latter help=
ed me
> in understanding what batman iv and v have in common and what not.
>=20
> The main problem was the metric: the two protocols use different metric d=
omains
> and different semantics.
> Therefore all the functions handling/printing the metric needed to be
> generalised and rearranged to let the protocols decide what to do.
>=20
> Another issue was the way routing protocols handle the orig and neigh node
> structures. Also these two have been changed and some small APIs have been
> provided as well.
>=20
> Moreover, after Simon's RFC about the new multi-interface optimisation, w=
e saw
> the need for a better abstraction so that mechanisms like that could easi=
ly be
> re-used by new algorithms (like batman v) with little effort.
>=20
>=20
> This is the second version of this RFC where I introduced some changes to=
 the
> names of some functions and some other minor changes discussed in the pre=
vious
> RFC thread.
>=20
>=20
> The new API functions are the following:
> + metric related:
>         - bat_metric_get
>         - bat_metric_is_similar

copy + paste?! :P

>         - bat_metric_compare
>=20
> + orig_node related:
>         - bat_orig_print: print the originator table
>         - bat_orig_add_if
>         - bat_orig_del_if
>         - bat_orig_free
>=20
> Any feedback will surely be welcome :-)
>=20

Looks pretty good to me, see a few questions inline of the patches for deta=
il. I'd
love to see the real patches soon. :)

Cheers,
	Simon

--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlH9c8sACgkQrzg/fFk7axbkiQCfd5nxCIWHv4FQzEFhjcyH/FOo
f3YAmQEMrHf2UoZMsyvIR97UPKX6pVXl
=BeI7
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--
