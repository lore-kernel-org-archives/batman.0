Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 17 Feb 2016 09:10 +0100
Message-ID: <2117827.xyvgm9uY5o@bentobox>
In-Reply-To: <1455666670-32409-1-git-send-email-dominik@heidler.eu>
References: <1455666670-32409-1-git-send-email-dominik@heidler.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2372830.NqQE15tkBB";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Allow setting the source mac via
	unix sock
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

--nextPart2372830.NqQE15tkBB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 17 February 2016 00:51:10 Dominik Heidler wrote:
> The server will only overwrite the mac if it is zero.
> 
> Signed-off-by: Dominik Heidler <dominik@heidler.eu>

I think this breaks the forwarding/synchronization rules of alfred.

@Simon, what do you say?

kind regards,
	Sven

> ---
> 
> The alfred client sets the mac to zero by default
> so this shouldn't break existing behaviour.
> 
> 
>  unix_sock.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/unix_sock.c b/unix_sock.c
> index 3c7e583..12a10e6 100644
> --- a/unix_sock.c
> +++ b/unix_sock.c
> @@ -119,7 +119,9 @@ static int unix_sock_add_data(struct globals *globals,
>  
>  	data = push->data;
>  	data_len = ntohs(data->header.length);
> -	memcpy(data->source, &interface->hwaddr, sizeof(interface->hwaddr));
> +	static const char zero[ETH_ALEN] = { 0 };
> +	if (!memcmp(zero, data->source, sizeof(data->source)))
> +		memcpy(data->source, &interface->hwaddr, sizeof(interface->hwaddr));
>  
>  	if ((int)(data_len + sizeof(*data)) > len)
>  		goto err;
> 

--nextPart2372830.NqQE15tkBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWxCrYAAoJEF2HCgfBJntGoKMQAKW47BNa3+DeDnaUl3JKtZS7
sX+I0flUAvslosPX15bpEHdtls/U9t4xz2YKUP+tEh7tnu12MEZ6vaiLjC46I8yC
YqvhEM5bNlAvuoiUvgCsQQTHk8yEdU8Uz+VJy3hQa52ffIEbCTRNoJqtTB3o4xZ3
gFQBLL3KUJlF1ff+2IQxGEcKKxFJvz0N1peP+n0wN50q7iPqQldW8mf/RRYUS1Y2
hY2+13VCPd6gWsBt9e7l8LoWMXs7CKhp6X4iTFGS+DepA3xH5VgsnSJ5h8DtrwR0
shh6Occ22ujKyWZhYsiItYc/k9vxAnfUt4rXEmVEaqKs/oOa1t7d/01BeZKez7pc
PeYBAQidSahhms/ENYEXEkL+jJqVaBQD4iljJnqtNgi4VcfIsgAvMxYQEWxF5opB
vhAkbQgu82fn19bE3dy/rGdSqfklTc7lw/Nqo9h6u3rc2xEWYVT4czpjDEW32RQj
9fy92RS9F5zo9RMrs+bShfi3j3MqR8UMBkS5IGdT3VNGNVvou1PoKrqz74tnW/kd
pJBXpwG4uGyrB6Jxl6AmRWNfV7mMCQmVeI4h1qrEaDaGNmcTxLlZHRA5RM+0yY9C
DvH/EjmvtGKKoIkBW6CD9oXPGIDVoZAFrhGnFcNEJPrRR9HioKd5wm8oLoVE0ev4
8gRaVy08W/CphJiV26iH
=hAIx
-----END PGP SIGNATURE-----

--nextPart2372830.NqQE15tkBB--

