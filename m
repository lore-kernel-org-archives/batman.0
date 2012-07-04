Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 4 Jul 2012 11:12:25 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120704091225.GA10142@pandem0nium>
References: <CAHD-aqKoP3NDSWNHv=vOUCF_ANTRkVWGyXq-v=WC8iRPHJkdhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <CAHD-aqKoP3NDSWNHv=vOUCF_ANTRkVWGyXq-v=WC8iRPHJkdhQ@mail.gmail.com>
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


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Guido,

On Tue, Jul 03, 2012 at 05:07:17PM -0300, Guido Iribarren wrote:
> Hello there again,
> I have observed a problem since updating to 2012.2 and enabled BLAII
>=20
> I'm compiling logs to understand what's happening, but as always,
> reading logs only gets me more lost :(
> So here i am again begging for help

There are some debug levels for BLA as well, and you can now get the
claimlist with batctl (which is basically the list of clients a gateway
feels responsible for) - this may help for debugging. But first,
we should clarify some more details for your setup.

>=20
> the setup is the same I described in yesterday's attachment, but
> what's not pictured is an ethernet cable between colmena-casa and
> f8d11504758.
> f8d11504758 is the only router that connects to the internet (through
> WAN cable), and it's also the only one that has dnsmasq running and
> gw_mode=3Dserver.
> All the other nodes have gw_mode=3Dclient
>=20
> All of the nodes have bridge_loop_avoidance=3D1
> (even though there are no other utp connections, so it could in fact
> be enabled only on colmena-casa and f8d11504758)
>=20
> with this setup, dhcp requests from the mesh sometimes get "lost",
> either they don't reach f8d11504758 or the reply doesn't get out

Questions:
 * which node runs the DHCP server? colmena-casa, f8d11504758 or something =
else?
 * at which point is DHCP getting lost? is the DISCOVER/REQUEST from the cl=
ient
   getting lost, or the reply from the server?
 * Can you specify "sometimes" a little bit more? What are the circumstance=
s, how
   often does it happen?

>=20
> this didn't happen with batman 2012.1 , setup as indicated by the BLAI
> wiki page (batctl if add br-lan)
> furthermore, with batman 2012.2 , BLAII activated, but gw_mode=3Doff in
> all nodes, DHCP also works fine.

Mhm, that's rather strange ... we had a similar problem when ap isolation
was activated. Do you have this feature turned on?

So DHCP is only having problems when gw-mode is turned on colmena-casa
and f8d11504758?

>=20
> So, a few questions arise:
> is it a problem to activate bridge_loop_avoidance=3D1 in all nodes,
> regardless of the fact that they "need" it or not? (that is, it is
> activated on nodes that don't have any ethernet cables connected and
> couldn't possibly create a bridge loop)

No, that it is not a problem - you can activate it everywhere. It will
just send some additional control packets on bat0, but won't do anything
as long as it does not detect other gateways.

>=20
> would it make a difference, if I add br-lan to bat0 (batctl if add
> br-lan) the way I used to do with batman 2012.1 ?

That won't help, because the design of BLA changed and the old BLA has been
removed. Please keep the bridge out of bat0. :)

Cheers,
	Simon

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk/0CPkACgkQrzg/fFk7axaJuwCfaZ6nn7ufwSDRkkbxtgQO5QXu
x1UAniPjp+i5dobFFCQK6Id6MK3M9mVm
=yEO3
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
