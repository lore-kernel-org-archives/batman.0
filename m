Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 03 Aug 2015 20:00:42 +0200
Message-ID: <3503158.kbfCh64iFS@prime>
In-Reply-To: <1437857863-28742-1-git-send-email-mareklindner@neomailbox.ch>
References: <1437857863-28742-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart29362545.hSpDYM3RPH";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: move neigh_node list add
	into batadv_neigh_node_new()
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--nextPart29362545.hSpDYM3RPH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 26 July 2015 04:57:43 Marek Lindner wrote:
> All batadv_neigh_node_* functions expect the neigh_node list item to be part
> of the orig_node->neigh_list, therefore the constructor of said list item
> should be adding the newly created neigh_node to the respective list.
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Cheers,
   Simon

--nextPart29362545.hSpDYM3RPH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlW/rEoACgkQrzg/fFk7axZUqwCgu8B0RDLwcZTy4/V/Xh8jgLj/
2oMAnRoFKtGLfRuidsf9VNjN4dGYYBVB
=SJKM
-----END PGP SIGNATURE-----

--nextPart29362545.hSpDYM3RPH--

