Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 04 Aug 2016 07:56:44 +0200
Message-ID: <1877539.fInDOEgoYM@bentobox>
In-Reply-To: <20160803234329.GD16866@otheros>
References: <1470083926-6409-1-git-send-email-linus.luessing@c0d3.blue>
 <20160803212552.GB16866@otheros> <20160803234329.GD16866@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13745587.lrvnIAUjU6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Simple (re)broadcast
	avoidance
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart13745587.lrvnIAUjU6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 4. August 2016 01:43:29 CEST Linus L=FCssing wrote:
> On Wed, Aug 03, 2016 at 11:25:53PM +0200, Linus L=FCssing wrote:
> > On Wed, Aug 03, 2016 at 09:59:27PM +0200, Sven Eckelmann wrote:
> > > Isn't this causing the reference counting cycle (aka really, really,
> > > really bad):
> >=20
> > Hm, I see what you are getting at. Could indeed be a nasty bug...
> >=20
> > But, actually, just tested in VMs, seems like I'm getting a call to
> > batadv_hardif_neigh_release() just fine. Which means it counted to
> > zero successfully o_O?
> >=20
> > I don't understand why it seems to work right now :D. Will dig deeper.
>=20
> Ok, I think it just works because hardif_neigh_create()
> intializes the nodes refcount to one (in contrast to other allocating
> functions which initialize to 2). In the end, once
> neigh_node_create() finishes, it stays at one.
>=20
> So the regular purging routines will break the cycle in the end
> when they reduce the refcount of the hardif_neigh_node to zero.

Ok, looks like the neigh_list edge in my graph is incorrectly there. But wh=
at=20
about last_bonding_candidate? This definitely has a reference counter (and=
=20
needs it) and thus your code would cause problems when bonding is enabled.

Kind regards,
	Sven
--nextPart13745587.lrvnIAUjU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXotkcAAoJEF2HCgfBJntGZ8cP/1MIa8PeN8YOQ4+HcFBqsDTk
LWngZIgq147DILJQ3/C6e0e1ppOCWB0zkeryNgwBx1d+2HGnYVU7Wc9dOiSWqW2U
dpT2QkMBoZGTK3bKSrW00gc7xH30j84n+9C10XVHb2ALige86RzeNW47xKf1aVjg
7kSs8MYrlxv0KaTrk6h+ooOt9WlQY124bXgfh8AJwPU+oApvDnLFIzdN+niqxRSs
9Dd1adt0MGIW33lB5nbQr0sm63Et10NOMuatB7Gp60/hPoCBCMZ1iK0EhDXY2mPI
v7PWm8TEopt/rT5SBfNa3VjyKwau2CZ12Wy4QmyyDCx5vX6nNMEoZCfKtNIT0OEh
HxSxuRi1hAJ7W8VhVWWu+94/5m1HpyKHi671bL4VHQNiidXJaFQBPPMK9IUh5e63
4sCiiFijz8A5SH4RYhO/urD1Ry7LrL1Nk7Q6h4OwOfk/Hc8wE5F13/GCHA3S9r72
tKBvWgFqcs2wwnNGppQUHMMAyKmyyunNlIUqqny0ixahzNqX2IXfg0Wj2VTfo+bC
/BNXi8wo53bZdaUu3oX/r4xlJ3G/KeAOcB1amdoaY4/7voo1wH/3T459yYAjyl/P
i+jqHWHLNSZnZ2ikq/h519qnBLhWSNOwdBdnOCbVK3W5yM6Ded32tSWTKqQxApkn
P6dfrUM5Pl6MxDk7hXc7
=z60K
-----END PGP SIGNATURE-----

--nextPart13745587.lrvnIAUjU6--

