Return-Path: <ordex@autistici.org>
Date: Thu, 16 May 2013 21:43:36 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130516194336.GJ3350@ritirata.org>
References: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
 <1368293014-30742-4-git-send-email-linus.luessing@web.de>
 <20130511232929.GF901@ritirata.org>
 <20130516182225.GD22374@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rVkomL2febZOZtGQ"
Content-Disposition: inline
In-Reply-To: <20130516182225.GD22374@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Modified forwarding
 behaviour for multicast packets
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


--rVkomL2febZOZtGQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2013 at 08:22:25PM +0200, Linus L=C3=BCssing wrote:
> On Sun, May 12, 2013 at 01:29:29AM +0200, Antonio Quartulli wrote:
> > On Sat, May 11, 2013 at 07:23:27PM +0200, Linus L=C3=BCssing wrote:
> > > With this patch a multicast packet is not always simply flooded anymo=
re,
> > > the bevahiour for the following cases is changed to reduce
> > > unnecessary overhead:
> > >=20
> > > If all nodes within the horizon of a certain node have signalized
> > > multicast listener announcement capability
> > > (BATADV_MCAST_LISTENER_ANNOUNCEMENT) then an IPv6 multicast packet
> > > with a destination of IPv6 link-local scope coming from the upstream
> > > of this node...
> > >=20
> > > * ...is dropped if there is no according multicast listener in the
> > >   translation table.
> > > * ...is forwarded via unicast if there is a single node with interest=
ed
> > >   multicast listeners.
> > >=20
> >=20
> > othwerwise? Does it get flooded like now if there is more than one rece=
iver?
>=20
> Yes, it will get flooded. Thought it was clear because I was
> saying "for the following cases is changed", trying to imply that
> for anything else it'll still get flooded. But ok, I can make it
> more explicit.

Yes, please

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--rVkomL2febZOZtGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRlTboAAoJEADl0hg6qKeOgHYP/iej59IpWAQutOOrnG3CyTwb
ebRMtgnecZQ4HaIyaJA3K5HYFD4bWxxufalppjFYPWGV3SIt6iNKOpCoNMxvHDx8
47awKO3ts0VRW4HGc1yWjizYG2xAnww7Y9nT1uMYTNtqd/kjV7Uz1I3+ny+rL6iu
mCGX/UqWj5qhz/4cIMP8Z6YNGk2xFQGOn8fC1/JqAqWmFB/BXAeq/1QgjIRPs5qG
Q6enD7k4PKzRtEctSAVhpZPIAemFf+hmU3fT/LHdmwQ5G+IeTzWxmmPgPd2rWhEM
5j20HbQvTvoRHcibzwY73M3Gt9ASRHWhukMppWWzgfpz8MGB0mcthRaACWxm//GN
k+gd9b7FTY1nVrEB8Bw/YgEZsdH3AGJP2AErvZdGjJJqIPbbbhohKieYyrdbMiFy
GsGtm2+Ryiy4VeKZcQXQ9BN/NrsbVu2eMbcfAvcL4NqvOpp0NU4eYFsU8DwvbF8O
UHoZrEEpn49maFCrVGb3e6/reKg3wA+6PuMqufDOwcdRI3Yp7JiTudQwzC/CkZst
OxoOhnxUmsh9mdpQYFfxxbE+Qz8J6XN4gOJZXxN0iFE4S6/q74NpXdeaaGMkF0YH
WueB7fKItntj/mu7M8n/ORKjfOpm3OTZ5oy3mBCjknrducRV8foN7w4H5DZFMMiG
DxeEx2UIO5YDTbEumLni
=W6/1
-----END PGP SIGNATURE-----

--rVkomL2febZOZtGQ--
