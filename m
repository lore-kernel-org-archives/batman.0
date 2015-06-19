Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 19 Jun 2015 17:22:04 +0800
Message-ID: <14493069.QjiBVbGmUn@voltaire>
In-Reply-To: <1434615999-17185-1-git-send-email-mareklindner@neomailbox.ch>
References: <1434615999-17185-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1942507.gQpi9feGVA";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: update kernel doc of
	batadv_tt_global_del_orig_entry()
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


--nextPart1942507.gQpi9feGVA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 18, 2015 16:26:39 Marek Lindner wrote:
> The updated kernel doc & additional comment shall prevent accidental
> copy & paste errors or calling the function without the required
> precautions.
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
> v2: rebased on master
> 
>  net/batman-adv/translation-table.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Applied in revision 8e53ad5.

Regards,
Marek

--nextPart1942507.gQpi9feGVA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVg98/AAoJEFNVTo/uthzATBgIAInOXe+myGUXTEo6aTVLsR1T
/eVwzbBKPoqUtsdIWlEGVF/a4xMTWGWpA48k0EftjS0KRAswIPmcsXb9WG3/bnuo
9GwcojaeEiLS3ryXm8feiSCQjr7QFyC/2kOmG56lFWrQgyRs3Xmu5E9Wee4PLA/f
Luh9c3Yf/3HAf3ZdVPWyhea6UG8nLkEynxK0XkfCrmoTCcTPDARi+tMFETOvySJk
YNfOqPwTS+clF/5DCHLhg2TPKLuwzeUkHfgaNiVv9kWnG4ei4P1pYKzWYIE7/HgD
q8GHSbjzg+H4WXgyAmBAIwuPHfYzDXtTnbVie8QWROjERZgts5NYHBVCGcKqplI=
=a/4K
-----END PGP SIGNATURE-----

--nextPart1942507.gQpi9feGVA--

