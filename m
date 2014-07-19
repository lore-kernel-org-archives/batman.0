Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 19 Jul 2014 17:42:45 +0800
Message-ID: <1940268.8Olz7L8dIY@diderot>
In-Reply-To: <1403768840-2926-1-git-send-email-antonio@meshcoding.com>
References: <1403768840-2926-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5511088.S3Xp8GMvjL";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: tcpdump - parse TVLV containers
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart5511088.S3Xp8GMvjL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 26 June 2014 09:47:20 Antonio Quartulli wrote:
> @@ -83,6 +82,7 @@ static void tcpdump_usage(void)
>         fprintf(stderr, " \t\t%3d - batman unicast packets\n", DUMP_TYPE_BATUCAST); 
>         fprintf(stderr, " \t\t%3d - batman broadcast packets\n", DUMP_TYPE_BATBCAST);
>         fprintf(stderr, " \t\t%3d - batman fragmented packets\n", DUMP_TYPE_BATFRAG); 
> +       fprintf(stderr, " \t\t%3d - batman unicast tvlv packets\n", DUMP_TYPE_BATUTVLV);
>         fprintf(stderr, " \t\t%3d - non batman packets\n", DUMP_TYPE_NONBAT);
>         fprintf(stderr, " \t\t%3d - batman ogm & non batman packets\n", DUMP_TYPE_BATOGM | DUMP_TYPE_NONBAT); }

Manpage and README update ?

Cheers,
Marek

--nextPart5511088.S3Xp8GMvjL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTyj2ZAAoJEFNVTo/uthzAsXcH/j951Ym/WJAzNIKbFEsUMwJC
zM7146roq5kHnSABqfdeoD+wXhZCGVUTb0SpZvLWzp5htDIeEu/0z+SXtR9bFnhB
6Q/SCEfw0yIYKR30sDmUM0PsdLW5osHO1zZEgb8mTt1xPmIs691ogsBBs+fRpmdb
IRixAZHaAznDNcTUrWGgCQsdgWaCy1nKmy7T2NnqNEFNA02ltfftgGcJDC+yIBkG
+u9uShGSuSD0AHySplWtPisbDEr5mFuhUmuHn5PdhbkFT7KkX4AxY5Mx+pZkWuVN
UkuoVBkwJvWtMpnJPeg6Hz4b1o/5V4s0vd2Wa5PAH8qKk5iuWDxu64zDoWioPNg=
=8pC4
-----END PGP SIGNATURE-----

--nextPart5511088.S3Xp8GMvjL--

