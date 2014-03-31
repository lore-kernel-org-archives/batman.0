Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 31 Mar 2014 17:25:50 +0800
Message-ID: <5468004.G6ibnGco9T@diderot>
In-Reply-To: <1395845184-15186-3-git-send-email-sw@simonwunderlich.de>
References: <1395845184-15186-1-git-send-email-sw@simonwunderlich.de>
 <1395845184-15186-3-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6111068.OeO2Pq1djP";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv3 2/4] batman-adv: fix neigh
	reference imbalance
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


--nextPart6111068.OeO2Pq1djP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 26 March 2014 15:46:22 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> When an interface is removed from batman-adv, the orig_ifinfo of a
> orig_node may be removed without releasing the router first.
> This will prevent the reference for the neighbor pointed at by the
> orig_ifinfo->router to be released, and this leak may result in
> reference leaks for the interface used by this neighbor. Fix that.
> 
> This is a regression introduced by
> de6bcc76ea84fecb136f8c8f5ba1862e4a13f06b ("batman-adv: split out router
> from orig_node").
> 
> Reported-by: Antonio Quartulli <antonio@meshcoding.com>
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> 
> Changes to PATCHv2:
>  * take care of the rcu sparse warning
> ---
>  originator.c |    5 +++++
>  1 file changed, 5 insertions(+)

Applied in revision cdd09f6.

Thanks,
Marek

--nextPart6111068.OeO2Pq1djP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTOTSiAAoJEFNVTo/uthzAvXIH+QHN8UwOTL1VJMlsg7KPNxLi
/b/zQ1NiQxYV/zXtNGDhQbX59Nphz5c6RlmXaKbW8hWorgvN+aJVIcPsPyjLW7yd
zzas2yQLdZgjLntwlg5ZZPTygoGAlIsze5s/hZh6zxof4+Azqtdfg32WjtU9aEdp
oDTzKAT3eTvHrcVBk3Zeyoz9q2aajH08uk6FuUclJNrPProVIJkS9L5NGSmOFin9
rQ4XuCXT76XnHicprpcfiM6rou7Y+tVY/qksdrC9h7EWUIVQgI4Y7Qzk8wR4Wtqo
FrNboJRryNkSUqH2mrYzyE8+EtS9jdRCXv/U/bkRo0WdsGmTirNy+ZXAKs2ry1E=
=pqJp
-----END PGP SIGNATURE-----

--nextPart6111068.OeO2Pq1djP--

