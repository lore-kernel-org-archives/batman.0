Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 29 Mar 2014 20:01:42 +0800
Message-ID: <5441853.F2AZZ3bXcj@diderot>
In-Reply-To: <1395845184-15186-2-git-send-email-sw@simonwunderlich.de>
References: <1395845184-15186-1-git-send-email-sw@simonwunderlich.de>
 <1395845184-15186-2-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2384924.kQBOAQF4uq";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv3 1/4] batman-adv: fix neigh_ifinfo
	imbalance
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


--nextPart2384924.kQBOAQF4uq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 26 March 2014 15:46:21 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> The neigh_ifinfo object must be freed if it has been used in
> batadv_iv_ogm_process_per_outif().
> 
> This is a regression introduced by
> 9bb33b8d88e318c4879d37d06ad28e3e018b9036 ("batman-adv: split tq
> information in neigh_node struct")
> 
> Reported-by: Antonio Quartulli <antonio@meshcoding.com>
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  bat_iv_ogm.c |    2 ++
>  1 file changed, 2 insertions(+)

Applied in revision a424cd5.

Thanks,
Marek

--nextPart2384924.kQBOAQF4uq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTNrYqAAoJEFNVTo/uthzATQYIAMQSSyAs63GQlscJUWS2E4bl
dncCZc4dATREnZubaE/rQ7I8jSFazTj7J+J2wQIFS72bFWGg5a1U55oQlcdpuSk9
lmAF6CHf49FHk9v5+jiJoJEbDptFI6u0YdPUquQvv5JJARCT1MeFImtwaI6wmxDW
O3+YE0XtjW6IRUOUCtC2EUsBUITyLiRYqYyiZb536Jik0EYdbkwrZrsESYRbDwok
kE8MVTR/MPtAOzmLYaYA+gRxFOveXJhnnY6TrrEVwEUJO/k7tRth776joaZwh79i
ANpfxCguM5nM/5BnZnkBG22lY6MsuP+qlnwVW8dUAZZ1Yb693t3CliyGAzS4F2Y=
=PziA
-----END PGP SIGNATURE-----

--nextPart2384924.kQBOAQF4uq--

