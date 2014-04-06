Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 06 Apr 2014 21:56:03 +0800
Message-ID: <1560921.Pl6C3c0d1b@diderot>
In-Reply-To: <1396420055-19598-1-git-send-email-antonio@meshcoding.com>
References: <1396420055-19598-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1666128.Ht68PPnHPT";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 maint] batctl: tcpdump - fix IP header
	parsing
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


--nextPart1666128.Ht68PPnHPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 02 April 2014 08:27:35 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Fix the IP header parsing by properly converting the source
> and the destination addresses to strings.
> The problem is given by the fact that inet_ntoa() uses a
> static buffer to store its result, therefore it cannot be
> invoked twice in a row without saving the first outcome.
> Moreover inet_ntoa() is deprecated in favor of inet_pton().
> 
> Introduced by 35b37756f4a3a230bf7941034d9da178ee5b4948
> ("add IPv6 support to tcpdump parser")
> 
> This patch also slightly beautifies the code.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
> 
> Change since v2:
> - fix commit subject
> 
> Change since v1:
> - print all errors on stderr
> 
> 
>  tcpdump.c | 73
> ++++++++++++++++++++++++++++++++++++--------------------------- 1 file
> changed, 42 insertions(+), 31 deletions(-)

Applied in revision f08a28d.

Thanks,
Marek

--nextPart1666128.Ht68PPnHPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTQVzzAAoJEFNVTo/uthzApqAIAMQoDcOP+JOgHgZVVa+xfafN
VpH6ISuo7w8cltqEpVKdV9yp7Fu36o8tNDg4hdVOXh7r4c2NpA2P+Yx7gAVpND6o
Q/6OTUbINLhCqcsY/xbjcqZC9z7fr8h9pi93J8z3xPHbztOqBoulRQ0MkzXXdHEH
PUHqAXA6wJf4TIZTzkUh/PRhDgHwzPmTy+k2rUK45nrl3qFns9TOzLG7ThHOeYIp
A/4bGIJ240he1HqK9ld4oHaUKR/1gCnGrJX66un3hGR1pD8KKd04pgZx8WnC/RfM
8OLK2NFHZfx4cA81FfrypV8H8oZ7JXJPOSjFC/L1GKWjG9AGtaaM+oNJA1VGkAQ=
=UpHj
-----END PGP SIGNATURE-----

--nextPart1666128.Ht68PPnHPT--

