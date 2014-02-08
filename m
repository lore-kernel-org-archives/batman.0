Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 08 Feb 2014 21:24:04 +0800
Message-ID: <9483212.4sKq0BcBlF@diderot>
In-Reply-To: <1390991112-2494-1-git-send-email-antonio@meshcoding.com>
References: <1390991112-2494-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2098368.1gMUU1BR4j";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: avoid potential race
	condition when adding a new neighbour
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


--nextPart2098368.1gMUU1BR4j
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 29 January 2014 11:25:12 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> When adding a new neighbour it is important to atomically
> perform the following:
> - check if the neighbour already exists
> - append the neighbour to the proper list
> 
> If the two operations are not performed in an atomic context
> it is possible that two concurrent insertions add the same
> neighbour twice.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
> 
> Changes from v3:
> - remove useless initialization
> 
> Changes from v2:
> - fix typ0
> 
> Changes from v1:
> - release hard_iface if we already have a matching neighbour
> 
> 
>  bat_iv_ogm.c | 22 ++++++++++++++++------
>  originator.c | 36 ++++++++++++++++++++++++++++++++++++
>  originator.h |  4 ++++
>  3 files changed, 56 insertions(+), 6 deletions(-)

Applied in revision e08e28f.

Thanks,
Marek

--nextPart2098368.1gMUU1BR4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS9i/0AAoJEFNVTo/uthzAUT0H/1vIvov+C7JrqMAyT/N1Kz1k
8+Dojkz/8eP8iesvtYvw/yyYh/CAF07ILX52QwCOkq3zgrKjGOsrL6iiNamjkSn/
XV8xU77/XUZLEfikMG73Jm6DDOiLDPFiG1aKBxxi2VxCM0hWcGIgnm9C4e7LZjqo
LH/LSbTy8MoTBKaEN8nnnHvsK/55ejtKqcqoiDd+hXTK6oJrYj5/lfamPDveG+aX
TyO46yzavsCF+4tdGLxqpq5+T3tqBF7ulvnQNRFU/fpgYcgoqOae91qvxdJJq4rR
StHaduft9sWLf+oI5UxV/k583yiqkUCYp2CG6UFzUnYEDJIUjzBOOC8RPs+B0Ug=
=FAVz
-----END PGP SIGNATURE-----

--nextPart2098368.1gMUU1BR4j--

