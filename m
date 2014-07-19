Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 19 Jul 2014 17:55:10 +0800
Message-ID: <4241339.R1AseYFMhf@diderot>
In-Reply-To: <1405391008-5112-1-git-send-email-linus.luessing@web.de>
References: <1405391008-5112-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2575761.gEh0GdyBy9";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batctl: adding multicast debug level
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


--nextPart2575761.gEh0GdyBy9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 15 July 2014 04:23:27 Linus L=FCssing wrote:
> @@ -280,6 +280,7 @@ static void log_level_usage(void)
>         fprintf(stderr, " \t bla     Messages related to bridge loop
> avoidance\n"); fprintf(stderr, " \t dat     Messages related to arp
> snooping and distributed arp table\n"); fprintf(stderr, " \t
> nc      Messages related to network coding\n"); +       fprintf(stder=
r, "
> \t mcast   Messages related to multicast\n"); }
> =20
>  int handle_loglevel(char *mesh_iface, int argc, char **argv)

We have a little section in the manpage dedicated to the loglevel which=
 also=20
needs an update.

Cheers,
Marek

--nextPart2575761.gEh0GdyBy9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTykCCAAoJEFNVTo/uthzAQ9kH/R7UvEAS+LmhHMy+BaHBLutE
MoAfE+dwpeac6Vk5swM5fhjnkqIvf6UjmohJOq+LYvn7AlLgEwnrphw4YhSLHwFS
KfX+4otoc0swlbE48F+kC+9Wvnhgxix/mdsqXQ9Q84o73FfYyPlL6GVlWQIpeOXi
jQLdfiUB4o3wvY+OucuiaqwulmUhf98H+wcyExlxwZWcRyiksDh1bcKq8oEomeJV
ra5g1bH9+COsJ/4ByA8LkN6HxJH/b5BHxsm4dnQypR2cczgzZy9aHk0s5dYv7fbJ
Kr9z1GWxRpUtPYCTSwuNCMvviJOuyKS2rEdMjTkdK1rINGg9JhxSF5NU9Lt8nx8=
=1vfI
-----END PGP SIGNATURE-----

--nextPart2575761.gEh0GdyBy9--

