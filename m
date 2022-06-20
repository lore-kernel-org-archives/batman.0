Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Question about batman for ARM
Date: Mon, 20 Jun 2022 14:50:54 +0200
Message-ID: <20961862.b4RiU9qLUR@ripper>
In-Reply-To: <014301d8848f$5874d0b0$095e7210$@creonexsystems.com>
References: 
 <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com>
 <3826484.QQW5a1qdB9@ripper>
 <014301d8848f$5874d0b0$095e7210$@creonexsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart20699880.uRv7U2kVex";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: cchien@creonexsystems.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart20699880.uRv7U2kVex
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: cchien@creonexsystems.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Question about batman for ARM
Date: Mon, 20 Jun 2022 14:50:54 +0200
Message-ID: <20961862.b4RiU9qLUR@ripper>
In-Reply-To: <014301d8848f$5874d0b0$095e7210$@creonexsystems.com>
References: <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com> <3826484.QQW5a1qdB9@ripper> <014301d8848f$5874d0b0$095e7210$@creonexsystems.com>

On Monday, 20 June 2022 12:20:19 CEST cchien@creonexsystems.com wrote:
> Does BATMAN ADV interfaces with the radio via the network driver or does
> BATMAN include the network driver?

As said before, it is interfacing with the generic ethernet netdev layer of 
the kernel. For example in:

* https://git.open-mesh.org/batman-adv.git/blob/caa1eb0cf7bf8ebfe43bba06b890252a865efa91:/net/batman-adv/hard-interface.c#l727
* https://git.open-mesh.org/batman-adv.git/blob/caa1eb0cf7bf8ebfe43bba06b890252a865efa91:/net/batman-adv/send.c#l108
* https://git.open-mesh.org/batman-adv.git/blob/caa1eb0cf7bf8ebfe43bba06b890252a865efa91:/net/batman-adv/hard-interface.c#l185

There are a lot of other places when it uses the abstraction interfaces of the 
kernels for ethernet related communication.

For B.A.T.M.A.N. V, it is also trying to get throughput information via 
various generic kernel functionality:

* https://git.open-mesh.org/batman-adv.git/blob/caa1eb0cf7bf8ebfe43bba06b890252a865efa91:/net/batman-adv/bat_v_elp.c#l67

There is also one detection for wifi interfaces to decide whether broadcast 
messages should be repeated or not:

* https://git.open-mesh.org/batman-adv.git/blob/caa1eb0cf7bf8ebfe43bba06b890252a865efa91:/net/batman-adv/hard-interface.c#l877


> Can you provide some guidance on where the network driver or interface to
> network driver is located within BATMAN?

It is not talking directly to the driver. It is always using abstraction 
layers. Either the normal network core, ethernet or cfg80211 abstraction 
interfaces. But these don't abstract the requirement for ethernet 
compatibility away - the underlying device must provide this either directly 
or via a wrapper. Just perform a `git grep -e ETH_ -e eth_ -e ethhdr` to
see that it is build around the concept of ethernet packets.

Also things like originators and the complete translation table only works 
with ethernet addresses.

Kind regards,
	Sven
--nextPart20699880.uRv7U2kVex
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmKwbS4ACgkQXYcKB8Em
e0Zeig/8D6/qjebcv1juFxgH6K+OAFC74CXh3i2NBtfRt+P2Qdow87Hg6SXCfwxo
zqvU7KkK88RNPXb+uMBoSjLrdJs1WugUZ99aBcSa0FuifjTcJjRf5qMAmnsOZyW3
zwwxgaI8fjU8StfqSFGGCrIXz7hdQhbJTA4YCYM6EMxYB3pOXwrQWy4xxotbpKPs
9FyLpe+Gp8EflWK8vrq7qjaV7oqhaJ2AGA27iBOFKhkWVkMrHy1lC0afIgXKvajh
QTsikRPbt6Ig7GiS6AqUU3BeEAel15ytIoyAv1/5sH3vTzEXtP7yUuozGfeNZ4p+
nEJ5X/eNu7chZLUiyp+lxkG2+E+DKLED59N3r2uWkEcN/PDQXoeluuKZWmMRAUSu
7C0EW5NzfXeNXh7trXGAV4Xqyytaxyt0oh1A1TUU0e+4YOs78Uqwp8Ed/M9xSGOz
eYZk+sQ4o8czruuW4eiIQPtu3PcEOp+Z7LLY6KVKCJYTgYmIyTiHL8+5r7lc8vmb
aLG3N62+4+d9jP1Q1eFjfRuPa+Cp935WswDX2FvVtFt2eu2fAmxphNJYaitphIsI
VFLC94lCOAOkQE3Pia4M2jOR5d1j/qNbmNvqfJ/vqo4EN/rbn3DDf+TcECFQALPn
biiPHbxykaK/e0NDNAHUx+dgC7ek2HZZz3HQs3fQi2uVulnaUAo=
=4gz0
-----END PGP SIGNATURE-----

--nextPart20699880.uRv7U2kVex--


