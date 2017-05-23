Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 23 May 2017 12:12:21 +0200
Message-ID: <4826270.pqO2KLcmBo@bentobox>
In-Reply-To: <20170519110200.29867-1-sven@narfation.org>
References: <20170519110200.29867-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2278273.YRDIpDaaDX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Print correct function names
	in dbg messages
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

--nextPart2278273.YRDIpDaaDX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 19. Mai 2017 13:02:00 CEST Sven Eckelmann wrote:
> The function names in batman-adv changed slightly in the past. But some of
> the debug messages were not updated correctly and therefore some messages
> were incorrect. To avoid this in the future, these kind of messages should
> use __func__ to automatically print the correct function name.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_iv_ogm.c            |  3 +-
>  net/batman-adv/bridge_loop_avoidance.c | 72 +++++++++++++++++-----------------
>  net/batman-adv/distributed-arp-table.c |  2 +-
>  net/batman-adv/routing.c               |  4 +-
>  net/batman-adv/send.c                  |  6 +--
>  5 files changed, 45 insertions(+), 42 deletions(-)
> 

Patch applied as 4978390e544d496157c6836bbf15270e3039e1c3 [1]


Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/4978390e544d496157c6836bbf15270e3039e1c3

--nextPart2278273.YRDIpDaaDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlkkCwUACgkQXYcKB8Em
e0bCxxAAyPiwtKvyd7TTeb8qWwMpUSgI/ycl1M6k41JKSyiL1blq9d0kFA2OL0IG
HYD+9G2/mJ4AjlX7dkIp65qGR8SEz7Wwsf6b1e/FdSH3Qwja6K6fVAuO2iF42Pt/
yFiaWGmiyM6snqVSTef0CChEWiZ6HHs42t+yf5O9LlrnBFeZbW4+0O6xGM4XRUoE
9R1bOJjTQl154i8SIQfYN4aZ6p2T8sFynFlNylE9p2nvpXhkdndUU12ruGZqkjLt
FhSqrb+McPXKx0e/CkWPkZG/j9imi3+5Rv4CzwgdtvT2uKSZV9XgehgbiHdz1owg
jfNCBolb+HHhM3cfniJF0zpwElWt9+BmjeVujkptKsmUtAkbBba78r2ZumpFiV73
m2udTGzL3Z0Ps5OB1jy6BdvVkc+7HgXB8e4P2dDRchhNmN+TMoVALIrzgOgBXFCC
Paj1tENygpI9ckK1zbLmp3dmqnTcP6rh5Noh51y37EzYsDKV0cBd+f2EFqGNwAB7
DCGG34HsgkdEgZ2kx9NkFz/DGYFzbIqPB4MBL+lGsIjOq0A4pRhs40AZvYSL7InC
Lv4mfqBVtmvlfg/fgsGMm5AxJADSMQQ57mArVi4srnBg6wTz6h80NzckK8lPvBD2
HlhdTNFZ6rvYqUz0IRxLtH1Q1M9ysEZfhHIRF6u2acaNJ1/Razo=
=K7Sd
-----END PGP SIGNATURE-----

--nextPart2278273.YRDIpDaaDX--

