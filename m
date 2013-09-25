Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 25 Sep 2013 22:53:41 +0800
Message-ID: <43132642.fX8QJAUdHI@diderot>
In-Reply-To: <1379759294-1481-1-git-send-email-antonio@meshcoding.com>
References: <1379759294-1481-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1800899.zqr9KzdqEa";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix DAT candidate
	selection (must use vid)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart1800899.zqr9KzdqEa
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 21 September 2013 12:28:14 Antonio Quartulli wrote:
> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> index 6c8c393..d4b3940 100644
> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -530,11 +530,13 @@ static void batadv_choose_next_candidate(struct
> batadv_priv *bat_priv, * Returns the candidate array of size
> BATADV_DAT_CANDIDATE_NUM.
>   */
>  static struct batadv_dat_candidate *
> -batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
> +batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
> +			     unsigned short vid)
>  {

Kernel doc ?


>  	batadv_dbg(BATADV_DBG_DAT, bat_priv,
> @@ -572,7 +577,7 @@ batadv_dat_select_candidates(struct batadv_priv
> *bat_priv, __be32 ip_dst) */
>  static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
>  				 struct sk_buff *skb, __be32 ip,
> -				 int packet_subtype)
> +				 unsigned short vid, int packet_subtype)
>  {

Kernel doc ?

Cheers,
Marek

--nextPart1800899.zqr9KzdqEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQEcBAABAgAGBQJSQvj1AAoJEFNVTo/uthzAAj0IAKBVNVM1aT5z8VapNwT4dvWs
FJXTBaOjygKfDot5jAgm748ELoW8D8Sfxk44BTTwjqIrdNDobGYGLBfn08TnoveP
Fmp9G228oXVEX5CgAJvIG+H33ZL5E02gtwNTOzj8YiRJ9jImXzdAgoO2NeloF3Xm
4upJPSseQvyVQNNTXA8aKILzmGSZtTbopng9fUD8P2MfAr12LIlliJwDds+OwHYP
I39xnqS9w98W8SsfXZIOgXNA85hC3KxDM78Og1D8tawHhb7mH7HGelcDLFNqp9CA
OJAslWkVACMj40/16C9VItuzVGxtYUFxs4FYY/cZuZQGQhJCLhbNaDFBMM7kxMA=
=IMXE
-----END PGP SIGNATURE-----

--nextPart1800899.zqr9KzdqEa--

