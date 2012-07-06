Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 6 Jul 2012 10:24:01 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120706082401.GA22432@pandem0nium>
References: <CAHD-aqKoP3NDSWNHv=vOUCF_ANTRkVWGyXq-v=WC8iRPHJkdhQ@mail.gmail.com>
	<20120704091225.GA10142@pandem0nium>
	<CAHD-aqKo=uzeu6_oc4BXj2WRWObMADyWCHp0sNFn8cJDX8sdjA@mail.gmail.com>
	<CAHD-aqJYXy_Y1vnzHqV6yyrTPAZCHOshGK2HboeYuEzx8i0xNA@mail.gmail.com>
	<20120704140500.GA11212@pandem0nium>
	<CAHD-aqJcFYHCEMh66JaR3a_AbkKmNtAkvZ2s6j8Szd=xmvh8jg@mail.gmail.com>
	<20120704183054.GA12020@pandem0nium>
	<CAHD-aqJnPAHYq3992k-Y2pP59R9-LV1G9a7P0-u+aGyNnbpCZg@mail.gmail.com>
	<CAHD-aqJHRmd6RdQOWJQodQoDTUtPOoSm2KqBDpBwnqtRj_65jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <CAHD-aqJHRmd6RdQOWJQodQoDTUtPOoSm2KqBDpBwnqtRj_65jA@mail.gmail.com>
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


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Guido,

thank you very much for testing, it's nice to hear that it works! :)

Cheers,
	Simon
On Thu, Jul 05, 2012 at 04:51:57PM -0300, Guido Iribarren wrote:
> Your patch works flawlessly Simon,
> I sysupgraded f8d11504758 with the patched batman, and DHCP requests
> are back to normal when using gw_mode=3Dclient
>=20
> I patched colmena-casa first, but it didn't make a difference; which
> was expected, since colmena-casa is just a backbone gateway, and it
> doesn't have the actual DHCP server running, as such, it's only job
> was to forward unicast requests to f8d11504758, which was already
> doing fine.
> The problem was that f8d11504758 was dropping the packets, and with
> your patch it doesn't anymore.
> Thanks a lot!
>=20
>=20
> On Wed, Jul 4, 2012 at 3:46 PM, Guido Iribarren
> <guidoiribarren@buenosaireslibre.org> wrote:
> > On Wed, Jul 4, 2012 at 3:30 PM, Simon Wunderlich
> > <simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> >> Sorry, my fault. Will send a patch based on maint in a minute.
> >>
> >
> > Applying ./patches/9999-batman-adv-check-incoming-packet-type-for-bla.p=
atch
> > using plaintext:
> > patching file bridge_loop_avoidance.c
> > patching file bridge_loop_avoidance.h
> > patching file soft-interface.c
> >
> > Now i'm having fun, heh
> > Thanks!
> >
> > Gui
>=20

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk/2oKEACgkQrzg/fFk7axZswQCgxL8vDAGTqS6frdtv0x/6T3s5
7HgAoM8FE+CvqnvanuZWtCiwE5/794WQ
=fJ3j
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
