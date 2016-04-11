Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 11 Apr 2016 12:55:30 +0200
Message-ID: <2511766.I40HQ78nvx@bentobox>
In-Reply-To: <8025409.qnq58rYqdb@voltaire>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
 <1457190564-11419-4-git-send-email-sven@narfation.org>
 <8025409.qnq58rYqdb@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4260180.ZIomt6PpI3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/9] batman-adv: Use kref_get for
	hard_iface subfunctions
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

--nextPart4260180.ZIomt6PpI3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 11 April 2016 18:13:09 Marek Lindner wrote:
> On Saturday, March 05, 2016 16:09:19 Sven Eckelmann wrote:
> > The callers of the functions using batadv_hard_iface objects have to make
> > sure that they already hold a valid reference. The subfunctions don't have
> > to check whether the reference counter is > 0 because this was already
> > checked by the callers.
> 
> You say the callers have to make sure that valid references exist but do they 
> or is this coming later or .. ?

This was in

[PATCH 1/9] batman-adv: Check hard_iface refcnt before calling function
[PATCH 2/9] batman-adv: Check hard_iface refcnt when receiving skb

Kind regards,
	Sven
--nextPart4260180.ZIomt6PpI3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXC4KiAAoJEF2HCgfBJntGOtEQAIda/9CKhyk5Kr83SvvQqgRX
yeeWwspD+mp6p8UmAnDqCNZNbKYDKFZYMEO69kzD4YwSXawo/C0i+lxVb9f5eUTw
EObfLUmqW7WFBICGD8tW7D1mZk9E9X1LVJtv+nF6C2TBLGnsdMNDvY12WDTm0wZg
h4/SkVRrr9DFM5emEaqlJMzwcJSq06B3JtbE45Y5oeWBOn+ejJnnAyx+7BDr21z2
V3ZEnSqpV3aqKjqubkLSVAIv1hdvuzK/C0mJImW4PIN+HqJcSo5ZUR0YFo4mFLMF
dELTAM048c2dCObSTC66cUHKBZSA4QbNFbMzNP3dEAxctQMoZuV4DBIsrkT8AFdl
Omt7qZecah8S4Rwtyjrkgz4WPrkzu5oG5ZDRCIPo1ISQ2+G2+ivku7Pt0dV1rQBi
BvpxIDWcyRKVgxTpWCzrElsH5IoAGvJhI9St8/f6UjU/CWMM1mDXZXoNKJe3q8u+
X6OdIpoUPiOlnl0gevJyYU4b7R0e72pGp+R1JuKqBVfKHUHARnj6qUuEVzNsFKQt
ZCHJHiSW0OEe40iXAsNKE6WiIfKb0O9k+ZfH5PKc9cM6OHSivJlJSR+ab3MEfMTK
sr0rGLdal4NQFVxs+/JEmhR4ivuQrgCn5nLBFejyAzOc6x3dqZb/3jSSdcerzZrc
xWNCooSU09hRcb5pzVw4
=jYxu
-----END PGP SIGNATURE-----

--nextPart4260180.ZIomt6PpI3--

