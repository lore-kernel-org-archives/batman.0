Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 10 Mar 2016 16:03:55 +0100
Message-ID: <3432063.dXXth4aifm@prime>
In-Reply-To: <1456492734-29785-1-git-send-email-apape@phoenixcontact.com>
References: <1456492734-29785-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1810828.bBenLEdvXa";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/7] batman-adv: drop unicast packets
	from other backbone gw
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

--nextPart1810828.bBenLEdvXa
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday 26 February 2016 14:18:54 Andreas Pape wrote:
> Additional dropping of unicast packets received from another backbone gw of
> the same backbone network before being forwarded to the same backbone again
> is necessary. It was observed in a test setup that in rare cases these
> frames lead to looping unicast traffic backbone->mesh->backbone.

Yup, this is what we discussed!

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Thanks!
     Simon
--nextPart1810828.bBenLEdvXa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4YzbAAoJEKEr45hCkp6hoOAP/251qZCX2+hk6sOzfgPrfAev
4+h9knauL75gpIWk/EYEtAPTfBr3jwoH9UoTVB9ApWbLP/YlZmKX6Qch8QUJg9IB
yTHlNvnj6cDTuLKkFW2zCLfKotfh1/ESeq1jPXFzgPLYsNDder3Ds79P81Nok8T3
nn5yhWNaL+DdFMQdQpxQWdH5vqKm7C6YEQiuZKJxI84c88Az1lyD4Ikc0L3JFVKI
uNHDYeN7fkVPtrpLXUAjYQBZGpv7g+vMoq49jXHXvjsTYUL3zGMBYn9ugunSGtZy
k7L+wlmLdZ1Ib5t7h54H8eFWlPYAghmWJ3fLXWCpUKHqGwF1KrM6tzz01vpa8n4M
TgV+OwdVBl4QwgUn0v1UtKMhre40DK3+wjyLBhvNuALLcHOt3jILw60bSbbtTT0/
dOOHJxmHG5b9bnwVjtBLYT27K06SXU5K1TqJnwcwboN8lWxLSSdBYijw58auStPb
+jTf54Ze5ixJPDf/aGPAu4XdCkPtZ8crz5d0wn3K2rTSiOkiSbjmbcVJI7iud+xe
aT6WsSDWiy8kLXEy8yngD25FnExPRuLILjlf1JJgJyvBpPzb2zGEWwTuOCVMQeqU
6kLfnLwENOZ5rZKg2le5f+zMG2423nCoHLHUSdbszTdjA0+u6MqxSrnMLdzt2ZYA
PR5GmUaDkgWv0Dbf2mGb
=9FnS
-----END PGP SIGNATURE-----

--nextPart1810828.bBenLEdvXa--

