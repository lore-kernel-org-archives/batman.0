Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 20:07:18 +0200
Message-ID: <13793953.BNCcl5mI6H@sven-edge>
In-Reply-To: <1461875848-11720-3-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2213671.I8DidLRnIP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 02/10] batman-adv: Suppress debugfs
	entries for netns's
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

--nextPart2213671.I8DidLRnIP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday 28 April 2016 22:37:20 Andrew Lunn wrote:
> Debugfs is not netns aware. It thus has problems when the same
> interface name exists in multiple network name spaces.
>=20
> Work around this by not creating entries for interfaces in name space=
s
> other than the default name space. This means meshes in network
> namespaces cannot be managed via debugfs, but there will soon be a
> netlink interface which is netns aware.
>=20
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
[...]
> -__printf(2, 3)
> +_printf(2, 3)
>  static int batadv_fdebug_log(struct batadv_priv_debug_log *debug_log=
,
>  =09=09=09     const char *fmt, ...)
>  {

I would really like to give this patch a Reviewed-by but this part seem=
s to be
an accident. It causes build errors:

    $ make CONFIG_BATMAN_ADV_DEBUG=3Dy KERNELPATH=3D/build_test/linux-b=
uild/linux-4.5
    [...]
      CC [M]  /tmp/qemu-batman/batman-adv/net/batman-adv/debugfs.o
    /tmp/qemu-batman/batman-adv/net/batman-adv/debugfs.c:81:9: error: e=
xpected declaration specifiers or =E2=80=98...=E2=80=99 before numeric =
constant
     _printf(2, 3)
             ^
    /tmp/qemu-batman/batman-adv/net/batman-adv/debugfs.c:81:12: error: =
expected declaration specifiers or =E2=80=98...=E2=80=99 before numeric=
 constant
     _printf(2, 3)
                ^
    /tmp/qemu-batman/batman-adv/net/batman-adv/debugfs.c: In function =E2=
=80=98batadv_debug_log=E2=80=99:
    /tmp/qemu-batman/batman-adv/net/batman-adv/debugfs.c:114:2: error: =
implicit declaration of function =E2=80=98batadv_fdebug_log=E2=80=99 [-=
Werror=3Dimplicit-function-declaration]
      batadv_fdebug_log(bat_priv->debug_log, "[%10u] %s",
      ^
    /tmp/qemu-batman/batman-adv/net/batman-adv/debugfs.c: At top level:=

    /tmp/qemu-batman/batman-adv/net/batman-adv/debugfs.c:68:13: warning=
: =E2=80=98batadv_emit_log_char=E2=80=99 defined but not used [-Wunused=
=2Dfunction]
     static void batadv_emit_log_char(struct batadv_priv_debug_log *deb=
ug_log,
                 ^

Kind regards,
=09Sven
--nextPart2213671.I8DidLRnIP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI6LWAAoJEF2HCgfBJntGZ+AQAI4egTL9fz9TOwCsbwFAmlFO
ldDwoBXqEPeIPFLtFNEozrnowgHuwEuOfFGar+58qaobB239EBTSa218KDJPnDPi
R6NUKFb8J4b3Wq4GivL2ZU9zWGevUmLWcvgj59N/fHGDqqKIUgxmEoA3ZLanql4B
DjTGro7ZEM2HhSitxduS+nQGXEnH9Rkw6cecP/pS0ZTsy4PLCveRebA7RJG3/zPu
qOj5BY0XbqJXri6MDrScWrWqVEsTO3yEB1jojotBxvggAj8XT2PBjesaD2ByIftg
9X+Kb0oU50ocfu4xXgBGG49sNhAALPr2XciNDm74Ww/bljiIrXnya8WLGpUFUo3L
tC5O5yEUKcAekMucclequDah+HxfVi8xDILrX6s5BlLkC8jAACt8p941uwa+bA1C
IEzdDHdib18qeGZho4h91SB5AgtkusC5qJQvFTKJc0rgKBngAU7QSmDNIuF/i9xB
piJ8MNC4dTqwJPWSTfrCbRzs7HVRygwsHm/qrCdzYs3djU0sHWMnkEMpYReTMv5s
kUMUKDdMGiB2K8UG8y6GiTFpAroS7qKT98u/AJK5xlfvheO5QHMhziWg+RwMjY0J
FD+7zMmgQKlTd2rC545SrkvJrjO+fhTqTZBofnteYE796PHU370WA+BosgM+J9O7
zXcryXV0Xf82Rj5KchPO
=MH4P
-----END PGP SIGNATURE-----

--nextPart2213671.I8DidLRnIP--

