Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 06 Feb 2015 13:38:42 +0100
Message-ID: <2688831.HMc8mZG1gy@bentobox>
In-Reply-To: <54D46C8C.2040800@meshcoding.com>
References: <1423153373-17033-1-git-send-email-sven@narfation.org>
 <54D46C8C.2040800@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2968553.PAuecnFBv3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use safer default config for
	optional features
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart2968553.PAuecnFBv3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 06 February 2015 08:26:04 Antonio Quartulli wrote:
> Could you please be a bit more specific about the issue you are talking
> about?

I can only talk about the simple two node installation I had when I was forced 
to write the wireshark-batman-adv dissector for v15. I just placed them next 
to each other and tried to ping the other one (not sure anymore if it was the 
node directly or two other devices plugged in the ethernet port of the 
devices). And I think there was a reboot of one node and a ARP cache flush 
involved. I've expected to see the 4addr packets when capturing on the 
wireless and then having both nodes talking to each other. This was not 
working. I could only communicate after disabling DAT... but of course the 
communication which I wanted to capture wasn't happening.

Either I got a dump from you or I've tried again until it worked.
 
> So far the only situation where I personally switched DAT off did not
> really get fixed and continued to show the issue. Therefore I am not
> really sure that DAT can be blamed for this.
> 
> So far I don't know anybody else who complained about DAT.

You have to ask Marek why DAT is disabled in many installations for which he 
is more or less responsible. Maybe he has more to contribute than me.

Kind regards,
	Sven
--nextPart2968553.PAuecnFBv3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJU1LXVAAoJEF2HCgfBJntGeGMP/iVEQQp8kXLgQ/jwAlKvDYqY
ucHdME9Qfz4GEj7iEMWKNvgyfnHXX3s2fHCB1VGqI8jR/S2E7klAqaw3BzYwtCRk
0720cgqzzlhN5c0SQ98GXQAGU2gIdUkBC6FX26lwdNfXkMzL75wjNUuX5ve4F/yJ
GbbD4QEBfmTdFmQjRJI/WRv7jvK4ZDbv+SQFCWe6SNp/Y6MfvuceonIJV/KWF8e7
4boaAHuDnhIhnpmF6t4BYN0CARFM0l1d4mNrQ/kmgupKCO6iz5JfOMIDh2c6BanA
2Gw48NMiRdCe2zo0LoMzj37guBQ/DUYKsCgXY5UncGU0GtL6Atct/ot3IjHKfEBb
1mgB+iaHoirMj7453QV3OqrBMgWSEUuvqkKBdAWNlMmWDc1w0KKjBnjgGFvv3Aiw
DnpBrgRH01+YrQ3SjUiuI/rXGM397Ne8yxInUCH//uASF6oLcYD+rUrtO13CjgOi
1FlGUGrJxtmtxx0X/dZvOba1r5DEhHUEf86FNTmVNGoZ00fpondRfkGufzkTf+ss
h6OZ/AETvrrpqURyfL9SRt5rFR1pXxAKFviNJN40RaH/b1/ap2v8RZgEiX8oPgPH
2fNW9C8KGV/rdNeVv3emCL8L3IhEj8mMEYAEU+cRNybCqAyWZjmJRNRQvT/HXQfT
nJc2AB/3ieOPmdznAdpz
=pzW8
-----END PGP SIGNATURE-----

--nextPart2968553.PAuecnFBv3--

