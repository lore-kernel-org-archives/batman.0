Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:27:54 +0800
Message-ID: <8117036.Amiy5tiUc8@voltaire>
In-Reply-To: <1468597173-25378-8-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-8-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1911638.Eqt7Ytxthl";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 08/18] batman-adv: Place kref_get for
	tt_common near use
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

--nextPart1911638.Eqt7Ytxthl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:23 Sven Eckelmann wrote:
> It is hard to understand why the refcnt is increased when it isn't done
> near the actual place the new reference is used. So using kref_get right
> before the place which requires the reference and in the same function
> helps to avoid accidental problems causedy incorrect reference counting.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - split patch based on type
> 
>  net/batman-adv/translation-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 3cf4d0b.

Thanks,
Marek

--nextPart1911638.Eqt7Ytxthl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjeSKAAoJEFNVTo/uthzAoRAIALfdYdWQyj8VqsoHvqxtDCdY
IjltgadNkhQSowpzAcmgwb+v4u1hM2bWHtFvd28nGFF3Zhjgt+UbBIh5GfZ5+wjz
clCiMgcl/sDkGFWNYqM4Cl3vuEwD+hafgMXebRx7Pt1hey/AleuDZruBd8X/kK/v
hxpEp2A7aXeK8mBUDmXBDodx7dncjtTn1eBuT4wcluw6cBVq9YJTuYz0b+yCahv6
S1c7sEGSkzbrOO84tyGN3vu3EZ+gqb5+kkomrqWHpIkyzqcc8Z8yzIdUnLnvQHY4
FTjqT6/OcNI1f6dSYPhJThqzB66mG62HzpiNMnwb/+ogB+b1p4UFwIDz2K1iYsg=
=CzLd
-----END PGP SIGNATURE-----

--nextPart1911638.Eqt7Ytxthl--

