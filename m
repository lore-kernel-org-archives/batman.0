Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 01 Jun 2017 10:34:39 +0200
Message-ID: <2479408.89UKcKX64H@prime>
In-Reply-To: <1496077749.5980.2.camel@gmail.com>
References: <1496077749.5980.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6742198.GXJmilYNL4";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [batctl] compiling with gcc 7.1.0: there are
 some notes and warnings
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

--nextPart6742198.GXJmilYNL4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, May 29, 2017 7:09:09 PM CEST Philipp Psurek wrote:
> Hi all,
> 
> it's nothing to worry about but since 2011 I always noticed a clean
> compile run of your code. Now with gcc 7.1.0 there are some warnings
> and notes that might interest you:
> 
> ~ LANG=C make
>     CC bat-hosts.o
>     CC debugfs.o
>     CC debug.o
>     CC functions.o
>     CC genl.o
>     CC hash.o
>     CC icmp_helper.o
>     CC interface.o
>     CC ioctl.o
>     CC main.o
>     CC netlink.o
>     CC ping.o
>     CC sys.o
> In file included from sys.c:37:0:
> sys.c: In function 'handle_ra_setting':
> sys.h:33:25: warning: '%s' directive output may be truncated writing up to
> 255 bytes into a region of size 185 [-Wformat-truncation=] #define
> SYS_IFACE_PATH  "/sys/class/net"
>                          ^
> sys.h:38:30: note: in expansion of macro 'SYS_IFACE_PATH'
>  #define SYS_ROUTING_ALGO_FMT SYS_IFACE_PATH"/%s/mesh/routing_algo"
>                               ^~~~~~~~~~~~~~
> sys.c:480:38: note: in expansion of macro 'SYS_ROUTING_ALGO_FMT'
>    snprintf(path_buff, PATH_BUFF_LEN, SYS_ROUTING_ALGO_FMT,
> iface_dir->d_name); ^~~~~~~~~~~~~~~~~~~~
> sys.h:38:46: note: format string is defined here
>  #define SYS_ROUTING_ALGO_FMT SYS_IFACE_PATH"/%s/mesh/routing_algo"
>                                               ^~
> sys.c:480:3: note: 'snprintf' output between 34 and 289 bytes into a
> destination of size 200 snprintf(path_buff, PATH_BUFF_LEN,
> SYS_ROUTING_ALGO_FMT, iface_dir->d_name);
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> CC tcpdump.o
>     CC tp_meter.o
> tp_meter.c: In function 'tp_meter':
> tp_meter.c:502:3: warning: this statement may fall through
> [-Wimplicit-fallthrough=] printf("CANCEL received: test aborted\n");
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> tp_meter.c:504:2: note: here
>   case BATADV_TP_REASON_COMPLETE:
>   ^~~~
>     CC traceroute.o
>     CC translate.o
>     LD batctl
> 
> # batctl -v
> batctl 2017.1-1-g3069ca8 [batman-adv: 2017.1-4-g2149d80d]
> 
> It's really nothing bad at all. gcc 7.1.0 is somehow a little bit
> capricious but with more suggestions to make cleaner code.
> 
Hi Philipp,

thanks for showing this. I think none of that is really critical, and the fall 
through is actually intended.

Do you want to propose a patch for these things?

Cheers,
    Simon
--nextPart6742198.GXJmilYNL4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlkv0Z8ACgkQoSvjmEKS
nqFNKA//bTX1kaM1HSbg3DElESl9Ra9bE4V3iLq/9C9WVo3f4sE2hpxCz5ZdXV+y
JABi60aBoTEBGM/BMof6mMut5ydnfMTSKmmYk/BIHvPspwuRyUPKvn+jGiZFV+6m
oeAm6xqEMDvmq4PHKGWv6uV+OfaohCafKh4soJdXcT5wuGJxDIEj2ppOKhm5IKuU
8nYcK9+Loq2e2j0ajkpn1Yx+iVGMGsHPNFHyqi8wk4iEj4drkAelD/cmhQksw89Q
3ESIbAUaGBggiSH5mRvwwE8xxVyGgcL3yjpOKIk5MWNKP9tp/VvN7k2wCHwh+f/R
bWg99mYM5Hs4F5204IND7tmt/TAV1VqxHTWN/zCrJL3jYiM2EDuVuN9lMK0le3Nm
DH+l5hTEZrEJwdqL4ppBp4HGC3aFUdU2tv4ttGb4pr8Qr0VWQg+F34UAFnEoKp/x
1Yh4KzNUpDmrNM0SAJEGLNUbIcawZLBu1gMOQ2eCFMPi2x3Of6rUMHuOTRkJgvNA
Zwlxuv2yOtV1pJeKxbkDF0IWZEgynqnZ/lha1aoqkEGkVfLJAJKt9v3cKdM+GU9h
+G7p5aEftQhlFtUuTWCq9JPsbRNxDgfYWh0ODeP8lmMc6yS7LIX0NMvbNSg5dDSH
U384QGYyT8vcq8FTZjPSBVticZXp70jMOXp+9y5fUgShowmS46U=
=NKlE
-----END PGP SIGNATURE-----

--nextPart6742198.GXJmilYNL4--

