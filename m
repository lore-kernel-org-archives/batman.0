Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 11:41:53 +0200
Message-ID: <2365708.Am9coUDyuZ@bentobox>
In-Reply-To: <20181024192128.22531-1-jhaws@sdl.usu.edu>
References: <20181024192128.22531-1-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart220068829.Y7zkn2KnXh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] alfred: Request MAC resolution for
 IPv4 address not in ARP cache
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
Cc: Jonathan Haws <jhaws@sdl.usu.edu>, guohuizou2000@sina.com

--nextPart220068829.Y7zkn2KnXh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 24. Oktober 2018 13:21:28 CEST Jonathan Haws wrote:
[...]
>  
> +       while (retries-- && !(arpreq.arp_flags & ATF_COM)) {
> +               ipv4_request_mac_resolve(addr);
> +               usleep(200000);
> +
> +               if (ioctl(interface->netsock, SIOCGARP, &arpreq) < 0)
> +                       return -1;
> +       }
> +
>         if (arpreq.arp_flags & ATF_COM) {
>                 memcpy(mac, arpreq.arp_ha.sa_data, sizeof(*mac));
>         } else {

According to gary [1], this doesn't work because the ioctl fails for him and 
then the function returns immediately (before the while loop).

Please adjust your patch - but please don't use his code - it looks rather
ugly and also doesn't work for multiple retries. You most likely want to
drop the if-ioctl completely and then put everything in your while loop:

	while (ioctl(interface->netsock, SIOCGARP, &arpreq) < 0 ||
	       !(arpreq.arp_flags & ATF_COM)) {
		if (retries-- <= 0)
			break;

		ipv4_request_mac_resolve(addr);
		usleep(200000);
	}

But feel to propose a different (cleaner) approach.

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2018-October/018195.html
--nextPart220068829.Y7zkn2KnXh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvRj+EACgkQXYcKB8Em
e0Y8iw//Sq3jOzACC1z+cRwhRMNkBIQxmUIeUZQ4zELSslI+Qu0KBCM4g86EWX0D
AIDHOmljwvNWypX+0QF1le/psGmMHUN2qOu2o8ci2Zz47dgWxubruCUSk6ksreoc
NW8ruis1I6OtXSdKYt0/h/12boI6NczByeYnW6yz+2nZ6fww3cTyie2olNj9D9eu
VY6aQtHlqvbNgN0W1KgRnn/y22ofAKt2Pi2DrZOd+1aw8LmZuGYfkmYlcM17t6c6
a0+gu3WTIISLWc0Rm5YONWcJXCSDaUut08axdt1UZRTFQ0sYyoJnVgpozx285RmO
yux1KvQJZ6fVqCkruUQ4yoT12sZpSraQ7v7uQv1Z6XcBKZC9JVR69o9oOwOTrKz1
7sSKZ1rD2EarH9pjOg2t356tunUVeT3Oad3Kt5pTeW7hXrp1JtahvcZ5bQsZZf7X
FySWh95wT7JKBzWrRr0GNGzLMC4sOZ1vLmEBUnXY3S4Na0Je5FD6QGpwEziefsa7
9wpuUQxxFKbGb3Aer7Z784nQvTxMi4Gu0BprJpGiwPCy+KSFx3gyRrfPHsMUwNSX
FreNhOMwrhXZCV6LuydJZ64n0C3gsfGt6Ex6SPnnWYaemP2/w0mYjqlnE0YV5apq
SFGdSrsupwP0xQkGNqYaRzzwpsG2vwAAyMn/vWMgCgvy0lXb90I=
=P4xy
-----END PGP SIGNATURE-----

--nextPart220068829.Y7zkn2KnXh--

