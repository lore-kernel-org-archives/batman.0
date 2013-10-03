Return-Path: <antonio@meshcoding.com>
Date: Thu, 3 Oct 2013 11:00:56 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131003090056.GD1939@neomailbox.net>
References: <20131001202648.GT11097@lunn.ch>
 <20131002130548.GA24077@pandem0nium>
 <20131002160106.GA1939@neomailbox.net>
 <524D0A04.4090702@hundeboll.net> <20131003081124.GA20056@lunn.ch>
 <20131003082221.GC1939@neomailbox.net>
 <20131003085316.GB20056@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
In-Reply-To: <20131003085316.GB20056@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] Alfred batadv-vis json conformance
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
Cc: Janne Paatero <janne.paatero@ruag.com>


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2013 at 10:53:16AM +0200, Andrew Lunn wrote:
> > > But how do we determine the algorithm version? For the moment it can
> > > simply be hard coded. But for version 5? Will the over-alfred format
> > > change? Will we have a "struct vis_v2" and VIS_PACKETVERSION_2 for
> > > algorithm 5?
> >=20
> > Good question. Maybe we don't really need to export the algorithm versi=
on?
> >=20
> > In the end this information can be retrieved on the _same_ node where a=
lfred (&
> > vis) is running by reading the "routing_algo" (sysfs-)file.
>=20
> No, that does not work. You can run alfred on a machine without
> BATMAN. alfred --help says:
>=20
> server mode options:
>   -i, --interface             specify the interface to listen on
>   -b                          specify the batman-adv interface configured=
 on the system (default: bat0)
>                               use 'none' to disable the batman-adv based =
best server selection
>=20
> I'm using this "-i eth0 -b none" since my network topology has the
> logger on a machine which is bridged into the mesh.=20

Oh ok, I didn't think about this case.

>=20
> > What about the source version? How did you get it from the module?
>=20
> It is the alfred version, not the kernel module version.
>=20

Ok (but I don't see how it can be useful)


Thanks!


--=20
Antonio Quartulli

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSTTJIAAoJEADl0hg6qKeO3xQQALG76unw8ppJnWSXcyg41339
zAbp8VD0XVO8nFfAuqxzifcCff2o2jTJ2hxvr++PcO2Qjfuc6hMEXyT6zfN/CDmF
Widxj9PnO729OM1Zpyq9jU0ArWpJAmPJ5TYYR2ZfSs+vFQJhwDKtnbopWvA0R/u+
Tv/vFfoXftjjtU/q7XzsSIZohmNxJHy35+8vEdFST0PgdZKIbNWGHpVJo96kMpl8
QOX8JVF/4oSdSbSmd8L+mizQ7jw4R1R3EZt8r7z9Wqa/a4TIGcV5GqQ8NiVkfjmZ
mfy2asLYTAVqLxuGhw7Od2LZsf4hhL0+4VjsasWWlIcNtRSHZWnGZpVe1wlWPrVR
69q8nCBC5gtne9MP4Ri3lF+MsMYjCm9llkBT/cP091PNj5KKG4Qvxs7Jjmt3IEOn
nho9z1+HzZ+HpLUWxl1NCg/9ur8mOUhDafeG8WLlIIZeekuB4WLKI9Cwu9MzVu23
EYy1uAmBzLHOcdWoBOYOLKKNk3kPWJOTZXFyRq+7M/nMDFtr+EFKl5Y3flh9jvYx
MOU8z1d4J7i7lTGJeOwvw5/b0BI2b59/vbQbC0N9gQc/spE77CiXQ/EgbSdqXWTu
8KcBD1TkdTWIg/M4nNyzSlIDRZZB/8FKxqinQXM2U4GpSPCrsSmjdveV27+8XbmD
FDalJCv+eXDy9dA1WmUD
=avtS
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
