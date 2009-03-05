Date: Thu, 5 Mar 2009 14:58:32 +0100
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20090305135831.GA1563@WGT634U>
References: <200903032126.57456.pmazart@web.de>
	<200903051155.16975.pmazart@web.de>
	<200903051914.02114.lindner_marek@yahoo.de>
	<200903051422.15547.pmazart@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <200903051422.15547.pmazart@web.de>
Subject: Re: [B.A.T.M.A.N.] Hiding Local Topology ??? TTL
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2009 at 02:22:15PM +0100, P. Mazart wrote:
> Am Donnerstag, 5. M=C3=A4rz 2009 schrieb Marek Lindner:
> > This paper just mentions the possibilities - not all flavors
> > implement that feature. As far as I know bmx (batman-experimental)
> > supports it though.
>=20
> Now I'm completely stuck with BM's brands. :-)
Please read http://open-mesh.net/wiki/BranchesExplained to understand basic
differences between the "brands". B.A.T.M.A.N.-adv has completely different
ideas about what to route. It is not meant as drop-in replacement and not
for any performance reasons.=20

> Can you say something about overhead and performance of BM in=20
> kernelspace compared to the udp-userspace deamon?
> And devel-status of each of them?
You can only compare batman-adv-kernelland and batman-adv-userspace
performance wise. Userspace has some performance problems and was meant to
test the concept of routing ethernet frames instead of creating routing
tables for ip routing.
B.A.T.M.A.N. (aka batmand) has no kernel space implementation, but a
supporting kernel module for it's gateway functionality. It should help
the gateway node to reduce the performance bottle neck by not copying all
data from kernelland to userspace.

If you would really compare batman-adv-kernelland and batmand then please
ask again - I don't have any good numbers here, but maybe somebody else
has.

If you really want to test batman-adv-kernelland then please use the
last stable release from=20
 http://downloads.open-mesh.net/batman/stable/sources/batman-adv-kernelland/
and not the current version from svn. New experimental features were added
there recently and it is not in a stabilising phase at the moment.

> > [=E2=80=A6] The packets sent to the vis server are UDP packets [=E2=80=
=A6]
>=20
> Ahh. Great. Thank's for the information.
If you want to check the amount of time between two vis packets:
 http://open-mesh.net/browser/trunk/batman/batman.c?annotate=3Dblame&rev=3D=
1235#L1232
It is around 10000ms at the moment in batmand, but as Marek said it depends
on the implementation.

Best regards,
	Sven

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmv2oUACgkQqQGwKVlMoDs2wgCdE8emy3Xxi9LEzciWwACJVktz
XtYAn2HU7C31VUajySqTA3cmJw3n1f23
=8pDC
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
