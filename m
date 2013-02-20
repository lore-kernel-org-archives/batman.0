Return-Path: <ordex@autistici.org>
Date: Wed, 20 Feb 2013 15:27:27 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130220142727.GO3523@ritirata.org>
References: <1361112184-9927-1-git-send-email-ordex@autistici.org>
 <20130218234904.GA24241@pandem0nium>
 <201302190908.44891.lindner_marek@yahoo.de>
 <20130219214340.GA29174@pandem0nium>
 <20130220132625.GL3523@ritirata.org>
 <20130220141413.GA1058@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O3WNCzIuUImKerqE"
Content-Disposition: inline
In-Reply-To: <20130220141413.GA1058@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat support for the
 new netlink ops
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


--O3WNCzIuUImKerqE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2013 at 03:14:13PM +0100, Simon Wunderlich wrote:
> On Wed, Feb 20, 2013 at 02:26:25PM +0100, Antonio Quartulli wrote:
> > Hi Simon,
> >=20
> > >=20
> > > > ip link set dev $iface master bat0
> > >=20
> > > This doesn't work. eth0 is not added to batman. To further test, I've=
 added
> > > it via batctl.
> >=20
> > I'm not sure..but I think this does not work because the "set master" c=
ommand
> > does not use ioctl, but rtnl only. Since in this kernel we don't have r=
tnl for
> > these operations (this is why we have this hacky patch) I did not expec=
t this
> > command to work.
>=20
> OK
>=20
> > > >=20
> > > > Even more interesting are combinations of those:
> > > > * batctl if add $iface && some OGMS here && ip link set dev $iface =
nomaster &&=20
> > > > ip link del dev bat0
> > > > * ip link add dev bat0 type batadv && ip link set dev $iface master=
 bat0 &&=20
> > > > some OGMS here && batctl if del $iface
> > >=20
> > > Some of these combinations are tested above, but I'd suggest we shoul=
d fix the
> > > general case first. :)
> >=20
> > what would you like to fix? :) We have just implemented a feature and n=
ow we
> > don't have any userspace tool which can exploit it! :-D
>=20
> Well, if we don't expect this command to work then it's fine.

I just double-checked. iplink handles the master subcommand by sending a rt=
nl
request with the IFLA_MASTER flasg set, nothing else. Unluckily, this flag =
is
not supported in 2.6.32.

>=20
> Personally I don't care as long as batctl works. :)

yeah, that's the important point. And batman-adv is still working with this
patch.

>=20
> If there are any other things to test, please let me know.
>=20

Nothing on my side.
Thanks again :)

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--O3WNCzIuUImKerqE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRJN1PAAoJEADl0hg6qKeODssQAMVXxVoepngKa+G8dyQvGlcY
/hiRu2G4sqBrI5spxWPUOmLibE2O0ThJagFWA71dpsGLCI3WloizUXu7E78qM59Z
5hAXo9NriXHoB/9EsYXPdkl+ml8EFLi2P7Nr6meMCck5OPEkEdAvoh0fUmOgGjJz
leFWhjiDE6mn5wDBW5rk7DSPYfTjnFx+zcAJJIcOgwGEVdGR/GrANviFMX3ZtZBu
j/KXOVDDJiXyshzYz5x4Unz59UVEoYrcMEv2BWXgke2YzKnlAfGIT05w3zA47h1M
+5SAPPRPUFr3sD8P6lPJCryH8fzFPR7VYSmxOn/acOvzRiW0ynpA/IhGhdgajN/F
0iVsy3HKV+no+lU27jFxUzyUCBHf+B2xxRE2UAHHK4eN82ufYVHy0o6KmF8dsd6z
KSG2pxYToIQcBPmzHRASvc+PDnTInmBcdDbjnZBAbJI3sTFgwWiiSh3J4N3BqF8H
ErR/iIFHn6VIrKik5MkSbNvjRoWTLKu/o3d9A+zrLNdJ4vZvXzreV0rfYAYbP1mf
dGOdNvWZJkGF27elKkRInIjZlqM7zj9cRELp7ptxNqNVCB90QQI/zcuxf3xtk6IC
X7fWvHhf4+tU4AZMst/ar8vPkUZGszvuO6ul6nwCQtINXFr+Jz13ujY3M/Azw8bs
7PxoMvCX48xYIoEqiKQY
=Lkoz
-----END PGP SIGNATURE-----

--O3WNCzIuUImKerqE--
