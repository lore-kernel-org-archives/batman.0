Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 20 Nov 2015 17:37:22 +0100
Message-ID: <51720781.utrOks4lLJ@sven-edge>
In-Reply-To: <CANQCUf=qAPBc7qwTgYJ3KuPZVMm9crsoYLTXKePiCx1bQJkisw@mail.gmail.com>
References: <CANQCUf=qAPBc7qwTgYJ3KuPZVMm9crsoYLTXKePiCx1bQJkisw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2912864.XrlfJxOfQU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Integrity checks for packets, who does it?
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

--nextPart2912864.XrlfJxOfQU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 20 November 2015 15:42:36 Patrick Bosch wrote:
> ICMP should be encapsulated by IP, which is encapsulated by the Wi-Fi
> mac header. Now I know that batman advanced inserts it's own header.
> The question is, where exactly? Does it encapsulate the Wi-Fi mac and
> takes over the integrity check or not? Also, how does it behave in the
> case of enabled encryption? WPA2 has it's own integrity check.

Layers:

4.   ICMP
3.   IP
2.5: batman-adv + the original ethernet header
2.   Eth/WiFi/...
1.   ...

So it just doesn't know about the encryption because the encryption + MIC 
happens at a lower layer.

> The reason I ask, is that in Wireshark, it appears as ICMP when I
> sniff the traffic without encryption enabled.

Wireshark (especially 2.0) can dissect/parse the batman-adv 
headers/encapsulation. You should check the "Packet Details" view in wireshark 
to see the different headers and the payload.

Kind regards,
	Sven

--nextPart2912864.XrlfJxOfQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWT0xCAAoJEF2HCgfBJntGLz4P/1C3ztxpUGDcwrI808/E0LN+
WysXMo6XS/L97nZEmAWXL/EhQBVBPIdS4ers2eQYm60/zN5/lBB1ewVRUIko4APH
cYKSoEF/dbtatClqRQzaEDuJnuYpbfFHJLc51bUXX1hPizqrrBQfW1o5jAkhC7Cd
oZcPJwDgk7iKeDF2vL8rBwsy252MDf7qIhq7XFYZroVFIAJLeYs9y5uox+I9dLmv
aXsmrLvmuopmHjW7VJ5zWPBYsPDO+8n+8T1cf39ebMQ+zt4qiuyFJy5aK7/RHU0G
pEjt65qW3w25vwBJiwRPYTSa/6I8OSTizz+Zylc7WFwrT8ClngUNP4DA9a/2QJzB
0pIEvlTRhRKUAbJIuquvbLax/sJ4k3sre+LGNj0njGAn4aEaQXUy8MK1YsNc+e5l
5D6SwnzAlktqRZUzwE78qwM1YHQu0u2bwE98Y4p8arUHDqwZ/XGYPjlcccTzHG5X
Tc3pX28sLJEE/oERQlWqFplMF8HpAPGDxTfxQCWlW/KlG3exDwhKIiOLF/rmAS6i
5Rl7fGwp30vk06gSeeBv9nMs1cVsg+5ihqzacksAuzrRqP6Vugn7O5W3L4d8/Hpl
mqKncVDLGU8vwr9eC4EbafJY9UL2DI7YAmPGpDBdHCKSvMe+NUBqYWNUKUFMIXJL
gfbagL8sz2B4Q+X2obXe
=M74x
-----END PGP SIGNATURE-----

--nextPart2912864.XrlfJxOfQU--

