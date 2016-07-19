Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:30:15 +0800
Message-ID: <22257792.zOauPVQjO9@voltaire>
In-Reply-To: <1468597173-25378-10-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-10-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4679553.dYAZHycmBg";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 10/18] batman-adv: Place kref_get for
	bla_backbone_gw near use
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

--nextPart4679553.dYAZHycmBg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:25 Sven Eckelmann wrote:
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
>  net/batman-adv/bridge_loop_avoidance.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied in revision c7cdcc9.

Thanks,
Marek

--nextPart4679553.dYAZHycmBg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjeUXAAoJEFNVTo/uthzA60kIALdMhXYYPJkSgpi1846xBc1U
C1c+v1CDEVa77Bls4AucRh6PL+hxnbWTXqbpTuBFE6PtqLGG0v4odFGx3w9EYCU4
qxgAVpRoJdMQA4buAJbZLxUpyKqyu6ieQH8XYMVZjMSJHon3XozjQ58Qnfyz7Ju7
hPF45WVXyNbGm7f2egxsUuh76+b/73dm0xlHM9MtgFYKJYIQbZOe7WzECzQ6YzKm
ydCtvT1Lm8dwONIqYr4ogB7L3O7576Mq5DrDls/p6quqDP5FkyIEsrdJTphDjkvD
wpKeo9ZpxXn5TtEICLHN+p7owPYka2+sW81i6bWbtdRMcGFi09iS5H7S+UKHqOQ=
=PIAR
-----END PGP SIGNATURE-----

--nextPart4679553.dYAZHycmBg--

