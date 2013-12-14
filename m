Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 14 Dec 2013 17:39:21 +0800
Message-ID: <3543660.ogTEPaiZir@diderot>
In-Reply-To: <1386253980-2415-1-git-send-email-antonio@meshcoding.com>
References: <1386253980-2415-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3317889.9amj85V2MU";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 next 3/4] batman-adv: fix size of
	batadv_icmp_header
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


--nextPart3317889.9amj85V2MU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 05 December 2013 15:33:00 Antonio Quartulli wrote:
> struct batadv_icmp_header currently has a size of 17, which
> will be padded to 20 on some architectures. Fix this by
> unrolling the header into the parent structures.
> 
> Moreover keep the ICMP parsing functions as generic as they
> are now by using a stub icmp_header struct during packet
> parsing.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
> 
> Changes from v2:
> - readded comment next to msg_type memeber
> 
> 
> 
>  main.c    |  4 ++--
>  packet.h  | 40 +++++++++++++++++++++++++++++++++++-----
>  routing.c | 14 +++++++-------
>  3 files changed, 44 insertions(+), 14 deletions(-)

Applied in revision 6d80786.

Thanks,
Marek

--nextPart3317889.9amj85V2MU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSrCdNAAoJEFNVTo/uthzA0yEH/2UJcfVJWNQkMJGu0tYrCrc1
j73wfZORFWunw5qEUp7rUet7PF5BjTDuLNfzxBYkCPThSjZKOqW1HAlOWUjHfbJG
F/hgjL9LBJlwIyfB5ZnQGckZe5I0bjWCJgs/k7tSxQPyXAVj+G9+3UqqaJu8A+VO
j+gZWUkbjHH1vEKzgnrAglOcF8vHdUx/VzPxWqY7/EaZpSpyXHUqCmkgeqRIAXuK
PpyadgdSoCxpv+xuAgWfTCE5KgSlrgBX4YUht2tNSJeH4Mkxuij/infmWz3i6IGo
lWnjv2R1QeQYSyv4FlPPsbz7eRDLrkH7tkE5xnjKqvYGNwqQNT6hCnNVxPOhyqQ=
=O5lm
-----END PGP SIGNATURE-----

--nextPart3317889.9amj85V2MU--

