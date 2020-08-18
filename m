Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batman-adv: bla: use netif_rx_ni when not in interrupt context
Date: Tue, 18 Aug 2020 18:17:05 +0200
Message-ID: <6180909.URE3MufrRF@sven-edge>
In-Reply-To: <20200818144610.8094-1-jussi.kivilinna@haltian.com>
References: <20200818144610.8094-1-jussi.kivilinna@haltian.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart55107351.EY56bM8rYs"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Jussi Kivilinna <jussi.kivilinna@haltian.com>

 
--nextPart55107351.EY56bM8rYs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 18 August 2020 16:46:10 CEST Jussi Kivilinna wrote:
> batadv_bla_send_claim() gets called from worker thread context through
> batadv_bla_periodic_work(), thus netif_rx_ni needs to be used in that
> case. This fixes "NOHZ: local_softirq_pending 08" log messages seen
> when batman-adv is enabled.
> 
> Signed-off-by: Jussi Kivilinna <jussi.kivilinna@haltian.com>
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")

Kind regards,
	Sven
--nextPart55107351.EY56bM8rYs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl87/wIACgkQXYcKB8Em
e0a23hAAgXVUe5XrDy5/8/29s2l8qJa84evfHIxw/FsFsBd+/voY4fLLdefO49JQ
YBCoUp8xLqK2XtKBXcKQXC1zfA51QYR00Q/LnT+qUNZr18aaIKGL0DFoYS18xgoX
+TlFoNZPBLu+RRhBz3+3u26rqQbuD9kCiSoiYaSSGSTF++TTKh40U2Jmbm3/nkpY
vGNQKMSjBHvJg0CA1R6Vbn0qKbmtF2JltPX/js/bp9G+un+d7N7aRzarpqmnhMCX
HzSnqFOdJbIKetmsKIo7U9Yc6Oq/d9mviskejSndwJjH1soyHr7S4G1XGXggHk5w
/JpTM0iszp4dUNAuz27gDT4QImTRfEOL+P1CtLRC6YjvtiQhNekLWFpEOWeQUw+x
oSIwk4AIh2l2hLalspONNxwhwq0bOm94ERg1N9K7CSseLaC9XqpFa1BioLgJRTb3
3XAfSEsul/RMbgy61LHyHlK4ePp17ILPzG3Gl1pe1U5zZR/5Ubi9QSFfDdBJ03Oe
XixFhBKST209LaeM6Sz6SLaMTSGUTytGfeaA/Nvh0GFenWYq0Hb5AeCtFbK+44ZR
hqMemgNa3tbkJ27aiZwuhL0ImhO3OM0B+R/wMt73JrjNQYIerlMropXxcpN+MCPB
3J3YPXq8oSxxJen+8P3eyM3pG1rVr1qQG1wBDOcw2YRzuQTBxo0=
=FKaS
-----END PGP SIGNATURE-----

--nextPart55107351.EY56bM8rYs--


