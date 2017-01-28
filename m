Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 28 Jan 2017 10:43:02 +0100
Message-ID: <2805784.b2EcoZjk5T@sven-edge>
In-Reply-To: <20170128092526.9219-1-sven@narfation.org>
References: <20170128092526.9219-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3232329.P88fF4PC7Y";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix double call of
	dev_queue_xmit
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

--nextPart3232329.P88fF4PC7Y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 28. Januar 2017 10:25:25 CET Sven Eckelmann wrote:
> The net_xmit_eval has side effects because it is not making sure that e
> isn't evaluated twice.
> 
>     #define net_xmit_eval(e)        ((e) == NET_XMIT_CN ? 0 : (e))
> 
> The code proposed by David Miller
> 
>     return net_xmit_eval(dev_queue_xmit(skb));
> 
> will therefore get transformed into
> 
>     return ((dev_queue_xmit(skb)) == NET_XMIT_CN ? 0 : (dev_queue_xmit(skb)))
> 
> dev_queue_xmit will therefore be tried again (with an already consumed skb)
> whenever the return code is not NET_XMIT_CN.
> 
> Fixes: 17efab9867c5 ("batman-adv: Simplify handling of NET_XMIT_CN")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/send.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I was so embarrassed about not catching these two that I've already applied
them an prepared the changes for net-next.

Kind regards,
	Sven
--nextPart3232329.P88fF4PC7Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliMZ6YACgkQXYcKB8Em
e0aBLxAA17QGYCr4LzJdwEtcrJldRHTC93kbseNxAcXwfaJzhZwx+HLWzRzjP900
WHlky3B0w9XPyYbDUiY8J+KA6P2ufEUzFHPcyoBYZWvERF6mM8pu17OxRp/PSeHi
va7Xvh9gb/iwua9xLn8SEZTEN39j5wxoIjYLNOfkPkUqUGw6vvyDylWdJrJFNRW2
YFDE4SJ0F+fC3l/nw78BFcOimf2yBtdvHZ1VxYjwOFiwtjGml7v6/6c4qLHPWCsM
xy0RRzvv28F10BluY0fhrtekJYtrvqX4/zgJ2zl4nVMMEqHv4AsOQqQFAQLxth2g
OlRyOzCb5FZRklqklOLsLUUoCAvWKtKs8YxOI2+rOF57dzkv04yVYlr6OraJD7q2
J171tSEdOXyP5VNCQhPfFPom6hWXCX3qNRZsED07coDtUELxJghpbMw8k/7sIRoF
1K5tY7BR+BZLurVylIdgjABZb9cz1/TKtojJOL49EbT7iQLAdv00s8OHmEa7l5uT
wqHMeaGBzQ8FGaGMA1WeT7hN13iQuix4tAunqpSTK9J0NmePLKFQzN0ul+pDCOuK
ZhfKuTXxMS9Celxfng/PFR+VyPKFIL6zTrSCgrz77cjgSgsOjjn+1bqKurwY7qnf
XmEYzeX2zgGx1K6lKEZPlrvODzjQMUl8qf6Jau4iJ5KBvE3H5NI=
=bgP8
-----END PGP SIGNATURE-----

--nextPart3232329.P88fF4PC7Y--

