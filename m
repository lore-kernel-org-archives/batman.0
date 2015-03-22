Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Mar 2015 02:34:33 +0100
Message-ID: <2376189.i7svKM7Q39@sven-edge>
In-Reply-To: <2950150.4H3sVLA1nB@sven-edge>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <2950150.4H3sVLA1nB@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1978270.XBsEEESgxi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 00/26] batman-adv: Cleanups
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
To: Markus Pargmann <mpa@pengutronix.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart1978270.XBsEEESgxi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 22 March 2015 01:52:40 Sven Eckelmann wrote:
> On Friday 26 December 2014 12:41:17 Markus Pargmann wrote:
> > Markus Pargmann (26):
> [...]
> 
> >   batman-adv: packet.h, add some missing includes
> >   batman-adv: types.h, add missing include
> 
> Just went through the includes and noticed that a lot more are missing (also
> in the files which you are already touched). I have attached the current
> state of my analysis so you can compare it with your notes.

Small disclaimer I forgot:

The patch is currently not finished. Following things are missing:

 * #include "types.h" in main.h after "compat.h" (may be removed in the future 
   when I can drop it somehow... but it will most likely be added again even
   when there is a dependency circle with types.h)
 * tests with older kernels
 * an actual description

Kind regards,
	Sven
--nextPart1978270.XBsEEESgxi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVDhw0AAoJEF2HCgfBJntGtO0P/1OXBe/b9MZMQhvz6T7eD3zf
TMFcyn3a3yjFdseXQQpM8mDYrvKqoFiCV1kAZkhCm37TjOCxSCpJ8J/3NwhqYMHK
xC8xvT6+BK3F8gVbq2YOmg5AaKoVatBBxszkQTZwk/Kd3gq8zmMpq+wHB5jK3QU6
qOT1Lm6pi41JHupDGjMOJwVQ8JGp4vkVWx7gBS+cl03ysZBt6UGZSgas2syi1ZH9
KUGtKHgRg0Pp+O/kJrn1bUkqgRvxNNodieT073hw0yS1FSOzt+GYU1jB+ucQ3+gd
GGDCoPxvJPQy3EtVFpqKKqbO4I/wD41War1FaYN0GzHJpkJbPcFXhHvZG9b6e0Eq
qXe68T1ctwGegNf0wBEpHyCOLM8ndZthAQmssJwE7gd11QQyrTQCPaXjw6Q4WSJD
PVSvFIZyl/P5XQTigaM3yupMqDcmIe/EhYjwh+2uFOEOkU6HrJf9WAiurWC3JAgw
NTm7g1BymopRJPYb3SsIBGvjMfO2TlXmhSA7Xf4j/C/RQGvBBXL5X0al6CY9PUI7
LL+JJRHkd0RcJBqhlGi9S5PmlvmK9H2UxiWvgRpp2bzq9ZqfrHDyiL2WSj9/G9S9
MIv9uij3pnB5sLvAFvQ78UH0ibZ345+7vHwKi1tJidSulw00ky++RS5HS/z0d2o7
KenzjG8JEw6Utv+ExMRy
=kwml
-----END PGP SIGNATURE-----

--nextPart1978270.XBsEEESgxi--

