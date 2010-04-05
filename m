Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 5 Apr 2010 13:21:36 +0200
References: <20100405024603.GA11965@pandem0nium>
In-Reply-To: <20100405024603.GA11965@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart317641581.Dsvx5SefKh";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201004051321.45958.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Limit queue lengths for
	batman and broadcast	packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart317641581.Dsvx5SefKh
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Monday 05 April 2010 04:46:03 Simon Wunderlich wrote:
> Index: a/batman-adv-kernelland/send.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/send.c	(revision 1616)
> +++ a/batman-adv-kernelland/send.c	(working copy)
> @@ -382,12 +382,21 @@
>  {
>  	struct forw_packet *forw_packet;
>=20
> +	if (atomic_dec_and_test(&bcast_queue_left)) {
> +		bat_dbg(DBG_BATMAN, "bcast packet queue full\n");
> +		atomic_inc(&bcast_queue_left);
> +		return;
> +	}
> +

[....]

> --- a/batman-adv-kernelland/aggregation.c	(revision 1616)
> +++ a/batman-adv-kernelland/aggregation.c	(working copy)
> @@ -106,13 +106,27 @@
>  	struct forw_packet *forw_packet_aggr;
>  	unsigned long flags;
>=20
> +	/* own packet should always be scheduled */
> +	if (!own_packet) {
> +		if (atomic_dec_and_test(&batman_queue_left)) {
> +			bat_dbg(DBG_BATMAN, "batman packet queue full\n");
> +			atomic_inc(&batman_queue_left);
> +			return;
> +		}
> +	}

It should be possible to have multiple events accessing these functions at =
the=20
same time, or am I wrong?

Just say we have following situation (queue is full; full =3D=3D 1):

 * bcast comes in and we start add_bcast_packet_to_list  and
   dec_test(left) =3D=3D 1 -> damn, no room left for us
=2D> for easier understanding: someone steals our cpu or the processing is
    otherwise interleaved with following
 * another bcast comes in and wants attention (left is now 0):
   dec_test(left) =3D=3D 0 (because left is now -1... or 0xfff....fff). Let=
s enqueue
   it and do the rest
 * first bcast continues and and does atomic_inc(left) -> now it is 0
 * now a storm of bcasts comes in and all do atomic_dec_and_test... each one
    will be accepted because left is already zero and needs a looooong time=
 to
    be 0 again (or enough bcast packets were processed from the queue to get
   positive again)

I am not 100% sure if this really can happen, but I thought that it was a h=
ard=20
requirement for TCP port passed processor selection for parallel processing=
 of=20
incoming packets on multicore/multiprocessor architectures.=20

Best regards,
	Sven

--nextPart317641581.Dsvx5SefKh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLucfCAAoJEF2HCgfBJntGmzkQAMCzdc8kuYRqhGzXeyN9Y6uN
r5pPRTeIZLAQ14IAW77I9Bw0D6EOx5IuEzx3mLgqvTEihBnNoEaya7K11F7je5ka
Huq0T2bybxaXz+MffP3UbQRVOTuVsimG5MBOMRIxc1iV1muFOZe2QbIFjSjR4SgP
W9Rtw6e05zlePPNKJHRRYTfT/JQZ/fOFejy8t+aXCDbInMwsCWst0ZYIyQVxYWa+
3bEd9Q7DaIyUcEuW+jRI/I7Qg2ChLnYzJHGTOC6xfjPQbRa81uzTzOEZLBCzV6Cl
ei/24EDSdqHL8t+plZyUpvTRmSeaTSEKQj0KKzi/naOrUBmfe+euWcL39lH+wHDV
EMBZvl2G6RAQAkl7sTSn8MGDuk5FNAAvhmQixjPaYQYPbJtnh9m+LYh+7wd0VZ5U
nuaE5kDQZMhkw38QNlF5PQvNjWK/1uPUB/J7u4kZdl6IY3ZPbMzqzzhyqru2PXe7
+45x8xaVgGiQgLyJn1Zi4Mr+onTWRpIobE3o6Mo3FPmnN3T7ghB24WIxqIkJKtYJ
yUGsBGvPKlhbb898FE0aQhB02CBPjWseqnik6BAt+3Tcw3tUxK2hNrEMraPpifxf
WfXG6ui7/SEzGjpGm3qLMDpKtCjIkiUCtlQamysEummqsAOIB5/3vaXYR3qGV5BQ
ETNWXiMXC09M17kDVZtM
=41Gh
-----END PGP SIGNATURE-----

--nextPart317641581.Dsvx5SefKh--
