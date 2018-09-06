Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 06 Sep 2018 20:03:42 +0800
Message-ID: <6353214.MYpFiXBgWn@rousseau>
In-Reply-To: <20180812190445.28013-5-sven@narfation.org>
References: <20180812190445.28013-1-sven@narfation.org>
 <20180812190445.28013-5-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3374071.DoJ0dOzUH8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: Prevent duplicated
 global TT entry
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart3374071.DoJ0dOzUH8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 13 August 2018 03:04:44 HKT Sven Eckelmann wrote:
> The function batadv_tt_global_orig_entry_add is responsible for adding new
> tt_orig_list_entry to the orig_list. It first checks whether the entry
> already is in the list or not. If it is, then the creation of a new entry
> is aborted.
> 
> But the lock for the list is only held when the list is really modified.
> This could lead to duplicated entries because another context could create
> an entry with the same key between the check and the list manipulation.
> 
> The check and the manipulation of the list must therefore be in the same
> locked code section.
> 
> Fixes: c5eb5bb30321 ("batman-adv: add reference counting for type
> batadv_tt_orig_list_entry") Signed-off-by: Sven Eckelmann
> <sven@narfation.org>


Acked-by: Marek Lindner <mareklindner@neomailbox.ch>

Cheers,
Marek

--nextPart3374071.DoJ0dOzUH8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAluRF54ACgkQU1VOj+62
HMDosgf/VQbeU2+zpl4F3q8Q5/tX0InUTqy4IG7hk6TG7nfEtqUM+62w6RyTRSOU
LsLUd76AC8vrOJl7NdWYVCAyDab4U7N40mPAiqlmQ7t2W8ShzIzj3FxgDRS242Rg
TmRVPqQWSCMQaq4OwzW8hw39B8zFS3E5/OfnfH21ML9vaQ2svcmN6PiBVAJLsL1G
B0cbExCKyuBWf4I3NnZRFb5v2ktkA9LFY+23vm7h24rQhAu5w8UZB05go240ZS+B
UzESmXKq004WFH0qNbsJD8++nTmXwjk2yn6tzzt3f4afyvhx+wyT/5v6/dhEJ5xq
uoiPTDoS08EI0PIrWfyfV6UsjNs5OQ==
=W6Na
-----END PGP SIGNATURE-----

--nextPart3374071.DoJ0dOzUH8--



