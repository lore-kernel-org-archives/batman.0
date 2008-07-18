Date: Fri, 18 Jul 2008 12:06:34 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] batman and Kernel 2.6.26-rc8&rc9
Message-ID: <20080718100634.GA24818@hrz.tu-chemnitz.de>
References: <1216040292.12178.3.camel@mkellyDell>
	<20080714154944.GA16555@hrz.tu-chemnitz.de>
	<1216345707.2919.1.camel@mkellyDell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <1216345707.2919.1.camel@mkellyDell>
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


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Mark,

the lines of your error messages seem to be wrong. As Sven pointed out,
your SVN checkout might be broken. Please check your gateway.c file
against the latest trunk:
https://dev.open-mesh.net/svn/batman/trunk/batman/linux/modules/gateway.c
and see if it is matching. There is no code about class_device_* on line
93 and 118 in the latest file. The module compiles fine against linux 2.6.26
final on my system...

regards
	Simon

On Thu, Jul 17, 2008 at 09:48:27PM -0400, Mark Kelly wrote:
> Hey Simon,
>=20
> I just got around to trying this again on 2.6.26 final and I'm still
> getting a fail error on the gateway module, and I've tried it using
> r1099 and r1100 under openwrt on an ixp4xx board.
>=20
> make[3]: Entering directory
> `/opt/openwrt/k1/build_dir/linux-ixp4xx_generic/linux-2.6.26'
>   CC
> [M]  /opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gatew=
ay.o
> /opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.c:=
 In function 'init_module':
> /opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.c:=
93: error: implicit declaration of function 'class_device_create'
> /opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.c:=
 In function 'cleanup_module':
> /opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.c:=
118: error: implicit declaration of function 'class_device_destroy'
> make[4]: ***
> [/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules/gateway.o=
] Error 1
> make[3]: ***
> [_module_/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/linux/modules]
> Error 2
> make[3]: Leaving directory
> `/opt/openwrt/k1/build_dir/linux-ixp4xx_generic/linux-2.6.26'
> make[2]: *** [/opt/openwrt/k1/build_dir/armeb/batman-0.3-r1100/.built]
> Error 2
> make[2]: Leaving directory `/opt/openwrt/packages/net/batman'
> make[1]: *** [package/batman/compile] Error 2
> make[1]: Leaving directory `/opt/openwrt/k1'
> make: *** [package/batman-compile] Error 2
>=20
>=20
>=20
> On Mon, 2008-07-14 at 17:49 +0200, Simon Wunderlich wrote:
>=20
> > Hello Mark,
> >=20
> > thanks for the report. The issue should be fixed with revision 1099.
> >=20
> > regards
> > 	Simon
> >=20
> > On Mon, Jul 14, 2008 at 08:58:11AM -0400, Mark Kelly wrote:
> > > The batman layer3 kernel module does not appear to compile on the
> > > 2.6.26-rc8 & rc9 kernels.  Is this a known bug?
> > >=20
> > >=20
> >=20
> > > _______________________________________________
> > > B.A.T.M.A.N mailing list
> > > B.A.T.M.A.N@open-mesh.net
> > > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> >=20
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIgGsqrzg/fFk7axYRAvx/AKDdeua0KjgE1Aj136NnBNDK4CQPAQCfbGDE
EwFhIitwIWDTOhOzEKQAg98=
=0ruu
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
