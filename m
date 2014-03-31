Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 31 Mar 2014 17:32:29 +0800
Message-ID: <2811984.s0Lsuv0XOW@diderot>
In-Reply-To: <1395845184-15186-5-git-send-email-sw@simonwunderlich.de>
References: <1395845184-15186-1-git-send-email-sw@simonwunderlich.de>
 <1395845184-15186-5-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1676084.3bQHQKfMVP";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv3 4/4] batman-adv: fix removing
	neigh_ifinfo
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart1676084.3bQHQKfMVP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 26 March 2014 15:46:24 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> When an interface is removed separately, all neighbors need to be
> checked if they have a neigh_ifinfo structure for that particular
> interface. If that is the case, remove that ifinfo so any references to
> a hard interface can be freed.
> 
> This is a regression introduced by
> 9bb33b8d88e318c4879d37d06ad28e3e018b9036 ("batman-adv: split tq
> information in neigh_node struct")
> 
> Reported-by: Antonio Quartulli <antonio@meshcoding.com>
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  originator.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)

Applied in revision 9b9cdbe.

Thanks,
Marek

--nextPart1676084.3bQHQKfMVP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTOTYtAAoJEFNVTo/uthzAvtkIAKe6l2G4XaYqWNrXxTeuzaom
sPkLCROCaY5EUMqZ3vIzhOkb1qE9sFJOCsBboPCGB6sBcIOfpDJWqTyyif3iyJKv
D6XpWcsGRToT6q77iAoq4pejY1lsgYTtvh6IRvcdCnDfjI0GrN62L4N8cszZHrLr
DX2yUl/odLtg4V8HzNXBSDjXmJx+jWhRq5ujujEQP6eDzus7eVL6xxx7LIESwdKr
bevIpfYJQxT2QAMYeR4iO17vUqCpaeR0ska5ZXWQotBRjMbFnpCz94/RMhnSL5Ll
TvdNtdd3qNxUTxvCsNVnYh3KoOu1V8zj4ynXUspNIsl48aYnQX8bEE5TujTeXTg=
=MQCN
-----END PGP SIGNATURE-----

--nextPart1676084.3bQHQKfMVP--

