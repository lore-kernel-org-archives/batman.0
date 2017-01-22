Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:20:42 +0100
Message-ID: <3266034.EiLA6asg3G@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2562601.vs4QOjhsND";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH 0/9] batctl: relax root privileges check
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

--nextPart2562601.vs4QOjhsND
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

batctl has a "root" user check since the beginning of this tool. It even got a
TODO comment in 58525b8330e9 ("batctl: adjust vis.c coding style"):

    /* TODO: remove this generic check here and move it into the individual functions */

This patchset is now trying to resolve this TODO.

 * batctl: Move root privileges check in separate function
 * batctl: Use geteuid for checks of root privileges
 * batctl: Return type of error on netlink_get_info error
 * batctl: Make root privileges check function specific
 * batctl: Allow to retrieve interface stats as non-root
 * batctl: Allow to read loglevel as normal user
 * batctl: Allow to read gw_mode as normal user
 * batctl: Allow to read sysfs settings as normal user
 * batctl: Allow to read list of interfaces as normal user

"Return type of error on netlink_get_info error" may look a little bit odd in
this list. But it was required in my initial test to avoid that "originators"
and "gwl" try to start a debugfs access when the netlink function should have
returned a "-EPERM" (but did return a -EOPNOTSUPP).

Kind regards,
	Sven
--nextPart2562601.vs4QOjhsND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliEo5oACgkQXYcKB8Em
e0bUcBAAhG2baiQ6OlzYbiqZ2gPpNgW5my056+bCOjJdKc9MWDS/09BgcCBZZkFv
7slAabnMYVVeV3r3FPipYwuTnxXMnFocGU8QIuaWlXnLOHDBOFLijGjHWTMIbfXS
QNNuvj24MtbqhmFPTGYzpyUIyHHXiUYxoPpfT+hJh8VI8kNI1XsBZFw+PRfPGFEj
Gp+oznRSAiqE/t/TnfczSSl4dvtC5boPUJ1ie9RKTTpBJnan+aCmq59sSWXkLFBu
aHFUhKOS4k9CN0tnm5tdL92BKSjmok8tIA6hjKVUaNFEm5/LC7EKBkuf2STEeo8h
1n8juLYsR7NbTdI8ERcKChV2s3lPnmkc+nRmLRNzUU1QoHhWJ9VdJlNYFfOVVAKy
TCFMD9PFcihVZw52k/IIWCdjk/5Zc0J9DnreDl2SBuizLv1FX3Q6KzPlnmkAdKmy
OuUj2hToZbg8L7PJmP/hbjBskuXlVd+pOKdkWZWH4ejY9zJ9Dk4Ea6V3G1dyTR36
LF9ESZdB3GWqYN25RuJABouLsV9b93YkMbA8wibSrI84GiHXHi1/6ebh2bm0RC3a
O6Kk9xtv7QmxTn+ei+F4AVIwx5Qn0DdX+LS+B1FWpzXn5bLZMMS3AitFG8hGJw4q
/bJdTc524CXNpIb4ke039lUiIndHT/DDZtClftrSMliKBDYcX0c=
=Lh6G
-----END PGP SIGNATURE-----

--nextPart2562601.vs4QOjhsND--

