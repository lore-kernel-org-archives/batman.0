Return-Path: <a@unstable.cc>
Date: Thu, 31 Mar 2016 23:54:56 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160331155456.GF5258@prodigo.lan>
References: <56F5AF2F.6060904@t-online.de>
 <20160330135842.GA19985@r2d2.s.lihas.de> <3605600.IEJkB4EzUh@prime>
 <72973422.6kzv4PKiip@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3r2sERxeG5twY2zu"
Content-Disposition: inline
In-Reply-To: <72973422.6kzv4PKiip@prime>
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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


--3r2sERxeG5twY2zu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2016 at 02:21:03PM +0200, Simon Wunderlich wrote:
> Some additions below:
>=20
> On Thursday 31 March 2016 14:11:19 Simon Wunderlich wrote:
> >=20
> > So let us consider the other two options:
> >=20
> > 1.) sysfs flags (as in Linus original patch, or similar):
> >=20
> >  + can be integrated fast
>=20
> One more comment here, fast means that we can integrate it fast in batman=
-adv,=20
> which will help if you use the external module. It will still take some t=
ime=20
> to dripple into distribution kernels just as Debian. However, compiling t=
he=20
> external batman-adv module is easier than upgrading to have netdev flag .=
=2E.

Same as you compile an external module, you could also apply a single patch=
 to
the openwrt kernel I think. I don't really see why this method would be
"faster".

The single patch could also be adopted by OpenWrt without waiting for the n=
ew
kernel.


Cheers,

--=20
Antonio Quartulli

--3r2sERxeG5twY2zu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/UhQAAoJENpFlCjNi1MRMdkP/isvfkh9byzz6DBGyBs1yPZK
2Q1TKSGDKM8rzwWe0IRuL0zZhPd4VTcRZvwNu3ziAYbMyxWRid5asYxGuteAKMMH
vACCLgRABtxrRugjq7xYA229K3y4UKckKA6anivTeTi/4qpTKRVYye5gsaPPPyMu
C+9uwdmRPmwDjrIOiYT5c9/6RxRTEC8m7oD6YUnB8SbkQC4WAZVsdUur+9QnoeJd
JPADO2pspyr1nKMpcFkgIVb2ggHfKdEiFENIzwmiQn3CkFSFddtSF2k1qwKusmoZ
x79GLUzl9/R1fcw4Vp3RCLeusB8CKZM22Jqjv/rnGIOwilaouetEnnrYxXlOMSsm
IPIaqnILgqzyJmlumOaw9ixSpmAoBxrkoN2nK5HU8/J/0e6IPWIgHUTxj8vfIRVP
dZ7fbyGlBl8Fh30RiNcabcEvhAVpIiRXiNCiUAZHlU0kv7VGlfrCq94ZEUanL2za
9BiPAyyME8bGlGg4+hFkTdHaMO8AAiSc2qf37Ii8gmQ1gR3uA3vVLaTtWDJX8u4j
0quqjuiXcFzBkppwASUfup4I7tJtEwnJVtUPOGtg377sBNArruGwY5tCAru4zSMD
BWGiZmZg9/2uzL1xoUAQQLdBJxnaikvnc+omgXG6BAbKbqeEZNpYg2ICq4NzStBn
lPWOitbQCjPjLHHR3s11
=Hul6
-----END PGP SIGNATURE-----

--3r2sERxeG5twY2zu--
