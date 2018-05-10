Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 May 2018 17:33:57 +0200
Message-ID: <1595147.f5nhRcq9z3@sven-edge>
In-Reply-To: <20180510152946.7802-1-a@unstable.cc>
References: <20180510152946.7802-1-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1997689.I8Nc72hv9F";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix argument name in
 kernel-doc
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart1997689.I8Nc72hv9F
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 10. Mai 2018 17:29:46 CEST Antonio Quartulli wrote:
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
>  net/batman-adv/tp_meter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
> index 11520de9..55d8e4c1 100644
> --- a/net/batman-adv/tp_meter.c
> +++ b/net/batman-adv/tp_meter.c
> @@ -808,7 +808,7 @@ static int batadv_tp_wait_available(struct batadv_tp_vars *tp_vars, size_t plen)
>  
>  /**
>   * batadv_tp_send() - main sending thread of a tp meter session
> - * @arg: address of the related tp_vars
> + * @work: address of the related tp_vars
>   *
>   * Return: nothing, this function never returns
>   */
> 

Just checked the master branch and the argument is still called arg there:

    /**
     * batadv_tp_send() - main sending thread of a tp meter session
     * @arg: address of the related tp_vars
     *
     * Return: nothing, this function never returns
     */
    static int batadv_tp_send(void *arg)
    {

So I will reject this patch.

Kind regards,
	Sven
--nextPart1997689.I8Nc72hv9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlr0ZmUACgkQXYcKB8Em
e0ZjEw//QIfWXqtaqbHO0hM6yyVfHUSCQiyHdTU6C0qzt/Y4OsdW+z8CjrR5wLUn
M+39EbboVLVnGMzxDRB+JmbHcxtYwiEValaRKeRBGTnqNw7GSKbLL8IBk/62ENEg
0bOqIXpk/NMVyl3+J/8LODIm6WO/zX076tz7+9yA1zb2fUCUL6OYmZhK2DyxPpH/
B9xfwQ4PT6JwMutfiUCb7N/1lnCoUX6TrMgzlkRuYwB95RJAOWsvd/ZzBzPoM6K/
mrgNyHC4WCDRTUCizEsQAUput5kObFqTkWVQA+u1qkBwoOWrz8AlO14UrRNk1xy6
fMKwIylRaYIMClgu8mXvy09kqXB3yJnGPRSqjLBUnxxMuSQKjRMFDbCC/WXJYdKm
lhBsCyHUSxrUpfHjiKmEAYTlvfqxAZEqkvTQeFW/xZYUaXfzZRtlsAASRacROcXe
xfBsI6oD5OZ8f63KKpfjuXL4D7bvcr6DZTspfOg4GNcwVXsxCYaaoMlfF6vvGvK2
2m/Xl7piEz0VSXy7hL3YAjK6vRzmnzBSdw2VAb6+5PR7CS6S5d3z8GNXvIbrxroj
0+1zdxes5ktpgPJwXwJylYsDUCz4eQQkJdG+B+7hwBDBZklBSKiZ5+96GzPTl6Dw
ibzMfnAYDMr2J9kiPtScs4YwJCS+AWj5ldKBVLhUBS8kfQ1qFC8=
=+4dD
-----END PGP SIGNATURE-----

--nextPart1997689.I8Nc72hv9F--



