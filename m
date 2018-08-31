Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 31 Aug 2018 12:41:43 +0200
Message-ID: <1809633.qGqqzvPrm9@bentobox>
In-Reply-To: <3991773.ZLWj8GO7DM@bentobox>
References: <2791173.mX5NbDZpiX@sven-edge>
 <733b64f0.dcd9.1658f661fb2.Coremail.heishuihe2008@163.com>
 <3991773.ZLWj8GO7DM@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2394987.l9EsNr1Wgh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Recent test result. Re:Re: Paper "Performance
 Evaluation of BATMAN-adv Wireless Mesh Network Routing Algorithms "
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
Cc: Ligang LIU <heishuihe2008@163.com>, a@unstable.cc, mareklindner@neomailbox.ch

--nextPart2394987.l9EsNr1Wgh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 31. August 2018 12:30:00 CEST Sven Eckelmann wrote:
> skb_put. For example 44 to get to the minimum ethernet frame size:
> 
>     hard_iface->bat_v.elp_skb = dev_alloc_skb(size + 44);
>     ...
>     elp_buff = skb_put_zero(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN + 44);

It should have been 30 not 44. The ethernet packet also has 14 bytes of 
ethernet header.

   14 + 16 + 30 == 60 (aka the minimum)

Sorry about that.

Kind regards,
	Sven
--nextPart2394987.l9EsNr1Wgh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluJG2cACgkQXYcKB8Em
e0bywQ//e9xRNoR2as12ESMQa7XWdsnvDZIM9j36qbPpEh/+N4+PRT5cl24hU055
RdaieqgGgkbI03tqcn4AQlX519jNB7/1wRugUuCWCmsSroQXFkETZ3pSVWoVdBFn
69S3loosmBCApOLCIBpZGRgqfmaqyzuYF0u9zYJgqYa8BdjOgYGbcA7GW7ytP9mV
5q5t7e6eWf1vmPg9I2bz3jmhxdBObiIstUprRKTCaczdMprcDXSLfW5LK4Y4Vhd5
Z0KM3YHNgSFbCBzk9m7rQQNfl9ooDhHbJrqMN7VSuQfDns98V6trcPniAsXqmXWC
WS1pyuUK+iK6/rn0jpXSR1lMe677rdRGjtFlvbyxwBKW8WEbA0z9skep6bhLtR8f
WArPbnK/YyR70qHpuS+y8K22S0sMMEyP2WyihNFMUccXLYEuZemPY7Vt8Pg8fpCB
sNTyjxC7Yet3f0aywzrB6jg6O6rFKgec8BSeNfWxriG5AqXN0IpJSUSd9rcrZYXQ
mO6XM+6UUszi0OXU0heV7efw+OhBVZcfTFzb9quLppbKSgCwer7WZ1sFzzG8ourX
cLLusniSw8MYOvzRXUEotPVcbY8gENXAC3PCrjBiyUPj7IkchLX2ZQEHN420Br5r
Yy9qdOAR5qQ2Pl7LmLUIVDXXldc4/Ci3e7oKsqmEHFPBOCC6OAM=
=8YAy
-----END PGP SIGNATURE-----

--nextPart2394987.l9EsNr1Wgh--

