Return-Path: <a@unstable.cc>
Date: Fri, 1 Apr 2016 00:01:41 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160331160141.GG5258@prodigo.lan>
References: <56F5AF2F.6060904@t-online.de> <34764958.y3lWsCmXTL@prime>
 <20160330135842.GA19985@r2d2.s.lihas.de> <3605600.IEJkB4EzUh@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="InRyi6yyXSYzKD4c"
Content-Disposition: inline
In-Reply-To: <3605600.IEJkB4EzUh@prime>
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


--InRyi6yyXSYzKD4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2016 at 02:11:19PM +0200, Simon Wunderlich wrote:
> I thought a little more on automation, but I'm now at a point to agree th=
at=20
> there is no good way to do it - at least I'm out of ideas. If anyone else=
 has=20
> some ideas, please speak up NOW. :)

Some time ago we had a proposal (by Linus I believe) which was about detect=
ing
transitive interfaces by exchanging neighbour tables between peers. This wa=
y a
node can understand if every other node behind an interface can talk to each
other or not.

Although this approach sounds more complex, it would also help optimizing t=
he wifi
case: a node can understand if the hosts in an adhoc cells can all talk to =
each
other and then avoid the retransmission (thus saving previous airtime - as =
we
would save bandwidth in a VPN).

The only problem is that this would work only after extending BATMAN V and =
would
unlikely be implemented in BATMAN IV.

Not sure if Linus (?) or anybody else is willing to work on this....but I g=
uess
people would like a solution to be used on BATMAN IV ? Or is this an option=
 ?


Cheers,


--=20
Antonio Quartulli

--InRyi6yyXSYzKD4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/UnlAAoJENpFlCjNi1MRCZIP/2F+/NYheZcKs65jU6AZ+EIb
O5QdjJuVWz5yh09mt3rcoFnq74f8pFWrDgBpoSIEiiCVqQ4qePNQGWKVCVzIjRgF
pghxLuOO82Rru5m1us6gn4n1222z4hEda8CLMCfUbDhaEV1cKYWcFmcjyGgjBTba
Yiky1g8upf6jFTIYqo0notWxmx+GIctgoIO5ucAsX0j9eX0EzuqWMs2or/dOBDrA
aghrBskpDWW++m7YVi/CWSlpHYJIDwzJBxK1/UgObXAtYWdsIOasJVlb0BMDj6ju
WA46pLSllC6AzH+7MeS/nkSKUc5udV2FQ06L0Vf70fH+rfAZbIOGgGtbEKmOm4sw
4pUj1k2CI34fRBCNeMB+oqG13cmF1CeuhKWJeHoPJ9zBDyqfQkZEVOw/EZrwn1B0
AXVI4pb7LjHpR1juEe4sXcw+Lmgd5KfEgFFGThCAWtyTKxfexOXX210Hqd6QU7Q0
x9Y1BXwQIjBSzaNy/4yu3AG/+sbYa77PE0jzcf/mme37llKAQuaUGk3+6xsfg5i0
5lKub8a/wTWGW4WXNGL/jrU3mnie03EpIx3wd6c2bdG0c/jL5LbyBo5PPK3AnRXY
4fHQcDc2iJobXxREi3FALYY5BCGZA0svxRXLVz/tcUapI12rfHtqitrq25C2ca7z
rty7p11kLD1ErKsNG8qv
=IVhG
-----END PGP SIGNATURE-----

--InRyi6yyXSYzKD4c--
