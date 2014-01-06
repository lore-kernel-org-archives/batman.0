Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 06 Jan 2014 20:35:33 +0100
Message-ID: <6312194.LhI8hzXjyH@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1787463.F1IfJGiYFW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH 0/3] batctl: Use libnl(-tiny) for netlink
	communication
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>


--nextPart1787463.F1IfJGiYFW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

the current release 2014.0.0 made some problems for me because Debian the new 
function "rtnl_open" conflicted with libnl-3.0. libnl-3.0 was used in the 
Debian package to follow the Debian policy chapter 4 about duplicated code.

Using libnl should not be a problem for any linux system because everyone uses 
it when wireless configuration is done. For example libnl-tiny is already used 
by the normal OpenWrt system in base system packages:

 * netifd
 * swconfig
 * authsae
 * hostapd
 * iproute2
 * iw
 * iwinfo

So it is nearly impossible to not have installed ;)

An additional benefit is the already tested code, better type checks and more 
linear code instead of lot of loops to parse the data.

The Makefile is written in such a way that it:

 * tries to find pkg-config (can be overwritten by setting PKG_CONFIG as
    environment variable/make parameter)
 * tries to find the libnl CFLAGS + LDLIBS (can be avoided by setting
    LIBNL_CFLAGS/LIBNL_LDLIBS as environment variable/make parameter)
 ** the search for the CFLAGS + LDLIBS is done using pkg-config using the
    library name libnl-3.0 (this can be changed by setting LIBNL_NAME
    as environment variable/make parameter)

Kind regards,
	Sven
--nextPart1787463.F1IfJGiYFW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCgAGBQJSywWFAAoJEF2HCgfBJntGAhcP/36ZBo0Db6Vo4rJfGbayew2S
nvZTbq7cyCF0ThQzSAnWyYS+aFejhAgTZZqD0ClxV0LPLRbGOdqe1GML+zGBUIfw
hFtRWkbfsdN0T/hVuSYIi09TThUpo7HTAK13tjYZuCk1P3pE6HtX5acl1SKNrpEd
FwqzkvfMCBufauhQ8p5LY0DmccjRuG0dV8vQYQSJY4URIbjHcC894nA66IUXP1Zc
GgRmYC482cCil1AX6RyPzssk6c994fxGFYhckbiJlF07DjNSEljahfv4nTon7qLt
ghI+4rXTI/DVbf+rnbqSD0tc/+LiA2oH7/O6CrULr/HEZWzU79J1lvmdPjhoKqXm
BRYAFK/7KC7rMfnEpOJ7TtCgMlNgYgiQx0Zj0NOyLb02SwY2nhqOHBtiO1QVQ8Z4
7KkPT55QZr7GUMiO5AK3lNkQSxK+3H20GtnXc9go9baDitalfNu6rIu5y78uln/I
ezzObTvS8/++gRmdeN3D1DrS96THLSKD017Xm7fUqIrPhX4w4IW+5IVeiKsv/Mpj
XmJ5HXH+foCjuk6vEwnkzyM6nmdpuU+zN9AI2kkizsyfNuqQDXBhhc9wcnlO+IbI
OOzozGKT+nCLpOMldjYQnC2HwJAIbMoxZwVy2hlmNDZRc4dM1K18pK5kIer38s9b
hRIxx8a8F0SJvP0zghNy
=/rnI
-----END PGP SIGNATURE-----

--nextPart1787463.F1IfJGiYFW--

