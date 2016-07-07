Return-Path: <a@unstable.cc>
Date: Thu, 7 Jul 2016 17:24:36 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160707092436.GH5978@prodigo.lan>
References: <1467741697-8811-1-git-send-email-linus.luessing@c0d3.blue>
 <1467741697-8811-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="unl2YYqPcAwXdP9c"
Content-Disposition: inline
In-Reply-To: <1467741697-8811-2-git-send-email-linus.luessing@c0d3.blue>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Snoop DHCPACKs for DAT
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


--unl2YYqPcAwXdP9c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2016 at 08:01:37PM +0200, Linus L=FCssing wrote:
> In a typical mesh network, when a new client connects then it will
> usually first try to grab an IPv4 address via DHCP. Afterwards in
> public mesh networks a client will try to contact the internet over
> the server.
>=20
> While the IPv4 address of the DHCP-Server is usually well propagated
> in the DHT, the IPv4 address of a newly joining client is not.
>=20
> This can lead to a considerable amount of ARP broadcasts not caught
> by DAT from the servers.
>=20
> In a 1000 nodes mesh network (Freifunk Hamburg) we can still see
> 30KBit/s of ARP traffic (equalling about 25% of all layer two
> specific overhead, remaining after some filtering) flooded through
> the mesh. These 30KBit/s are mainly ARP Requests from the
> gateways / DHCP servers.
>=20
> Through snooping DHCPACKs we can actually learn about MAC/IP address
> pairs without the need of any flooded ARP messages in advance. This
> allows servers to fill their local DAT cache with according entries
> before any communciation with a client can possibly have taken place.

Linus,

have you tried applying this patch on one of your servers and measure the l=
ocal
effect? (i.e. if the number of BRD ARP req is reduced or not?)

I think that a DHCP ACK packet should already refresh the local ARP cache (=
or
not?), thus the need for an ARP request should not be triggered by the newly
joined client. (I might be wrong, but that's why I ask measuring the effect)

Cheers,

--=20
Antonio Quartulli

--unl2YYqPcAwXdP9c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXfh/UAAoJEJ4aZjxxc6bK5ooQAISmd4Vv/joKnESn9Ghmc3tb
SrlpDWZIecmC7rn6K/SaMzKXsV5hGvcmcqd4yaJ4+ae2lwLRoTZczWL1RAFQkMug
zhh9ZEr+BHnbBBvdcN1plAlOBQbxdv7gvDrmy+Eo1ZMAv8WWINooTKdE19/zAOQP
mvo8g2590isV0D6cZBcmx/kAJ93sWVfp2E5Z1CU4R5w2r95Xsud90DwGMxgBYtxi
Kl4XXYzg4tQQOvhnc8iR6zbFJZcIDqP88PikBGXeaPQG54Jh+LAWR+qP1ffnLFTV
4Hm9pB1KxPa6UTJd5HxYdVi4bvKOR61VAHgQnaqSEbh596PFXTO/nmzcheAtQ1WV
2gsucGw8EY+Ty5jMTcTT4Acw16fpkyOdqTCFbFe0oOlblejlCaqTR3WosdgyjKXs
Fi0sGPzsNAk0D32emTrtOqoxC2WC23smcJsa9VFM415h21r7stCnt2Bk36p5dxzH
/U2UMyl0U9AtvXHA5cQZ1YckUlsthXJbayJi4CQ8DB73FsKHXIVtwsMLhhgzQwor
vZxRsi0OHWKSLaOoCMeZaTUGudwtlQy2a9UWdFiyPye8PgY+dZOurb3Da5Gz/koZ
DegrSBFIycI5w5+kB5oDSSMvQorsCusI0Fsyuch9//6sgPf29Na4kARMOHdfnR4X
Xfad2qxtAW+pRyLnKSIl
=sKq7
-----END PGP SIGNATURE-----

--unl2YYqPcAwXdP9c--
