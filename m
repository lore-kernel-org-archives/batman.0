Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: alfred: allow startup without network interface
Date: Wed, 12 Jan 2022 22:11:48 +0100
Message-ID: <1799242.Gl11JrvVGs@rousseau>
In-Reply-To: <10410848.OOsao9LFFs@rousseau>
References: <10410848.OOsao9LFFs@rousseau>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5759643.jAoCkZTbRQ";
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

 
--nextPart5759643.jAoCkZTbRQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Marek Lindner <mareklindner@neomailbox.ch>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Subject: Re: alfred: allow startup without network interface
Date: Wed, 12 Jan 2022 22:11:48 +0100
Message-ID: <1799242.Gl11JrvVGs@rousseau>
In-Reply-To: <10410848.OOsao9LFFs@rousseau>
References: <10410848.OOsao9LFFs@rousseau>

On Wednesday, 12 January 2022 22:02:58 CET Marek Lindner wrote:
> To allow for these additional use cases and keep the current behavior, the
> interface command line parameter shall accept 'none' as interface name
> (similar to the batman-adv interface).

Forgot to mention that these patches build upon master and:

* alfred: Avoid large send buffer for fixed size IPC commands
* alfred: Simplify calculation of fixed size IPC TLV length

Cheers,
Marek

--nextPart5759643.jAoCkZTbRQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAmHfRBQACgkQU1VOj+62
HMASZwf/UBOZitHr0CI2P/adkaw8DtCi/4X3geEk9zSjm6vtbft/650O0pe/aKHI
8beCjnR3B1v/wy2L4HkrKB2Xn6OSezgSPPWHcD8si9U+6MAKWR7meDFNVIXBW8xg
ZzOqu6DazhD8SaVDG7hHwkG1deaWe8YDa7JPNtuiWnkcCX+mojHxY/7uDV10ORzc
s/YQHTNMknG2WFwAaMdnK9Riy5K0Ary/0Joz26Vih78unrja6ANxpmA3eIvI/oGy
wONtwSewt97o7e7dA+EMh3fFvFdfNFoSJWvNYtVXodQ2WBVch4kXpBF3RxFZAczZ
3crym3f6CUsU4qyh/0DNwEwyUNeNpg==
=7x9N
-----END PGP SIGNATURE-----

--nextPart5759643.jAoCkZTbRQ--


