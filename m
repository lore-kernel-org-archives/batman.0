Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 29 Jan 2016 13:14:53 +0100
Message-ID: <23082646.VzubcaWY7q@prime>
In-Reply-To: <1453953196-29943-3-git-send-email-andrew@lunn.ch>
References: <1453953196-29943-1-git-send-email-andrew@lunn.ch>
 <1453953196-29943-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8217258.tCM4Yg4TQU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] alfred: Mount debugfs before
	reducing capabilities
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart8217258.tCM4Yg4TQU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 28 January 2016 04:53:15 Andrew Lunn wrote:
> The debugfs helper code has the ability to mount the debugfs file
> system if it is not already mounted. However, it cannot do this
> after the capabilities have been dropped. So perform the mount early.
> 
> This is especially important when using network name spaces. Each
> namespace has its own /sys, so the mount of debugfs in the global
> namespace is not visible in other namespaces.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/main.c b/main.c
> index 452d9ae..b1c5ec5 100644
> --- a/main.c
> +++ b/main.c
> @@ -30,6 +30,7 @@
>  #include <unistd.h>
>  #endif
>  #include "alfred.h"
> +#include "debugfs.h"
>  #include "packet.h"
>  #include "list.h"
> 
> @@ -160,6 +161,9 @@ static struct globals *alfred_init(int argc, char
> *argv[]) {NULL,			0,			NULL,	0},
>  	};
> 
> +	/* We need full capabilities to mount debugfs, so do that now */
> +	debugfs_mount(NULL);
> +
>  	ret = reduce_capabilities();
>  	if (ret < 0)
>  		return NULL;

Can't we remove the other calls to debugfs_mount() ? I see 3 more calls in 
alfred ...

Cheers,
     Simon
--nextPart8217258.tCM4Yg4TQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWq1e9AAoJEKEr45hCkp6hcbQQAK+kjV1obW2uiNW1UQ2wtNSw
Bv24hEQT0w3ITv6hz4Vb7h/HCVnwcmermlVsdkM8fcOPAipFezFx74/eZgG/JzsV
8rlOxaKyAVBYyP9pRrxHpUYBtXPNUF+UDJ/ZndeIV/b8CzahzTRjYa+UIFcvCb5O
tXPB2oyk+PUL9PqJxJtRIMZjDN60FF28FJZHyVBMkLf1BEeKk3ZhOZ3xV+fRddDN
fuuab2llhI8qv5cpJruZIekxlAIXLHQfwuN/slM9I3sSmkuvmNfaowyZSK7BEZFm
IVSZ/fVoE6B4s2W0KC44EtBcfuc7zPpytbdS177HjXmqePWicm3Mdyonhttc0DD1
j8q39A1tquQFRMceefBNJiHB8QxilfaoIJgzFrPPXYQY32KVSddaN+ALnVmaKjvy
8meeYWtUY+C3cwQfyxz/u1IdvjAHnidxfqES3tGSBWpgpU9HOgbtLXjI/wvQT04B
shrJHZAgtkPfCo+Iu+b/X61NFs0oUMZt/uRk8bLj8INcbQa1G6cdXe+D8dilzHmc
41xl36RGBFYN/An5tMywTdR9gj0GCnXihFFuoEFiMan94n80PslHrySRQvN8y97x
TZfq39Zr52RrY7Pj5Q6rCPILg9WTLGdn19EYAxWNwLineEkegD1ODrwCBvIGOH7k
MsYPY0URk4RHtffg4Doh
=mk6T
-----END PGP SIGNATURE-----

--nextPart8217258.tCM4Yg4TQU--

