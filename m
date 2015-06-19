Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 19 Jun 2015 22:10:36 +0800
Message-ID: <11037423.aPWRDIAFsK@voltaire>
In-Reply-To: <1434646404-19291-6-git-send-email-sven@narfation.org>
References: <1434646404-19291-1-git-send-email-sven@narfation.org>
 <1434646404-19291-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1692982.p6ucylgKb7";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/6] batman-adv: Add missing include for
	clear_/set_bit in TT
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


--nextPart1692982.p6ucylgKb7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 18, 2015 18:53:24 Sven Eckelmann wrote:
> a51fa16ecf3f ("batman-adv: Make TT capability changes atomic") started to
> use use clear_bit and set_bit but did not add the include for these
> functions.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/translation-table.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision 5138e6a.

Thanks,
Marek

--nextPart1692982.p6ucylgKb7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVhCLcAAoJEFNVTo/uthzAnzgH/RYh1R6CMBh7gJQRT+BvyLGO
+InCJuP3IiM4rnrGTJH9Wf+LSzD7sTu7KBk9X8jCVqXvFrTkKmmeS6moCUuUf5OD
3nrLk9U6KdZoSvQAkY9YuqGiR6Ywca+Iqv1qGhNWhXkVPe+iyFcaO9RzmC7D7yPe
ngGclBLrPGt/6kCe6SCA93v33ogdgb2kacyHDzozYHYi5s7KecTOKGzjqpu5r4ab
zNgaadB3pmuuh9H5BYL13BFTd9RSoTgbziN5tw2G65gvjmt04CplT5FHyGeba3fL
6/sTiIUHWlizOegW9kYBItLAciuDCqgvgYTUbCI6u1z9M2S5Bum0+4ysTIT3vvE=
=91eb
-----END PGP SIGNATURE-----

--nextPart1692982.p6ucylgKb7--

