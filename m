Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 29 May 2016 23:05:36 +0200
Message-ID: <28718966.WyUMUFbf0J@sven-edge>
In-Reply-To: <1464553842-4680-1-git-send-email-sven@narfation.org>
References: <1464553842-4680-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4210677.WAf0EiH4OK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix use-after-free of
	tt_req_node
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc

--nextPart4210677.WAf0EiH4OK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 29 May 2016 22:33:39 Sven Eckelmann wrote:
> The tt_req_node is added and removed from a list inside a spinlock. But the
> locking is sometimes removed even when the object is still referenced and
> will be used later via this reference. For example batadv_send_tt_request
> can create a new tt_req_node (including add to a list) and later
> re-acquires the lock to remove it from the list and to free it. But at
> this time another context could have already removed this tt_req_node from
> the list and freed it.
> 
> This can only be solved via reference counting to allow multiple contexts
> to handle the list manipulation while making sure that only the last
> context frees the list.

Marek please replace the "frees the list" with "frees the object". I can also 
resent the patch if you want to.

I will not resent it today because maybe Antonio or someone else still has 
some problems with the current version.

Kind regards,
	Sven
--nextPart4210677.WAf0EiH4OK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXS1mgAAoJEF2HCgfBJntG84UP/jaTGHhIMujmaA3E21hanWp4
8KzEdnjyp5Sn/MHe0kQAwPCcFfI6dQRrTv5PgkGGvNFLTaCVVrXeGL3YnlsnQGjz
65WewCZWBD5NvEqhHqxV9/XJi0WIvwMznixKDFZDKar364Mpp5+51JNDjfc91EDI
V5DjILlFlt3j1MdCTeFaO8asWekV5VJGihIK6XcCBEl0D7qRW6F1Y6YTXBXJVRvN
IreBo9A1ufUKuiROjWTzAOQKFh2rj9YevB8kUc+HU+IvbFBzbH0OSH3FjkOWifeu
ZLBuiZLhSOi/i9rMPygFzL3JE674Jhiww5yK8TXWq6rI5VuV0K0XNYGDfL2OkzvL
QfG9ZzfphntcsgimEZmpstmlly48njjbZdn+O10g239gGq+YZ6/MYtjJIHt7wEsU
6AEEyXGVjmP05V8rHuXRHeBIPrgobyZpJ2GTWurchl/d5TgJB50HjQuTVbCyXNn8
oB2qOKqj+Tv1cSgSizkTLgPyHKgKEwLoG7wJ7R2oofKhkTI2quYmgryW37dAUB96
zfF95UraVgQzaIh4vzjyPnA9Wz1BTKBYe0/5l0BgiwlaAeIzX8gDFDNqnhUIxGVR
I2q8G63WjhWGrjnuLbhOkbPcLP6qy5p+rqsc262xxl9Gy+Yh2a3BxYt22u5zZOJj
f++nrBipUxeJhBdLVD10
=axzJ
-----END PGP SIGNATURE-----

--nextPart4210677.WAf0EiH4OK--

