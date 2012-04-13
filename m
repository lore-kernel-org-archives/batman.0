Return-Path: <ordex@autistici.org>
Date: Fri, 13 Apr 2012 08:22:42 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120413062241.GA14395@ritirata.org>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com>
	<CAKLmikNuMEiG2SN+H8bJkwRXszMayPpn_qDcf1faCjhrow6NdQ@mail.gmail.com>
	<201204130017.31711.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <201204130017.31711.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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
Cc: Jernej Kos <kostko@unimatrix-one.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2012 at 12:17:31AM +0200, Marek Lindner wrote:
> On Thursday, April 12, 2012 19:05:54 Mitar wrote:
> > > In batman-adv you can add/remove interfaces at runtime without proble=
ms
> > > so you doesn't need bridging or similar nasty things
> >=20
> > Great. Can you also say to work on all "tun+" interfaces, so that any
> > interface which starts with "tun" is automatically operated on?
>=20
> No, batman-adv is not a user space daemon with a configuration file, henc=
e you=20
> can't tell batman-adv to wait for tun+. However, you can easily write a s=
imple=20
> shell script for hotplug which adds whatever interface you want to batman=
-adv=20
> as soon as it is created.
> Or, if you are using OpenWrt, you can simply extend the existing hotplug =
shell=20
> script to interprete the "+" as you like.

A little remark here. You MUST use interfaces that support ethernet frames
transmission. Therefore (IIRC) you can use tap interfaces but not tun ones.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPh8YxAAoJEFMQTLzJFOZFywgH/Aw2QyVR6dbwu+EiMEFjLuUp
Id2SdkrOWogXxSQINWKxu6GBdhkix3kCCsRMJjFSclRXopKHc2HgRWsnQMcQ1BXe
FbvVDW84MtsBUVZ/f1WGY/VYHJUIcLStcliIohBrLCM282qSnthOFJW5JjsFpqPj
4oZgKGTaMtKAY+zzrZyhGyjw0XDJVPvNuwtYGpNT44avQq2y5Nhl76wpmCkp/G9L
yb74uTovahrXIeycUPyhsmoAbJKdYi13FhGHiSFOSiEt7TdcAgx4hAB7RidxSU4c
rMAU2m0Y+xuh30UO5tsmqGq6cP/a+tkIJRvSpkDPPUoXXbBMp5+PunA1dWJGI6k=
=nWmC
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
