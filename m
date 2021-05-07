Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2 2/2] batctl: Add JSON debug commands
Date: Fri, 07 May 2021 21:08:11 +0200
Message-ID: <3428725.5OVnchzC0Q@sven-l14>
In-Reply-To: <20210507171435.370648-1-asarmanow@gmail.com>
References: <20210507171435.370648-1-asarmanow@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2845734.l1czkIsUkZ"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Alexander Sarmanow <asarmanow@gmail.com>

 
--nextPart2845734.l1czkIsUkZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de, Alexander Sarmanow <asarmanow@gmail.com>
Subject: Re: [PATCH v2 2/2] batctl: Add JSON debug commands
Date: Fri, 07 May 2021 21:08:11 +0200
Message-ID: <3428725.5OVnchzC0Q@sven-l14>
In-Reply-To: <20210507171435.370648-1-asarmanow@gmail.com>
References: <20210507171435.370648-1-asarmanow@gmail.com>

On Friday, 7 May 2021 19:14:35 CEST Alexander Sarmanow wrote:
> --- a/netlink.c
> +++ b/netlink.c
> @@ -363,17 +363,21 @@ static int info_callback(struct nl_msg *msg, void *arg)
>                 else
>                         extra_header = "";
>  
> -               ret = asprintf(&opts->remaining_header,
> -                              "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%02x:%02x:%02x:%02x:%02x:%02x (%s/%02x:%02x:%02x:%02x:%02x:%02x %s)%s]\n%s",
> -                              version, primary_if,
> -                              primary_mac[0], primary_mac[1], primary_mac[2],
> -                              primary_mac[3], primary_mac[4], primary_mac[5],
> -                              mesh_name,
> -                              mesh_mac[0], mesh_mac[1], mesh_mac[2],
> -                              mesh_mac[3], mesh_mac[4], mesh_mac[5],
> -                              algo_name, extra_info, extra_header);
> -               if (ret < 0)
> -                       opts->remaining_header = NULL;
> +               if (!opts->is_json) {
> +                       ret = asprintf(&opts->remaining_header,
> +                                      "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%02x:%02x:%02x:%02x:%02x:%02x (%s/%02x:%02x:%02x:%02x:%02x:%02x %s)%s]\n%s",
> +                                      version, primary_if,
> +                                      primary_mac[0], primary_mac[1],
> +                                      primary_mac[2], primary_mac[3],
> +                                      primary_mac[4], primary_mac[5],
> +                                      mesh_name,
> +                                      mesh_mac[0], mesh_mac[1], mesh_mac[2],
> +                                      mesh_mac[3], mesh_mac[4], mesh_mac[5],
> +                                      algo_name, extra_info, extra_header);
> +
> +                       if (ret < 0)
> +                               opts->remaining_header = NULL;
> +               }

This is rather bad. You've already queried stuff before. Just make sure that 
you set the  SKIP_HEADER flag and get rid of this is_json.

Kind regards,
	Sven
--nextPart2845734.l1czkIsUkZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmCVkBsACgkQXYcKB8Em
e0aDmRAAsSMn6rElEjj7Mdd/ZlVfk09nzvOTk+U9TxIfXnME2F8JOQyeSC/WfFHY
j/+Z1nN0kaFUo6UYlGBN1EQjNYPJksv/lWELE7qGJ2OT/9Tsj9RYesv6F8gqmlL8
KB3h6dNTcOQHss0TuNCpuexiDAx33PvTC42Sm56bmphkxyhXxbbrhgIVsE0eW1/b
7baJLFxeHE0hxboYkNbJlowXOpFp6XFzbXnm2fGhZvz+0jziuxlE2vZ42AfMcIuc
JhJ4nfYsZGEWjTBE+Ptb/g1RB+bRh8ertwvXFPaN2IRU8/drxAh/y/on5FBfP1ID
vFR+ktbpGTXVK+4XWuCOtTy6SnHI5AdSL7VJbl9V6WO248rdhaUerBBL5wqVJzdC
D6jElbNGUd31s/fjtETA251AaxyFDtsyV8WY3EQ2BAgN/iMrPwDTUkL4yFzpbWHe
ugI/z15BAsqIHjourWZqKe7XhuSJ2AT+sslLNOUPLw6tc6ucAQ3pUiocWJa3BypB
UH03UYWgrsi0icUysLnO4RkeoGyR5YN39P/x5Y20OWRxV6kTmauFuWewVR9YH1NW
LnBkSdsZk7gVPQQ8HrKZITqT6Cr1CsSc5my4mwGxoZbL5nF7Y98dRT+Rgp97o5vH
3kCKOHV2Mz9OFo5D3IXSckGRggcY4aP+vdwYON0vMhucpQSYiAo=
=Bnpn
-----END PGP SIGNATURE-----

--nextPart2845734.l1czkIsUkZ--


