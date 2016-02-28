Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Feb 2016 07:21:11 +0100
Message-ID: <2071375.zp131KsAS3@sven-edge>
In-Reply-To: <2259545.lEtA3AoCDO@voltaire>
References: <23488110.8Oiix784PY@sven-desktop> <2259545.lEtA3AoCDO@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2869686.CSGPPeJg8c";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Patchwork on open-mesh.org
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2869686.CSGPPeJg8c
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 28 February 2016 12:43:27 Marek Lindner wrote:
[...]
> A few questions as to how this works:
> 
> * [PATCH] MAINTAINERS: Add patchwork URL for BATMAN ADVANCED
>  -> Manually marked as 'accepted' as it won't be easily detectable as
> merged. Correct ?

Correct.

>  * [B.A.T.M.A.N.,2/2] batman-adv: Split batadv_iv_ogm_orig_del_if function
>  -> Merged patch today but still shows up in patchwork. Should we wait for
> the auto-detection or did I do something wrong ?

I've created this patch in a way that it was better readable for you but not 
detectable by the heuristic, So I've expected it to not be detected.

Marked it manually as accepted

>  * [B.A.T.M.A.N.] batman-adv: Fix integer overflow in batadv_iv_ogm_calc_tq
>  -> Marked as opened but has been superseded by '[B.A.T.M.A.N.] [PATCH]
> batman-adv: Fix integer overflow in batadv_iv_ogm_calc_tq' that was merged
> today ? Shall I mark as 'accepted' ?

I would have hoped that the heuristic gets this one but it didn't. Most likely 
because the position changed to much (but this is just a wild guess). I've 
marked it as accepted.

Kind regards,
	Sven
--nextPart2869686.CSGPPeJg8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW0pHXAAoJEF2HCgfBJntGA68QAIYzhP+XauRgLQs+gYF7h+ni
Xd+PcrRVUIS5QXPFm7jQS5CFfbeOxqJN7GEJd/gTxRanksKinBoJhH3f5s2Adbdw
t1fUOfbsF9mpavxP+wx02r9M9W8k7gaTeIQNFtmK9fqlrrZ7KhyNf2zA1JArsO9U
sgM3W991InYUyR3U1QNpAPK93mh2HRDCojVkHpbX/nmUd68aHwPbP18riQkl6Uuf
A3iHks5bqjMWGZOjPWhWUmczOOtbSSLIlewh66d0FNJK9tqWx4YIziUZe6SiIEnv
bCX+kmjHKPfVqc7+8ygSI7L3vE7EkqqtUDl+rffrKN2izJPUSZ90RMhRJ7u9yTal
c0RRVv/Gw0E+dUMjBeTAOVO5tiQTh394DHHqr4+94nvHRBBth8oX2tjBRfY1X6Ok
QCtRzzD/WjLFcB+YFMsGEPuqO3Pkf5J8hn3UyS4ZRqYTmATri9zoHg5uPlnp7kGS
WF6N6gsNXe/GlWxzZw9ghCzu3YHy1QzSgkaij0TFuV696jhPRsnSiWalUpp8q0qD
t1/0p6HmJo2Ylf9dF5SsNmVCl2AUo0WiWde+VPpcY7E2oQZDqR4j6ZFM/cbJO5ee
OTxg9dNNo+N/iG2Y20hy9bu7rT7bMSGN4sDvDB1pn8s6f9igIGM13xFof0TF16ej
OblUlyEecx5Xoa/T69CA
=3Z78
-----END PGP SIGNATURE-----

--nextPart2869686.CSGPPeJg8c--

