Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 31 Oct 2011 01:52:22 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111031005222.GA12450@pandem0nium>
References: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 00/11] bridge loop avoidance II
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
To: b.a.t.m.a.n@lists.open-mesh.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey there,

There are also some online repositories which might be interesting for
your review:

http://git.open-mesh.org/?p=3Dsimon/batman-adv.git;a=3Dshortlog;h=3Drefs/he=
ads/blaII_dirty
here are the separate fix patches on top of the original patchset. I'll add
fixes here first.

http://git.open-mesh.org/?p=3Dsimon/batman-adv.git;a=3Dshortlog;h=3Drefs/he=
ads/blaII
this is the patchset as sent to the mailing list. Fixes are squashed from
blaII_dirty into this branch later.

http://git.open-mesh.org/?p=3Dsimon/batctl.git;a=3Dshortlog;h=3Drefs/heads/=
blaII
this is the batctl patch which adds some control and debugging functions.

Cheers,
	Simon

On Sun, Oct 30, 2011 at 11:51:01PM +0100, Simon Wunderlich wrote:
> This series of patches is a request for comments on the redesigned
> bridge loop avoidance. The general concept is described in the wiki
> [1]. I've already performed a few testcases [2] which worked fine in
> my kvm environment. No crashes while running or unloading the=20
> extension either.
>=20
> The last patch in the series uses the cached address of the primary
> interface (the originator address known through the mesh) to save some
> code at various positions, there may be side effects I don't see
> however (e.g. implicit checking whether the module was configured
> correctly was removed).
>=20
> Marek already pointed quite a few issues out, these changes are
> reflected in the respective commit logs. These commit comments will
> be removed in the final version.
>=20
> Any comments and suggestions are appreciated.=20
>=20
> Thanks
>     Simon
>=20
> [1] http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance-II
> [2] http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance-Testca=
ses
>=20
> Simon Wunderlich (11):
>   batman-adv: remove old bridge loop avoidance code
>   batman-adv: add basic bridge loop avoidance code
>   batman-adv: make bridge loop avoidance switchable
>   batman-adv: export claim tables through debugfs
>   batman-adv: allow multiple entries in tt_global_entries
>   batman-adv: don't let backbone gateways exchange tt entries
>   batman-adv: add broadcast duplicate check
>   batman-adv: drop STP over batman
>   batman-adv: form groups in the bridge loop avoidance
>   batman-adv: Update README and sysfs description
>   [RFC] batman-adv: get primaries address through bat_priv->own_orig
>=20
>  Makefile.kbuild         |    1 +
>  README                  |   28 +-
>  bat_debugfs.c           |   18 +-
>  bat_sysfs.c             |    4 +-
>  bridge_loop_avoidance.c | 1509 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  bridge_loop_avoidance.h |   34 ++
>  compat.c                |   16 +-
>  compat.h                |    3 +-
>  hard-interface.c        |    8 +-
>  icmp_socket.c           |   12 +-
>  main.c                  |    9 +-
>  main.h                  |    9 +-
>  originator.c            |    3 +-
>  packet.h                |   16 +
>  routing.c               |   41 +-
>  soft-interface.c        |  490 +---------------
>  soft-interface.h        |    2 -
>  sysfs-class-net-mesh    |    9 +
>  translation-table.c     |  366 ++++++++----
>  types.h                 |   70 ++-
>  unicast.c               |    9 +-
>  vis.c                   |   20 +-
>  22 files changed, 1965 insertions(+), 712 deletions(-)
>  create mode 100644 bridge_loop_avoidance.c
>  create mode 100644 bridge_loop_avoidance.h
>=20
> --=20
> 1.7.7.1
>=20
>=20

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6t8UYACgkQrzg/fFk7axYyrQCdH71oH+C6Smi31y5TRbsZq5Kv
jb0AoJk3b4HNrVlkTTwdBxJNSVdMAXUY
=Tbai
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
