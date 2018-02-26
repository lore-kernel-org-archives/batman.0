Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 26 Feb 2018 17:35:48 +0100
Message-ID: <2208285.pQLjLXacrd@prime>
In-Reply-To: <20180226125132.30767-1-sven@narfation.org>
References: <20180226125132.30767-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart18998465.UoeHJPyO1h";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Only use compat.h for
 kernel builds
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

--nextPart18998465.UoeHJPyO1h
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, February 26, 2018 1:51:32 PM CET Sven Eckelmann wrote:
> The compat.h will be included by default via the -include gcc parameter.
> This is done by appending the incude information to NOSTDINC_FLAGS in the
> Makefile. But Debian decided [1] that this NOSTDINC_FLAGS must also be used
> when not compiling kernel sources. This for example happens when the
> gcc-version.sh script is executed. This results in error messages like
> 
>   In file included from <command-line>:0:0:
>   /usr/src//batman-adv/build/../compat.h:25:52: fatal error:
> linux/version.h: No such file or directory #include <linux/version.h> /*
> LINUX_VERSION_CODE */
>                                                       ^
>   compilation terminated.
>   In file included from <command-line>:0:0:
>   /usr/src//batman-adv/build/../compat.h:25:52: fatal error:
> linux/version.h: No such file or directory #include <linux/version.h> /*
> LINUX_VERSION_CODE */
>                                                       ^
>   compilation terminated.
>   /usr/src/linux-headers-4.14.0-0.bpo.3-common/scripts/gcc-version.sh: line
> 32: printf: #: invalid number
> /usr/src/linux-headers-4.14.0-0.bpo.3-common/scripts/gcc-version.sh: line
> 32: printf: #: invalid number /bin/sh: 1: [: 0001: unexpected operator
> 
> This can be avoided by disabling the compat.h whenever the preprocessor
> define __KERNEL__ is not set.
> 
> [1] https://patchwork.kernel.org/patch/5238591/
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in 934b3884.

Thank you!
     Simon
--nextPart18998465.UoeHJPyO1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlqUN2QACgkQoSvjmEKS
nqGnSxAA2FxjZnv/m73vOQtUqQsSbiK/0FYC7+c5lmG9grNaHGJs0JXrVDAC9BCR
IoworSFtoSdCJv5VbQinVfHS1wTOR0YFD2YiGERcOgLscmEcaxQk+AQZ8t3I+CUY
nNOrwHzYiwCcytk/4ykeI+/DZzcAhGos9zP6fHhyYhf4CiS7bopgzHnsmQJIZ318
6bkD/aGg5JY2nuHgHwJGS3jMTQelYOVC3N+mv0PTuhI1mRABKQZYhQ4nl8Vy5UOy
N5W9W/aKvB7V3D2F0Rub1Uj83xspRQOhrNbBj3DNeNZSlaMu2Dy2kfwF7TehIkcL
UCt/rXi7UBXqVhbISs5SniC2LO8vAm8wr9xIy/iWGmJeJ9YEIZIeAo9+/J7CtoFR
xyLvXmWKtIodtysq0jvxgj6FK04eXSdeC3NHz0AgDAoQYbHqDfMIm0DONPH9VDr+
78vwnBt3gvW0WVU1ZuHkZbaxuWofNToOvp+lFgCTFkjqd93cUAxugyb9Bu4bGfKX
mYJWadI6B1dGbPqTKYUHFyzkN7wK3Hf5daptkSdXon8LioPAGjEuKIS1NrdHzZnd
be7ElYW9CzOpSbdSBNdKWi3LJKZuBMlZJvVL2iF0PhKhGjIN4txR5oioQEk0FSyz
aY1u8aTczkVA2VWsZaCbVmJw0isaQkSlNH0BrfPsEbeef+b87AY=
=DYwy
-----END PGP SIGNATURE-----

--nextPart18998465.UoeHJPyO1h--

