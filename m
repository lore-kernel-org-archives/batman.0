Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 05 Dec 2012 09:23:18 +0100
Message-ID: <3906319.Tukpzm2960@bentobox>
In-Reply-To: <50BE9250.2050303@web.de>
References: <50BE9250.2050303@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1362433.s5M2Sr0sFq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: output errors to stderr
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1362433.s5M2Sr0sFq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 05 December 2012 01:16:16 Moritz Warning wrote:
> batctl outputs many errors to stdout instead of stderr.
> This patch corrects this behavior by redirecting errors
> and the usage texts to stderr.
> 
> Signed-off-by: Moritz Warning <moritzwarning at web.de>

Your mail address looks wrong. 

> -       if (strcmp(argv[1], "-h") == 0)
> -               goto err;
> +       if (strcmp(argv[1], "-h") == 0) {
> +               print_usage();
> +               exit(EXIT_SUCCESS);
> +       }
>  

This seems to be unrelated. Please remove it from the patch.

Kind regards,
	Sven
--nextPart1362433.s5M2Sr0sFq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQvwR2AAoJEF2HCgfBJntGcvUP/0PMi2ZLGMv2JXRjBZUEOs6I
jPu6IWRo9QiNgvefdIviW/sJN1nuZHIZXGYBQ+8i8RA+UrloqN9UTmkwCOGo+Cdl
ET91hZptyv23cRPOx3XVDwAx1MhQq1zlh2TPprWlkNeANHjc+aAa0x5gfz55Urpu
RYR/er0Wh0eGrbOQsny4MfhRwKYXyRirkalsG0MGEFrAyTSbXaxb3okBdMW65MDz
5M1vtHOgBLyuRZxF7ODqi69cMac4tm40j6gklgssOybKSR+NgtOLVhTVGVXMCwT+
RgxBpRow+lc1OZSA1mH2P/Fdg2+e6ck8r81JzsL9YtyMNmr+mcWAuGs1ZVRfHILZ
YdYck8n3w04S6qqD45LfHYVpCp1nZoW/97Eg39RjKqCm+aXwQ2xurQbm3YpEspAA
1cYYjySp7j5o/0kN5pPJczIoT+0yWEacZRsp2geNlaMp+DrPhismqOCmKJLCqSgI
9i+wYwfgxspHxBqgXUOZzZrTLCq2X+/Dcn1imd03QwNYZZzsYjZG+F8/MUnI+vN0
zBffghLfYDOvS+MdOUSmEpF/FsuKFtoLb/Ofe5U5mGFHtY2krjcfqoLfVJtNWMU6
gy6nSk00tfmctN87gRYwtpI0eptdbBuA9itGoTcxglYq7h9wVrDYEkCxmjJEuHI3
6jBQbL+Xp3+sDwVhjJzN
=ddla
-----END PGP SIGNATURE-----

--nextPart1362433.s5M2Sr0sFq--

