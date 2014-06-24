Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 24 Jun 2014 23:22:41 +0800
Message-ID: <4594996.Z6hYgccWMK@diderot>
In-Reply-To: <1403531736-12460-1-git-send-email-sw@simonwunderlich.de>
References: <1403531736-12460-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8514800.DF6HfxcZpm";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: drop QinQ claim frames in
	bridge loop avoidance
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


--nextPart8514800.DF6HfxcZpm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 23 June 2014 15:55:36 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> Since bridge loop avoidance only supports untagged or simple 802.1q
> tagged VLAN claim frames, claim frames with stacked VLAN headers (QinQ)
> should be detected and dropped. Transporting the over the mesh may cause
> problems on the receivers, or create bogus entries in the local tt
> tables.
> 
> Reported-by: Antonio Quartulli <antonio@open-mesh.com>
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PATCHv2 (thanks Marek):
>  * move check into bla_process_claim() to avoid code duplication
> 
> Changes to PATCHv1 (thanks Antonio):
>  * add short description, fix capitalization for return
>  * move drop debug message to batadv_bla_process_claim()
> ---
>  bridge_loop_avoidance.c | 44 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 10 deletions(-)

Applied in revision 8cd753e.

Thanks,
Marek

--nextPart8514800.DF6HfxcZpm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTqZfMAAoJEFNVTo/uthzA6PQIAJMLA2WQO/KOEkCpttPSzqrQ
0m/NCPd51hwPk8MqD7LuKHD1CD07ZCJB5RTmlGt23PyUtGVig6a77/wX/bpUk+lE
6lpveVPZYD7WKiYGXA+Bu5tZFykTojWVdGUZgb0D95HDiuvwxQlL/ey8Lk/eyrtY
WK6+9RB58QP9QFNHURwSCydfBjEzx4oTWVeWJZOsCnPmwKuAMJe60umKAvLHgJd6
TVh2Ev6H7Y9x+sfJEYnFtPy/k4f2owbySc0iXYbkJtwiKoPysbfQHQ+kNKuG5r7D
CKswegPdHxyVhvW2tu4s7bdUAuNSTs8e9LFP/Z7BcAnGFa76DQZqAVcWpLHNr/E=
=XY0K
-----END PGP SIGNATURE-----

--nextPart8514800.DF6HfxcZpm--

