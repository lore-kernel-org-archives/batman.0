Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 09 Nov 2015 16:31:17 +0100
Message-ID: <1899407.TVXecW4so9@prime>
In-Reply-To: <F52F175DFC537F48A43937B50B44BCA2820C1278@EXCHANGE.mediaspot.local>
References: <F52F175DFC537F48A43937B50B44BCA2820C1278@EXCHANGE.mediaspot.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5152598.UeWgMjbqgY";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] bridge detaching crash
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
Cc: Alessandro Bolletta <alessandro@mediaspot.net>

--nextPart5152598.UeWgMjbqgY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

On Sunday 08 November 2015 23:45:14 Alessandro Bolletta wrote:
> Hi,
> in my Openwrt x86 testbed, I created a bridge between a vlan over eth0 and a
> vlan over bat0. It works as expected but, when I try to restart network,
> bridge seems to be not correctly detached and networking stack gets hanged.
> 
> This is the dmesg: http://pastebin.com/rxUUGvgX
> 
> Can you help me to debug this crash?

Could you please post:

 * batman-adv version
 * your network setup (batctl if, brctl show, etc)
 * commands you use to restart network (OpenWRT or something else?)

Thanks,
    Simon
--nextPart5152598.UeWgMjbqgY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlZAvEUACgkQrzg/fFk7axbeSgCfT5rlVA2gkWSdv5eAggSkxoe0
hy8An1XPJH8XFmRMJbVO2dS3tk9tRHbY
=SQXq
-----END PGP SIGNATURE-----

--nextPart5152598.UeWgMjbqgY--

