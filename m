Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 01 Jan 2018 10:13:44 +0100
Message-ID: <2561223.2KfdzXezWu@sven-edge>
In-Reply-To: <2542365.bvxhBZAykN@lafayette>
References: <CAL3ir7LUCHfyxegLn7qbx8cQ_H73V6AnTtBBN2eUPg7Wwn3j+A@mail.gmail.com>
 <2542365.bvxhBZAykN@lafayette>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3062641.fuGzGSMdtM";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] 11ac throughput on mesh links
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
Cc: Daniel Ghansah <smartwires@gmail.com>

--nextPart3062641.fuGzGSMdtM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 1. Januar 2018 13:12:53 CET Marek Lindner wrote:
[...]
> This is a known bug caused by the QCA WiFi driver firmware blob. The exported
> TX bitrate value is utterly bogus. Only QCA is in the position to fix that.
> 
> There have been attempts such as this one:
>  https://github.com/torvalds/linux/commit/c1dd8016ae02557e4f3fcf7339865924d9357f76
> Not sure this fix addresses your case. Sven might know.

This only works for 10.4 firmware versions with peer stats enabled. The 10.2.4 
firmware versions (only some are actually supported) require following patchset:

* https://patchwork.kernel.org/patch/10092915/
* https://patchwork.kernel.org/patch/10092917/
* https://patchwork.kernel.org/patch/10092919/

And you need the patch mentioned by Marek (+ the patch referenced in it) to 
get any TX rate values at all.

But QCA already knows that they (relatively often) still report completely 
bogus values (and only QCA can fix it). And you must understand that the 
values which you will get here are *a lot* higher than what you can 
realistically achieve via this link since the TX/RX data rates are actually 
physical data rates and not the throughput measured via TCP/UDP/... - or by
looking at the payload of the actually transported (QoS) data packets.

So let as assume for now that you will lose 50% of the physical data rate to 
some expected overhead. Then you might still have the problem that each packet 
has to be retransmitted 4 times (or more) before it can be received by the 
other end and the aggregation is 1. The TX/RX data rate information in iw will 
not capture anything of that.

But there can also be a lot of other factors which influence the performance - 
maybe you CPU is not capable of handling the packet generation and 
transmission, the MTU is not configured properly on the slave device, the NIC 
might not be able to transmit a single flow to saturate the link, batman-adv's 
throughput meter might not handle some packet loss as well as expected, the 
qdisc (flow dissector) might fail to handle the batman-adv tp packets 
properly, ...

Kind regards,
	Sven
--nextPart3062641.fuGzGSMdtM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlpJ+8gACgkQXYcKB8Em
e0YUcg//eBIXzUrUp+7u8YgzLo+4sw/JT+Ho0hEvhuPLV29s6m8eyxAnAx8wgrth
kQfgSycljEbX2Rs7bv/o13ichwcQXqVgb3+FWWLdXovw4pOV/klvkcsLGacWg3w9
LaeD4GJ2bZW1Rqkt31h2YnWlyhklaJUisJuKLKg/PYucIEU6zMVvAWMSvwi1JDy6
OMOa8Kg66VD6mtNVOk9RBlHvlGm3rSpt3VLYpgGOOv9/LYa6o6CBKinlL6I7GRVk
ohQprx2MuBQtizZWo52ms8k0n/RDEyul8kGqudXywoYSc81egUm4BOBdZN5XqvAg
INmzdyx4gvSnYXVsJjDLm8dzJlH7+qDbU5AoW/UzL1sbQaXxDZYiwNeqXGyWiobq
kPKfAU24SXmBFs9lpwb/tUi0uqzbKwBEcqkbFgD0AlUKqvC+9bCL4h5m9eVL5nKZ
/fOXcJU9RhT5jQe2ajDsxVtqQPQWSkMzFKwDKHFa1k9PltE7W14y93nXuHjAwwxy
yRI0l33IEfI0tLAJ8oi555JXs0tbbk6dX1Plc8rE80QQRPebpHX6e8GSbiTlVgDX
SIEFkDW+0JeVUDCH+6m4s7CeFPAJ+HzzfPJ9hBH3wwk9tZKDG6EHP8TrFTZTcMp6
gSmttmXuMw9r8aggCe48jB6+1ofKOEKJm5yChOf6hGFG4qT9XkA=
=D9Av
-----END PGP SIGNATURE-----

--nextPart3062641.fuGzGSMdtM--

