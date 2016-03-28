Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 28 Mar 2016 23:13:03 +0800
Message-ID: <5701447.mB2TsHTmai@voltaire>
In-Reply-To: <1457701271-24248-1-git-send-email-sven@narfation.org>
References: <1457701271-24248-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2543655.2FXBlqDvQN";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: use batadv_compare_eth
	when possible
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart2543655.2FXBlqDvQN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, March 11, 2016 14:01:10 Sven Eckelmann wrote:
> From: Antonio Quartulli <a@unstable.cc>
> 
> When comparing Ethernet address it is better to use the more
> generic batadv_compare_eth. The latter is also optimised for
> architectures having a fast unaligned access.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> [sven@narfation.org: fix conflicts with current version]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Patch was resurrected from https://patchwork.open-mesh.org/patch/3668/
> 
> I've requested an rebased version at
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014639.html
> but done it myself because it was rather trivial.
> ---
>  net/batman-adv/network-coding.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied in revision 6a1bc0a.

Thanks,
Marek

--nextPart2543655.2FXBlqDvQN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW+Un/AAoJEFNVTo/uthzAIv0IAJsbzERzmevD720cs4AuK0VU
NE+YogiMXGhzWIG13jyG7p4KM3gdGJF0T0mPOj8m20HCRUuTwRUagc4mRdxQXr5z
XWKvpeN+x9HmDDEUE3BguNiqrjeAmoqJKOvj5GvFA2ugPYvqUCZ8vHukuUO94RF7
uORGdbpp+cX9oMH2KBTddXVeCXvckOoUbxXAn2aYp7rgAkTHS50UW878NINVlI/T
BhajN0g2omXGcmqh30KVyqHynEtnmLFDmL1UP4Kihow3D+etehjPhIcKdy4ArWVh
G8Zvds2OaPAaezYBIAzSS/lgRsdUDtmARt4HkuMvPWM1PtxGIfgdcz4VNNqwW5I=
=Eal4
-----END PGP SIGNATURE-----

--nextPart2543655.2FXBlqDvQN--

