Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 01 Nov 2014 22:04:06 +0800
Message-ID: <1505444.drhKekJKjW@diderot>
In-Reply-To: <1409575049-32726-1-git-send-email-antonio@meshcoding.com>
References: <1409575049-32726-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2329135.5fB0hRs0Bu";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: checkpatch - else is not
	generally useful after a break or return
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart2329135.5fB0hRs0Bu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 01 September 2014 14:37:25 Antonio Quartulli wrote:
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  bitarray.h          | 3 +--
>  fragmentation.h     | 3 +--
>  network-coding.c    | 3 +--
>  translation-table.c | 5 ++---
>  4 files changed, 5 insertions(+), 9 deletions(-)

Applied in revision 6948dac.

Thanks,
Marek

--nextPart2329135.5fB0hRs0Bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUVOhWAAoJEFNVTo/uthzA5BQH/iuI78iDnbYPnAfDT5gv8pjk
hSZh3bSNJz+Q1VY3fQqOMgE3qP1KwLtB2nGaim/HN2WSmSqFcU0+6yDVt7r6Nt2v
9OyahjjcKAZpjvz0bNPyE5NKE+SdKUAGhpU+fzXp0VRCRdDheNWqXOtBDZfDzA66
0XOI+BSMm7/HWY3atHFoQnGZ+AV5KFINQlMxPq/MCoFeI8cawHnQUnsR1zRZwJ6u
CUfWaeipQXt2l5MzeGyL3i7vk9dhqIHxkERBiqvAUQDSkTsnmt69he0XG1+O7DKb
1Kg6mh9cGbfVwgePFSYWtJR0CerUSq0vLvAanHaey+Fhbz4tfhMV0P1Jk47oJwc=
=64Do
-----END PGP SIGNATURE-----

--nextPart2329135.5fB0hRs0Bu--

