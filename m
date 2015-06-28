Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Jun 2015 21:21:34 +0800
Message-ID: <5065799.yHsM5BUa9O@voltaire>
In-Reply-To: <20150628035913.GB2398@odroid>
References: <1434893777-17618-1-git-send-email-linus.luessing@c0d3.blue>
 <2472003.5ybaWVxMcq@voltaire> <20150628035913.GB2398@odroid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3254802.vnYeNfCHb1";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/1] batman-adv: Always flood IGMP/MLD
	reports
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart3254802.vnYeNfCHb1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, June 28, 2015 05:59:14 Linus L=FCssing wrote:
> > I am not quite clear on what the patch does. It helps to support a =
feature
> > that is yet to come (upcoming bridge integration) or improves the
> > situation
> > today ?
>=20
> The former. It's not fixing or improving anything for the current
> implementation.

If this patch isn't doing anything (for now) maybe it should be merged =
when it=20
becomes useful ?


> > > +#if IS_ENABLED(CONFIG_IPV6)
> > >=20
> > >  =09case ETH_P_IPV6:
> > >  =09=09return batadv_mcast_forw_mode_check_ipv6(bat_priv, skb,
> > >  =09=09
> > >  =09=09=09=09=09=09=09 is_unsnoopable);
> > >=20
> > > +#endif
> > >=20
> > >  =09default:
> > >  =09=09return -EINVAL;
> > >  =09
> > >  =09}
> >=20
> > This hunk seems not really related to the patch itself ?
>=20
> I think it's necessary for the new ipv6_mc_check_mld() which isn't
> there if building a kernel without any IPv6 support.

You may want to send a separate patch then ? This change seems unrelate=
d to=20
the rest.


> > By removing mcast v1 you effectively are breaking compatibility wit=
h all
> > nodes running v1 and require everyone to upgrade to v2.
>=20
> No, no v1 nodes are required to upgrade. v1 and v2 nodes are still
> able to communicate. v1 nodes (like any pre v1 node) might downgrade =
the
> mesh to a mcast-optimizations-disabled state for now though, yes.

I do understand that 'normal' packet exchange is not affected. However,=
 the=20
TVLVs were introduced with the intend of maintaining best possible=20
compatibility with future versions. With the first tvlv version bump we=
 already=20
require upgrading everyone or compatibility is already broken ? Is ther=
e=20
really nothing we can do ? v2 could at least be compatible to v1 ?


> We cannot safely use the multicast optimizations with bridges if
> there are nodes which do not handle reports properly. The bump
> isn't needed for any packet changes but the internal, local behaviour=

> of a node.
>=20
> I haven't heard of anyone using the multicast optimization feature
> in practice yet (that is, a setup without bridges), so I think it
> is safe to do a version bump?

A version bump for a feature which does not do anything useful yet (see=
 my=20
initial question) ? How likely is it that we will need another version =
bump by=20
the time this feature does become useful ?


> Hm, good question :). Need to recheck, I vaguely remember having
> had issues with the IP header parsing due to unset skb network
> headers.

If it is related to this patch please add a comment. The change is non-=

obvious.

Cheers,
Marek

--nextPart3254802.vnYeNfCHb1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVj/TiAAoJEFNVTo/uthzAwY4IAIJeQ8l957hR9bEwmuZOYPd5
m6U/Cpn1jeIiUoZ2esiGLfHsYlWrtb3ZhN+WuVM7fQVeQP5pBQBd7NQYFTxIJP8F
1IFe9OplfI2makDB5ceC1xo2dTl84T63kytxd2Mfspjvy+69I3eivI1QTmxRJU8d
84uxnPbtscE1ZjqwH8mCWBbC3eTZwiXH9KB2izBNctXLwUQzRISKK++jcLPKfWOl
J82qLYZiL6LuEdLlKTYp6Awnq1Yxmg318iVVtqsuZfAdcWf/faevjvGkRUV/03Jd
47SoIUXYJy+x2GcoSf/EYL7QKry8tX6y8YLdzIQUCQ1m8EdPYXdOlD0iMQvYl70=
=urim
-----END PGP SIGNATURE-----

--nextPart3254802.vnYeNfCHb1--

