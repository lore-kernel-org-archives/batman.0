Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 Jan 2017 08:44:53 +0100
Message-ID: <4570303.DAXUuCGGu2@bentobox>
In-Reply-To: <1484596174-16341-1-git-send-email-jhaws@sdl.usu.edu>
References: <1484596174-16341-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3605675.GJFlClncXF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] IPv4 multicast distribution support.
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
Cc: Jonathan Haws <jhaws@sdl.usu.edu>

--nextPart3605675.GJFlClncXF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Patch subject prefix is wrong (actually, it is missing).

On Montag, 16. Januar 2017 12:49:34 CET Jonathan Haws wrote:
> +int ipv4_to_mac(const alfred_addr *addr, struct ether_addr *mac)
> +{
> +  mac->ether_addr_octet[0] = 0;
> +  mac->ether_addr_octet[1] = 0;
> +  mac->ether_addr_octet[2] = (addr->ipv4.s_addr >> 24) & 0xFF;
> +  mac->ether_addr_octet[3] = (addr->ipv4.s_addr >> 16) & 0xFF;
> +  mac->ether_addr_octet[4] = (addr->ipv4.s_addr >>  8) & 0xFF;
> +  mac->ether_addr_octet[5] = (addr->ipv4.s_addr >>  0) & 0xFF;
> +
> +  if (!is_valid_ether_addr(mac->ether_addr_octet))
> +    return -EINVAL;
> +
> +  return 0;
> +}


This will not return the mac address of the device. It will therefore break
the synchronization code. see SOURCE_FIRST_HAND in sync_data and the code
which sets data_source in finish_alfred_push_data.

On Montag, 16. Januar 2017 12:49:34 CET Jonathan Haws wrote:
> @@ -61,6 +62,7 @@ static void alfred_usage(void)
>         printf("                                      other masters\n");
>         printf("  -p, --sync-period [period]          set synchronization period, in seconds\n");
>         printf("                                      fractional seconds are supported (i.e. 0.2 = 5 Hz)\n");
> +       printf("  -4                                  specify IPv4 multicast address and operate in IPv4 mode");
>         printf("\n");
>         printf("  -u, --unix-path [path]              path to unix socket used for client-server\n");
>         printf("                                      communication (default: \""ALFRED_SOCK_PATH_DEFAULT"\")\n");


The documentation is wrong. It requires an argument but the argument is not
shown.

Same problem in the manpage.

On Montag, 16. Januar 2017 19:52:41 CET Jonathan Haws wrote:
> I realize that the code in this patch is not formatted properly, but I
> was unable to get checkpatch.pl to scan this right - it needs a full
> kernel tree.  Is there another formatting script I can run?

What is the problem with downloading the kernel sources? And auto-formatting
scripts tend to not get everything right and make things worse in some cases.
checkpatch.pl is therefore only to point out some obvious problems.

For example that you are replace tabs (8 spaces wide in alfred code) sometimes
with 2 spaces.

Kind regards,
	Sven
--nextPart3605675.GJFlClncXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlh9y3UACgkQXYcKB8Em
e0bGJRAAy8IAG0GXVQopfwvLd1yXmmQn80VokAS4hceaSw5Hs/EiL/8eyx36CB+X
RKxM/pQ9VBjPau/lJC8znxgZT/tw56DFBXmWtxqFmbhqadqpsBHYpk1NFQ3HR9L5
PZh13y88V7e+JLi4FwaQZ2/NGwhODVurOUyvu90h+rDe7u4/zCi0lu6TCuoZ6oPa
cK5FwNGBXta38WVcwdE+H6QYS3K8Grri8/EHF3IYg5DZTCPEjm08fHsVjh/mENOZ
ofmDADqBlTa3Ip97XJoWhl4RG9Vw5mUKKHMv0k8TqhfzKIY83lyK+TPNAoFdKjeG
eubG83JrhABiMIUGAyAyl0A9PO+NOtptrn1ZSNoLjvjjQP2AcrJbWrEM6O4lGGY6
iTtzxPivWyKZYrHNQRd92U7kgDArD44cQb6aH29//AOfKMUp2883RNdquBLMfNfZ
I3+QCGFfhaUUY2dGONYZfcF3uKXd9eznJfnikpXX23gL0BkgpTXqiMqh2hNEKf5U
/Bo6C/oyk+wzxp5WwqIesIONMSvOrUVWpPIKMo+nMZchw6WMLQV3f50zVL0dHaxL
Ru2DsSpoaykdR8wBlhyNLBQa05yIwWY14hnDsUJXZxclauVc04lx0Gx7lJBGgPzh
md/Z7DLkg+Lj8VxFumNHfhUHhiWtrg/ExgwJevU+miTaE0ZKfg0=
=0wpp
-----END PGP SIGNATURE-----

--nextPart3605675.GJFlClncXF--

