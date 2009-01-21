From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 21 Jan 2009 14:36:03 +0100
References: <278AF6CA06F13D4C9E9F69C7B9AB3B8303504611@MBX21.stu.nus.edu.sg>
In-Reply-To: <278AF6CA06F13D4C9E9F69C7B9AB3B8303504611@MBX21.stu.nus.edu.sg>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8626971.loDSc1iBOc";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200901211436.08998.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Install Batman
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

--nextPart8626971.loDSc1iBOc
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
On Wednesday 21 January 2009 13:54:44 Kartik Muralidharan wrote:
> I have a couple of embedded
> devices (x86) running the latest version of OpenWRT. I would like to know
> if I could compile and run batman on these nodes and if so how.
There is a howto written by Wesley at
 http://downloads.open-mesh.net/batman/misc/batmand_howto.pdf

This should describe the process of building and the first steps quite good=
=2E=20
You can compile the batmand binary by using a gcc with i386 as target=20
plattform. This should be the case for every standard gcc on non-amd64 i368=
=20
distributions. Afterwards you can copy it to your embedded device and use i=
t.
I am not up to date with the current development in trunk of openwrt but I=
=20
think they don't provide packages for gcc yet. So it will not be possible=20
(unless you installed gcc by hand) to compile it on your device running=20
openwrt.
This is the really quick and dirty method but you can also create ipkgs wit=
h=20
the standard openwrt build environment with the build scripts from=20
https://svn.openwrt.org/openwrt/packages/net/batman/

I would recommend that you use a current snapshot of the batman sources fro=
m=20
trunk because they contain a bunch of fixes since the last release (0.3). Y=
ou=20
can obtain them by running
 svn export http://downloads.open-mesh.net/svn/batman/trunk/batman/

Best regards,
	Sven

--nextPart8626971.loDSc1iBOc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl3JMQACgkQqQGwKVlMoDvC1gCdEoV+SI5LbOvrNOesDBHnV0vl
i5QAmQHXBGQEDW4pJ5LuEitbPNCfsCHj
=M1Dt
-----END PGP SIGNATURE-----

--nextPart8626971.loDSc1iBOc--
