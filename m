Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 03 Aug 2015 20:01:30 +0200
Message-ID: <3944293.0zRb5b9TWb@prime>
In-Reply-To: <1437856635-27068-1-git-send-email-mareklindner@neomailbox.ch>
References: <1437856635-27068-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14246665.cCmQsYKaAT";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: move hardif refcount inc to
	batadv_neigh_node_new()
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


--nextPart14246665.cCmQsYKaAT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 26 July 2015 04:37:15 Marek Lindner wrote:
> The batadv_neigh_node cleanup function 'batadv_neigh_node_free_rcu()'
> takes care of reducing the hardif refcounter, hence it's only logical
> to assume the creating function of that same object
> 'batadv_neigh_node_new()' takes care of increasing the same refcounter.
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>


Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Cheers,
   Simon

--nextPart14246665.cCmQsYKaAT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlW/rHoACgkQrzg/fFk7axYSJQCdFhJ15BLd7lBC1bbK8YNzE13U
X/gAn2mnHOsvk5BLuMl5/sEbjpTxMixf
=H6ws
-----END PGP SIGNATURE-----

--nextPart14246665.cCmQsYKaAT--

