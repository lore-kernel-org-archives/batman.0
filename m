Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 1 May 2010 15:53:12 +0200
References: <1272719410-406-1-git-send-email-andrew@lunn.ch>
	<1272719410-406-2-git-send-email-andrew@lunn.ch>
In-Reply-To: <1272719410-406-2-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8497225.tnMzb69Ksl";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005011553.16477.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: Update README to match
	mainline README.
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
Cc: lindner_marek@yahoo.de, b.a.t.m.a.n@lists.open-mesh.net

--nextPart8497225.tnMzb69Ksl
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  README |   35 +++++++++--------------------------
>  1 files changed, 9 insertions(+), 26 deletions(-)
>=20
> diff --git a/README b/README
> index 4c2a6c6..e2a7271 100644
> --- a/README
> +++ b/README
> @@ -15,19 +15,6 @@ above B.A.T.M.A.N. Advanced, prominent examples are:
> IPv4, IPv6, DHCP, IPX. This is batman-advanced implemented as Linux kernel
> driver. It does not depend on any network (other) driver, and can be used
> on wifi as well as ethernet, vpn, etc ... (anything with ethernet-style
> layer 2).
> -It compiles against and should work with Linux 2.6.20 - 2.6.33. Supporti=
ng older
> -versions is not planned, but it's probably easy to backport it. If you w=
ork on a
> -backport, feel free to contact us.  :-)
> -
> -COMPILE
> --------
> -To compile against your currently installed kernel, just type:
> -
> -# make
> -
> -if you want to compile against some other kernel, use:
> -
> -# make KERNELPATH=3D/path/to/kernel

This should not be removed from maint or trunk.

>  USAGE
>  -----
> @@ -123,15 +110,11 @@ dmesg | grep batman-adv
>=20
>  When investigating problems with your mesh network it is sometimes
>  necessary to see more detail debug messages. This must be enabled when
> -compiling the batman-adv module. When building batman-adv as part of
> -kernel, use "make menuconfig" and enable the option
> -"B.A.T.M.A.N. debugging". When compiling outside of the kernel tree it
> -is necessary to edit the file Makefile.kbuild and uncomment the line
> -
> -#EXTRA_CFLAGS +=3D -DCONFIG_BATMAN_ADV_DEBUG
> +compiling the batman-adv module. Use "make menuconfig" and enable the
> +option "B.A.T.M.A.N. debugging".

This should not be changed in maint or trunk.

>  The additional debug output is by default disabled. It can be enabled
> -either at kernel modules load time or during run time. To enable debug
> +either at kernel module load time or during run time. To enable debug
>  output at module load time, add the module parameter debug=3D<value>.
>  <value> can take one of four values.
>=20
> @@ -160,12 +143,12 @@ to see the debug messages.
>  BATCTL
>  ------
>=20
> -B.A.T.M.A.N.  advanced  operates on layer 2 and thus all hosts partici-
> -pating in the virtual switch are completely transparent for all  proto-
> -cols above layer 2. Therefore the common diagnosis tools do not work as
> -expected. To overcome these problems batctl was created. At the  moment
> -the  batctl contains ping, traceroute, tcpdump and interfaces to the
> -kernel module settings.
> +B.A.T.M.A.N.  advanced operates on layer 2 and thus all hosts
> +participating in the virtual switch are completely transparent for all
> +protocols above layer 2. Therefore the common diagnosis tools do not
> +work as expected. To overcome these problems batctl was created. At
> +the moment the batctl contains ping, traceroute, tcpdump and
> +interfaces to the kernel module settings.
>=20
>  For more information, please see the manpage (man batctl).

This looks fine :)

Best regards,
	Sven

--nextPart8497225.tnMzb69Ksl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL3DJKAAoJEF2HCgfBJntGYpgQAJ3FFtSOsaBHF/BpkhcphLPH
mYAMbZdjucphWyK/Gn1b0EmN7szmiLrVjwfpzqjMQUsau0ghuOX1joLNMs8hfSWR
0efMr7nBRH5M2AHsTuwkKBLIRc6JyRSZ6HbXkfGyosndcJxAiAxLmdoXYXfZF/xn
Ts6F7HLd7mqwKDhkFftY01xn/YfBmq5eE5/HUfhgwKjqPXLsM2sb2R+qDnPBiKCU
yCVgM3GcR0s5gojpRrKLlzmiXcNab81ewYp+URRTrWRvshOgD6m6fkw7aZ1E10HV
N4KwXcha1jiRXIHFMlyHWswD7JmnqmF4tQiVfFOOeHn3cVTT1/7pgEP2F7CTAiHT
a48m+FDQIBCs5AyNG3qJLZE4m0zerh1eLUcx8DuElrDdmM3X28icCqh22z89iRHd
rlrmoaXZBP6YpdJ6vvkLXgGG+hJ0l5nOUjL2R+M/YVccbks7jFlJRDZo3J1JG6nw
Gq15j+WX83c5jSvM095M22aUubM/FDmmpOY/bJp3vTKy2yQSwGBQ/8HnLTM+JPEn
1dnX7pj2akDRJVzDwtN94pEpnbMEhnsKDnMYvNxGSOzpidslOvrQZyvy6l9GXhcx
3W3OSn1axpiJY65YgMbRZVxs7C+BkYhQRIWHZx3tCeXHGh5o09zAb8/KTJRjNJ1k
bjVSp5yV+M6YhXFFB9RU
=kor3
-----END PGP SIGNATURE-----

--nextPart8497225.tnMzb69Ksl--
