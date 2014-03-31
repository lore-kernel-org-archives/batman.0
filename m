Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 31 Mar 2014 17:42:26 +0800
Message-ID: <1834287.qPYedGCF74@diderot>
In-Reply-To: <1396110458-8608-1-git-send-email-antonio@meshcoding.com>
References: <1396110458-8608-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2425372.8v86mLARvn";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: fix local TT check
	for outgoing arp requests in DAT
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart2425372.8v86mLARvn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 29 March 2014 17:27:38 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Change introduced by d6bd8b36fa1f3d72a6fd5942a6e9bde6ddafcd0d
> ("batman-adv: make DAT drop ARP requests targeting local clients")
> implements a check that prevents DAT from using the caching
> mechanism when the client that is supposed to provide a reply
> to an arp request is local.
> 
> However change brought by 3e26722bc9f248ec4316749fc1957365c0fa5e4b
> ("batman-adv: make the Distributed ARP Table vlan aware")
> has not converted the above check into its vlan aware version
> thus making it useless when the local client is behind a vlan.
> 
> Fix the behaviour by properly specifying the vlan when
> checking for a client being local or not.
> 
> Reported-by: Simon Wunderlich <simon@open-mesh.com>
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
> 
> Changes from v2:
> - added reported-by clause
> 
>  distributed-arp-table.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied in revision 1c2e700.

Thanks,
Marek

--nextPart2425372.8v86mLARvn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTOTiCAAoJEFNVTo/uthzASDwIAIWK0dhrhyHxkn+or1XCCoHl
k0W+ZL8t7l+heWtkiY3hCm4mKXGFH0COQKlLqkll8asNM3kKiwMQYU+w496jFsJu
NiuSUDkM/Qe3lEwZns93oz14Y4WmNBTxv5muoWqK7U1zAgVq/20hwdOSB6P1eR3K
eKJ0ryfQ0omoRE7LKdnq+O9brgB71a/ECtRn+wy9DNuNCLZw9MuJXjgOYIjO94R5
Fa8xMV4OeITUwA9Rk4YukLtcfsCjUuO14ws9d2EC4YAHGG/rOW384ZSnZ6OQVSt9
/MLvC1G/yta3RtAVfYmZjSzHR6kbJxLbtlDkhSIzwKFmgI79NuyTjGw+j/3RZso=
=cETc
-----END PGP SIGNATURE-----

--nextPart2425372.8v86mLARvn--

