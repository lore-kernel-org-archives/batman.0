Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 10 Jun 2010 13:03:36 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7092712.XiOslY5QC4";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006101303.45771.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] batman-adv: Migration from staging to net
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
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart7092712.XiOslY5QC4
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

the batman-adv developers had a smaller discussion what we wanted to achieve
in drivers/staging and if we have done everything we wanted to do. We think
that everything we wanted to do in staging is finished (the TODO file is
empty since a while), but that is just our opinion.

So we wanted to ask you first if you see any showstopper which make batman-adv
insufficient for net before we would ask the net maintainer. Our personal
favorite kernel for the move would be 2.6.37. Before that we would have 2.6.35
(which is not completely correct using the sysfs infrastructure) and at least
some RCs of 2.6.36 (which moves the remaining wrong stuff from sysfs to
debugfs).

Open patches for 2.6.36 are currently (may change)
 * batman-adv: Mark locally used symbols as static (removed some dead code)
 * batman-adv: 32bit sequence number and TTL for broadcasts
 * batman-adv: Add bonding functionality
 * batman-adv: bonding and interface alternating
 * batman-adv: record route for ICMP messages
 * ...

Nearly all of them are features and not really things which makes it more
suitable for the kernel. Open things are for example
 * Re-Integration of some debugging infrastructure (currently not decided
   which technology to use)
 * virtualized meshing (I am not sure if that was the same fancy term the
   actual developer used)
 * forward error correction
 * mesh optimized gateway support
 * protocol optimizations

Again I wouldn't think that one of the mentioned points would make it better
suitable for the kernel (but of course makes batman-adv better in general
terms).

So is there anything you would want us to change before you would say that we
could try a review by the net maintainer?

To the merge process itself. We should prepare a patch which adds everything
in net/batman-adv/ (and Documentation/ABI/testing/, MAINTAINERS) and then send
it to netdev@vger.kernel.org/David S. Miller. After it was merged we just send
you a patch which removes drivers/staging/batman-adv. Is that correct (just
searched for an example and only found benet[1, 2])?

thanks,
	Sven

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=shortlog;h=6b7c5b947c671a96e39f9526a5fd70c178b8dfd1
[2] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=shortlog;h=d0573facf21d1e5cfbc1ddac272b7592722e6c01

--nextPart7092712.XiOslY5QC4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMEMaKAAoJEF2HCgfBJntGOlkP/32YRjUP/TnTCAS0sIIaI0z4
RV1rUsQX2G/gNWYCDKWGwAye3BpkefljCToPI6J8wx1wnh0br/7/RFbVMpSH2YHW
XC3g6S7YmNrySK3laV8cq298QTc4X7+hQCZ8gq9dWTx5f+lZ0lNjgyggshLQE1Kj
JnQyJff6XpUsDmINrXDuyOcRNLmsRq1gDssAez8mIQKkxpy9L/yD1sbdbcr2qElw
46Dx2Yw3Fr+39/2OtMCZHB0H5/z8ESevbCloXhWsJd/SbOianrDW/bG+kvpd8JLh
FMM4o8nSUf7IyKzlLoy45no50NcWiVVfxzqnauxK4HqSGIhuokMxw4FfOUoe1yEP
xApKUwD8qaE3mSAFYR4DNkTbE+OqptjAnb5UVA9OywgBe3NODNPhnp2V2/7RgYPD
yVJqrum0iwzy2E7BPpB2tYWh0z/RUFwk3BQwYSIS4F73gogLKBVQPPIh+I/vkgIG
RXJcHtQOn6JfLNrfS5ccKaqUkUyw3Bj6PlfcKdBncI/hxztczARBuU2jvN1w0/By
QG69RuTgPfTZwR76Rh3SgKQmSADtvgQwMOEuVCkbaUPetucfm4FvuZ7Q1RpKvO2R
IWwdyiUs1fZk/AW3rv1yTbwDwzrONNclArrvKE4LcBS8RxVP5QGwUgVHeCbzQmdO
H/ZQrlUXm06alxBEaUfw
=uEHc
-----END PGP SIGNATURE-----

--nextPart7092712.XiOslY5QC4--
