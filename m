Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 4 Jul 2012 20:30:55 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120704183054.GA12020@pandem0nium>
References: <CAHD-aqKoP3NDSWNHv=vOUCF_ANTRkVWGyXq-v=WC8iRPHJkdhQ@mail.gmail.com>
	<20120704091225.GA10142@pandem0nium>
	<CAHD-aqKo=uzeu6_oc4BXj2WRWObMADyWCHp0sNFn8cJDX8sdjA@mail.gmail.com>
	<CAHD-aqJYXy_Y1vnzHqV6yyrTPAZCHOshGK2HboeYuEzx8i0xNA@mail.gmail.com>
	<20120704140500.GA11212@pandem0nium>
	<CAHD-aqJcFYHCEMh66JaR3a_AbkKmNtAkvZ2s6j8Szd=xmvh8jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <CAHD-aqJcFYHCEMh66JaR3a_AbkKmNtAkvZ2s6j8Szd=xmvh8jg@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] BLAII + gw_mode, DHCP sometimes gets dropped
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry, my fault. Will send a patch based on maint in a minute.

On Wed, Jul 04, 2012 at 03:12:59PM -0300, Guido Iribarren wrote:
> On Wed, Jul 4, 2012 at 11:05 AM, Simon Wunderlich
> <simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> > Hey Guido,
> >
> > thanks again for the good debugging, that really helped
> > to understand the problem :)
> Thanks free software! :D
>=20
> > I've sent a patch, is it possible for you to apply it
> > and retry? it should be enough to update the two
> > gateway nodes.
> Definitely!
> here's the output, tho:
>=20
> Applying ./patches/9999-batman-adv-check-incoming-packet-type-for-bla.pat=
ch
> using plaintext:
> patching file bridge_loop_avoidance.c
> Hunk #1 succeeded at 1351 with fuzz 1 (offset -17 lines).
> Hunk #2 FAILED at 1378.
> Hunk #3 FAILED at 1423.
> 2 out of 3 hunks FAILED -- saving rejects to file bridge_loop_avoidance.c=
=2Erej
> patching file bridge_loop_avoidance.h
> Hunk #1 FAILED at 21.
> Hunk #2 FAILED at 42.
> 2 out of 2 hunks FAILED -- saving rejects to file bridge_loop_avoidance.h=
=2Erej
> patching file soft-interface.c
> Hunk #1 FAILED at 274.
> Hunk #2 FAILED at 323.
> 2 out of 2 hunks FAILED -- saving rejects to file soft-interface.c.rej
> Patch failed!  Please fix
> ./patches/9999-batman-adv-check-incoming-packet-type-for-bla.patch!
>=20
> i'm trying to apply against
> openwrt@torvic:~/trunk/feeds/packages/net/batman-adv$ svn info
> Path: .
> URL: svn://svn.openwrt.org/openwrt/packages/net/batman-adv
> Repository Root: svn://svn.openwrt.org/openwrt
> Repository UUID: 3c298f89-4303-0410-b956-a3cf2f4a3e73
> Revision: 32587
> Node Kind: directory
> Schedule: normal
> Last Changed Author: marek
> Last Changed Rev: 32579
> Last Changed Date: 2012-07-02 13:20:20 -0300 (Mon, 02 Jul 2012)
>=20
>=20
> Visually inspecting the rejects, seems my source code still doesn't
> have the batadv_ prefix in functions names.
> i.e.:
>=20
> int bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb, short vid)
>=20
> I've seen many patches flying around dealing with the batadv_ prefix
> for dave, but didn't pay much attention to them: which of those should
> i grab?
>=20
> Or, Simon, could you kindly send another patch that i can apply
> cleanly to r32587 of
>  svn://svn.openwrt.org/openwrt/packages/net/batman-adv
>=20
> in any case, i see the changes are simple, so i *could* try a manual
> apply of the patch....... but last time i tried (with other patch), it
> got overwritten by openwrt build system.
>=20
> Thanks a lot for the support!
>=20
> Gui
>=20
>=20
>=20
> >
> > Cheers
> >         Simon
> >
> > -----BEGIN PGP SIGNATURE-----
> > Version: GnuPG v1.4.10 (GNU/Linux)
> >
> > iEYEARECAAYFAk/0TYwACgkQrzg/fFk7axbznwCg5oyyF4UaWJBV8GXztFSGG8sa
> > vnAAoJYcgNuCcdA5fZKrIvaUE888FzSI
> > =3Dzd3Q
> > -----END PGP SIGNATURE-----
> >
>=20

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk/0i94ACgkQrzg/fFk7axacJACgrNhvuaORNLdLLTdPOcL/spbb
7W4An2SweTilzTjZOE/jzwSa7aDYk6dT
=oo7x
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
