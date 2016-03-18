Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 18 Mar 2016 12:27:38 +0100
Message-ID: <2389171.6qzBFbKr0u@bentobox>
In-Reply-To: <1458157872-15879-3-git-send-email-andrew@lunn.ch>
References: <1458157872-15879-1-git-send-email-andrew@lunn.ch>
 <1458157872-15879-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2270391.VzILtGa2xY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] alfred: Mount debugfs before
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
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart2270391.VzILtGa2xY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 16 March 2016 20:51:12 Andrew Lunn wrote:
> --- a/batadv_query.c
> +++ b/batadv_query.c
> @@ -90,16 +90,9 @@ int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac)
>  
>  int batadv_interface_check(const char *mesh_iface)
>  {
> -	char *debugfs_mnt;
>  	char full_path[MAX_PATH + 1];
>  	FILE *f;
>  
> -	debugfs_mnt = debugfs_mount(NULL);
> -	if (!debugfs_mnt) {
> -		fprintf(stderr, "Could not find debugfs path\n");
> -		return -1;
> -	}
> -
[...]
> diff --git a/main.c b/main.c
> index 9610398..52dca97 100644
> --- a/main.c
> +++ b/main.c
[...]
> @@ -160,6 +161,9 @@ static struct globals *alfred_init(int argc, char *argv[])
>  		{NULL,			0,			NULL,	0},
>  	};
>  
> +	/* We need full capabilities to mount debugfs, so do that now */
> +	debugfs_mount(NULL);
> +
>  	ret = reduce_capabilities();
>  	if (ret < 0)
>  		return NULL;
> 

There were some return value checks for the debugfs_mount calls which you've
removed. Why isn't here some kind of check with error handling/warning, ...?

Kind regards,
	Sven
--nextPart2270391.VzILtGa2xY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW6+YqAAoJEF2HCgfBJntGveUP/2knzZuLFr9Ct0gb4dR+O3rF
TycWQFLEffi3rftl+QE+cl37xW+gBuJD7FsVZPbHgXhRSG6oEao8QN4GQFc8PRif
G3ZceIFJX8towpWFixNwFIiiMoxSqWofitGEY1PaRtbFvOTbgqCCo8euHaWXm1Af
o3FEf0e/TB7u9xdDuxodqeaazHJbRdccrumIzplZGpZP6pEzTTgeWRVHr+3PZmw7
BJDCKzf7g7+jXX8hK22EUWvB3f/AEI7ZFjLMx89qCL3ylPZFPVglUlb0xEBYMw5Y
E9SH5IUG+Z32wD4HeAY0bE9/LfKBeB1UPXSfDRmuUlQlnSz3fYbqwAC2HnOiMcVY
orJfVJSRwsl403Ms8X88JqfL/TSQOC3/35Ai7xUtFzTM2KCg+buekuf69kdfkCot
sanw3y5apfBEicCa/VVzUBraMzZs+jvLAW+It1WPVZBIpzgU7Czw0PvyBfoMcnPh
C8RVtWvS6P1Z0rMLtG3ICunK7Jx5GKfTNo8WyO1sGdjjTMAjn0vB5Z2JDEtXsk5y
o3E3zVoYmG+V+YztwCbTfHh3XiI2B/w6Xocq0NHxR5kCiemwBcsyJ+0FuWDgnIwZ
9MegLn+STyWvLNamkMbxoBWYAO4ufKr6H4F8EMKIdbF5NtC3Ngofe7YZnUTr3lAi
e8Ahw7Mh8MCZAlyJEsgP
=zBqK
-----END PGP SIGNATURE-----

--nextPart2270391.VzILtGa2xY--

