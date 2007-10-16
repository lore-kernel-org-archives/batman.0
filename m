Date: Tue, 16 Oct 2007 12:52:53 -0600
From: Jan Hetges <tran@ms20.net>
Subject: Re: [B.A.T.M.A.N.] batmand_0.3-beta-rv724 segmentation fault
Message-ID: <20071016185253.GA7250@apoderado.ometepe.net>
References: <20071016020242.GA4608@apoderado.ometepe.net>
	<200710161513.52445.lindner_marek@yahoo.de>
	<20071016172552.GA6324@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20071016172552.GA6324@apoderado.ometepe.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2007 at 11:25:52AM -0600, Jan Hetges wrote:
> On Tue, Oct 16, 2007 at 03:13:52PM +0200, Marek Lindner wrote:
>=20
> > > i just tried both and batmand_0.3-beta-rv674 gives a segmenation
> > > fault and
> > are you sure it segfaults or is it simply not running ? Please
> yes, at least it said "Segmentation fault"
> > > batmand_0.2-rv502 doesn't start (probably segfault as well).
> this one is simply not running
>=20
> so i installed
> http://downloads.open-mesh.net/batman/development/misc/batmand_0.3-beta-r=
v724_mipsel-wr-elf-32-lsb-dynamic-unstripped.tgz
> md5sum /tmp/batmand_0.3-beta-rv724_mipsel-wr-elf-32-lsb-dynamic
> 955cc1f203c4ad47fea84427b7b7c5c4
> /tmp/batmand_0.3-beta-rv724_mipsel-wr-elf-32-lsb-dynamic
>=20

the safe way to reproduce this:
flash openwrt-g-freifunk-1.6.9-es.bin to a wrt54g=20
then put scr lui http;//freifunk.schmudde.com/ipkg into /etc/ipkg.conf
ipkg update
ipkg install freifunk-batman freifunk-recommended-es
install http://downloads.open-mesh.net/batman/development/misc/batmand_0.3-=
beta-rv724_mipsel-wr-elf-32-lsb-dynamic-unstripped.tgz
without rebooting!
i insmod /lib/modules/.../tun.o and tried again... still segfaults
after rebooting the box no more segfault!

cheers

  --Jan


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHFQiFlTtvZdk47D4RAhCzAJ4gZ+4TTaUc/lX08m3bUU2cwESZfACeLa/e
eyeBbuAdzCbRSN8ccPhn0yU=
=lD8H
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
