Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 06 Feb 2017 11:25:00 +0100
Message-ID: <1502082.JgMhZiz8zA@bentobox>
In-Reply-To: <20170129135743.21312-6-linus.luessing@c0d3.blue>
References: <20170129135743.21312-1-linus.luessing@c0d3.blue>
 <20170129135743.21312-6-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13764954.RDTyJuW1uR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: restructure rebroadcast
	counter into forw_packet API
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

--nextPart13764954.RDTyJuW1uR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 29. Januar 2017 14:57:42 CET Linus L=FCssing wrote:
> This patch refactors the num_packets counter of a forw_packet in the
> following three ways:
>=20
> 1) Removed dual-use of forw_packet::num_packets:
>    -> now for aggregation purposes only
> 2) Using forw_packet::skb::cb::num_bcasts instead:
>    -> for easier access in aggregation code later
> 3) make access to num_bcasts private to batadv_forw_packet_*()

I like this change but have some questions (but no time to check it). Is cb=
=20
initialized when a new skbuff is allocated? And what about the initializati=
on=20
for packets we get via batadv_interface_tx? At least batman-adv is only=20
setting it to zero when we receive a new packet from an hardif=20
(batadv_batman_skb_recv).

Kind regards,
	Sven

--nextPart13764954.RDTyJuW1uR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliYTvwACgkQXYcKB8Em
e0bK5g/7BOkhW/L1oKx58RgEDkwr9W3XtznkTBSrRWcGEIadw6HeoMad1C4NclMd
wQ8i4+MsGhDrQ+OSY8Aynr9MPzIPI4yoUGF5/kZX8trPEtct397zkkfkRznl+vF6
WxAhK2rMPHOgcOqmD8FTzrKN7+XJEYJO4stgLSogJSZ0JD7g58vOFHHORXR5ienP
RS3xeNi2P/rxeQao5hp5dPj/O/WTRgwu+EIdoPrV2s1TzHA3ROA8zvXdmzJ6smAn
DVWxjP0BSpfeulPsSLsvL10Dsnh/L139m54AR9a3+n449F5ltRESGFPOMEQqWzT+
J8D8BXZcgsef1r0s7Y+BxaRCirP+86/D+EttcXQ7DjeoLI3C88IY7op0wlEhGByP
YE5ouj4wqv5bdcE84jGt8KtTGs/lYoXl2voZVhuYezedWFXv/w/gQCbrWzU3EC90
HHoHN3HM3lEVRtaSwhniUAF4bxpBqbu9StLherCkdrHijnMBC1muNvTfjmiSiWIT
zGsaKHHQRqwZbEUnKBPP+3BG2Qaz3Elwp2Zb423CncOvFLAoYmanvZc8axwUsTXO
eL7Vx5sq5rHfez7U6kYquT9YllcHVO0nMlPEy9N5vBF1VsGb2W4BpvEiF5qT8FSo
kiLKimfouktE603mCMf24X4ogaKIeQtWhG9l+cx7I8N8wlWYUr8=
=7MOU
-----END PGP SIGNATURE-----

--nextPart13764954.RDTyJuW1uR--

