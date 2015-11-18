Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Nov 2015 16:43:57 +0800
Message-ID: <2031837.icG7cEfVUX@voltaire>
In-Reply-To: <1447836101-17282-1-git-send-email-sven@narfation.org>
References: <1447836101-17282-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart111373230.MsB5ayagH5";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix variable declaration
	warning in batadv_compare_tt
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

--nextPart111373230.MsB5ayagH5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, November 18, 2015 09:41:41 Sven Eckelmann wrote:
> checkpatch is warning about the wrong way a pointer is declared in
> batadv_compare_tt.
> 
>     ERROR: "foo* bar" should be "foo *bar"
>     #80: FILE: ./net/batman-adv/translation-table.c:80:
>     +   const struct batadv_tt_common_entry* tt1 = data1;
> 
> Fixes: af5fa950cbb6 ("batman-adv: fix erroneous client entry duplicate
> detection") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/translation-table.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Good point! Applied in revision 5019fc0.

Thanks,
Marek

--nextPart111373230.MsB5ayagH5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWTDpNAAoJEFNVTo/uthzAu8oH/iwAOGV4T0UBdif+FW89F17C
1y7WDplryuzJJXkuyd4gHY/rjyE2iDlxguXA0ZoQE0iKuhr8oJcrZ99y6FXwPldB
L6JKrp2vNBgtpFo8NaJPBKYqBe9V8+LSryfOXmM1GRPdJkMo+u5EDYaLZ2vRCrqY
RpzUkfdNVQvcv/Wxh8PIr1+D7qbyBboA6ItB67V7aWxNnxHh/793oXRm7sWabpeh
y7fvzIGVL7rGE3U2j2s2msxL0xVtA+WigtmjogRnbAjk9J4/VDYQoBoKb6s6jL2I
NZ10NKgPLujJFA/fVgKN3RM64dFdmT28C5sIYzA7IaLUDUQ1KCZEzrifTNxuN3g=
=F/Ie
-----END PGP SIGNATURE-----

--nextPart111373230.MsB5ayagH5--

