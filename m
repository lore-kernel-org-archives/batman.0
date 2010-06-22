Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Tue, 22 Jun 2010 19:28:44 +0200
References: <201006211611.45412.clemens-john@gmx.de>
	<20100622144219.GA20481@Sellars>
In-Reply-To: <20100622144219.GA20481@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1965634.rMX5lJHNFs";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201006221928.52820.clemens-john@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Cannot build actual OpenWrt Backfire branch with
	Batman Advanced
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1965634.rMX5lJHNFs
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am Dienstag 22 Juni 2010, 16:42:19 schrieb Linus L=C3=BCssing:
> ckfire branch with Batman Advanced
> Von:
> Linus L=C3=BCssing <linus.luessing@web.de>
>   An:
> "The list for a Better Approach To Mobile Ad-hoc Networking"
> <b.a.t.m.a.n@lists.open-mesh.org> Datum:
> Heute 16:42:19
>   =20
> Hi Clemens,
>=20
> seems to have been some svn weirdness...
> with deleted branches you have to use
> 'svn co -r 1611
> "http://downloads.open-mesh.org/svn/batman/branches/batctl-0.2.x@1611"'
> (which I also didn't know before) instead of
> 'svn co -r 1611
> "http://downloads.open-mesh.org/svn/batman/branches/batctl-0.2.x"
>=20
> Should be fixed in OpenWRT commit 21880 now. Please let us
> know, if it works for you too :).

Yes it worked :)
The source package is not available but checking out the code does work aga=
in=20
so that compiling does work without doing something by hand (and thats=20
important for lazy peoples like me :D).

Here is the output, maybe you=C2=B4d like to know what hapened:
=2D----
make[3]: Entering directory=20
`/home/floh1111/openwrtbuild_luci2/feeds/packages/net/batman-advanced'
mkdir -p /home/floh1111/openwrtbuild_luci2/dl
/home/floh1111/openwrtbuild_luci2/scripts/download.pl=20
"/home/floh1111/openwrtbuild_luci2/dl" "batman-adv-maint-1611.tar.gz" ""=20
http://git.open-mesh.org/snapshot/5c4633c532a7a9b5adfe5dbf3f5e97fff307216e/
=2D-2010-06-22 18:42:44--  http://git.open-
mesh.org/snapshot/5c4633c532a7a9b5adfe5dbf3f5e97fff307216e/batman-adv-
maint-1611.tar.gz
Resolving git.open-mesh.org... 78.46.248.236
Connecting to git.open-mesh.org|78.46.248.236|:80... connected.
HTTP request sent, awaiting response... 301 Moved Permanently
Location: http://git.open-mesh.org/?p=3Dbatman-
adv;a=3Dsnapshot;h=3D5c4633c532a7a9b5adfe5dbf3f5e97fff307216e;sf=3Dtgz [fol=
lowing]
=2D-2010-06-22 18:42:45--  http://git.open-mesh.org/?p=3Dbatman-
adv;a=3Dsnapshot;h=3D5c4633c532a7a9b5adfe5dbf3f5e97fff307216e;sf=3Dtgz
Reusing existing connection to git.open-mesh.org:80.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [application/x-gzip]
Saving to: `STDOUT'

    [  <=3D>                                                               =
                                               =20
] 51,039       206K/s   in 0.2s   =20

2010-06-22 18:42:46 (206 KB/s) - written to stdout [51039]

mkdir -p /home/floh1111/openwrtbuild_luci2/dl
=2D-2010-06-22 18:42:46--  http://mirror2.openwrt.org/sources/batctl-
maint-1611.tar.gz
Resolving mirror2.openwrt.org... 88.198.39.176
Connecting to mirror2.openwrt.org|88.198.39.176|:80... connected.
HTTP request sent, awaiting response... 404 Not Found
2010-06-22 18:42:46 ERROR 404: Not Found.

Download failed.
=2D-2010-06-22 18:42:46--  http://downloads.openwrt.org/sources/batctl-
maint-1611.tar.gz
Resolving downloads.openwrt.org... 78.24.191.177
Connecting to downloads.openwrt.org|78.24.191.177|:80... connected.
HTTP request sent, awaiting response... 404 Not Found
2010-06-22 18:42:46 ERROR 404: Not Found.

Download failed.
No more mirrors to try - giving up.
Checking out files from the svn repository...
svn: Write error: Broken pipe
A    batman-adv/batctl
A    batman-adv/batctl/vis.c
A    batman-adv/batctl/ping.h
A    batman-adv/batctl/proc.c
A    batman-adv/batctl/bat-hosts.sample
A    batman-adv/batctl/bat-hosts.c
A    batman-adv/batctl/vis.h
A    batman-adv/batctl/proc.h
A    batman-adv/batctl/functions.c
=2D----------

Thank you
Clemens

--nextPart1965634.rMX5lJHNFs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwg8s0ACgkQZgdHbA22lqN3OgCgnRas/FcFsuJJoZrbqfVwB40m
QK0AnAprG+llQVvL1CAHo3oobVRkPrEW
=7Xc2
-----END PGP SIGNATURE-----

--nextPart1965634.rMX5lJHNFs--
