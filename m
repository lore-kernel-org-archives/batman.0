Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 09 Nov 2015 16:54:17 +0100
Message-ID: <10965054.eQHvKNcRSx@bentobox>
In-Reply-To: <1899407.TVXecW4so9@prime>
References: <F52F175DFC537F48A43937B50B44BCA2820C1278@EXCHANGE.mediaspot.local>
 <1899407.TVXecW4so9@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8131980.a3NYFqsjaW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart8131980.a3NYFqsjaW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 09 November 2015 16:31:17 Simon Wunderlich wrote:
> Hi,
> 
> On Sunday 08 November 2015 23:45:14 Alessandro Bolletta wrote:
> > Hi,
> > in my Openwrt x86 testbed, I created a bridge between a vlan over eth0 and 
a
> > vlan over bat0. It works as expected but, when I try to restart network,
> > bridge seems to be not correctly detached and networking stack gets 
hanged.
> > 
> > This is the dmesg: http://pastebin.com/rxUUGvgX
> > 
> > Can you help me to debug this crash?
> 
> Could you please post:
> 
>  * batman-adv version
>  * your network setup (batctl if, brctl show, etc)
>  * commands you use to restart network (OpenWRT or something else?)

And please also enable DEBUG_BUGVERBOSE in your kernel builds and post the 
output from the kernel oops with this option set.

Kind regards,
	Sven
--nextPart8131980.a3NYFqsjaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWQMGpAAoJEF2HCgfBJntG/OcQAImx5EdvfoBw73UMDGjktEKj
bl0L04BeTFFQqHH740+ScymyWlN2wyypo1iPtek4pEsWoertnji98dI8e0kp2HLI
MU5x6dukx9n7p3+OhoCAbDh3UYUwoYW1YgIiJ0/R/dyaVZjMVDgWwoqjqy3wEy9V
Q0vaaKRhmsCeXhuUowEW7iw550u4Rxt/6FvcaMpowucO53/veIVNQ09XqBvSe6Ad
+3x2A+R4Y+frEGqv/R+YHXHHOH6XXfRaujNRCayVp/bocc23D97MIT9YYy8WRPfH
I/h8BQnFofN5M4wVh+UEvDeFtL8E3JuMsgr7YO1+M5CH3HwH7CvlNr9eGR1CbT6y
NvSZMbebp2aYVmqM6YPHRibpE8zkRgrNinXpbxqMhltyK0VHTn8zdMvuLwkd/BmB
icWvhuD0vTfDtuxNh/MyRIih3I4Uk7NiU0Xp4htlEFxAaehyCzfF9PQ9u/+nbV/q
A+oCw5z+N3altDy9eGaYStYFz1PY7NaV67Oumwwmw/bLA4rEEOcTKneYqe5KvZuQ
kjHzLulVvd5/NSfBqqX7WubE5bm6K2OEO/Yg/M5BevOtjmaJqb2rC7rBXjMGpd4n
3utzvbRBKblNJMfSC8A+zJrydAXMTOEvEYiN/d4d/M2Qi9pJc8CoXmcZYgLmMXDe
arTjKn6vkf/4O/41tcFR
=SDjZ
-----END PGP SIGNATURE-----

--nextPart8131980.a3NYFqsjaW--

