Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 10 Jun 2014 22:31:16 +0800
Message-ID: <4104095.3yN76RSeZP@diderot>
In-Reply-To: <1400933804-9661-1-git-send-email-sven@narfation.org>
References: <1400933804-9661-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6431021.7Y2pv9fW4G";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/6] batctl: Don't try to close negative
	file descriptors
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart6431021.7Y2pv9fW4G
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 24 May 2014 14:16:39 Sven Eckelmann wrote:
> Valid file descriptors are defined as being >= 0. Error codes returned by
> the socket functions are defined as being < 0. This isn't checked correctly
> through out the code and instead 0 is used as "not valid" file descriptor.
> 
> This can lead to functions like close being called with an error code as
> argument.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  functions.c  | 4 ++--
>  ping.c       | 4 ++--
>  tcpdump.c    | 3 ++-
>  traceroute.c | 4 ++--
>  4 files changed, 8 insertions(+), 7 deletions(-)

Applied in revision 2656408.

Thanks,
Marek

--nextPart6431021.7Y2pv9fW4G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTlxa0AAoJEFNVTo/uthzAVPEIAJbMlb0A5Kiby/1TNnwhgX0A
wb8vbmurhXdTLPKzLNKRFBsqy2I+6IcJDQ9FEB+2PyQo12+EBmutag5WZlglat7+
1tEsZkagef61l16jq6RBtR/7D88pL0daNdpPMZoRIN8u/EkBHWNnkOCtiEWVJvkb
cOHBjqOumhqr8aYpM9frAPcG0OOd4HdSqssb4cb9UoEv3sNJ3HJxO7dLHyq4P+16
gmMzcO1su0ZukoS4lUcpmky97qW2t3NptG9snp21xz8wGdrav1d9PxY9ti1e2Qtn
0L0FsykzuuzrS7bW90D5yacinvnX7x6M/9ZrZXJ8HdtusSm+TKE1zFWFIvAnpT0=
=8mlz
-----END PGP SIGNATURE-----

--nextPart6431021.7Y2pv9fW4G--

