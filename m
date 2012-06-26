Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 26 Jun 2012 23:22:23 +0200
Message-ID: <4495078.i4mdBapCR8@sven-laptop.home.narfation.org>
In-Reply-To: <1340740822-4516-4-git-send-email-ordex@autistici.org>
References: <1340740822-4516-1-git-send-email-ordex@autistici.org>
	<1340740822-4516-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3422545.zoHi1BB7uo";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: enable roaming packets
	to carry flags
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart3422545.zoHi1BB7uo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 26 June 2012 22:00:20 Antonio Quartulli wrote:
> In case of client-roaming it would be useful to carry TT flags along with
> the client entry. Information contained in the flags could be used on the
> new mesh node for several reasons (e.g. particular roaming treatment).
> 
> This patch modifies the ROAMING_ADV packet according to this idea so that it
> can also carry the flags together with the MAC address of the moving
> client.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  packet.h            |    2 +-
>  routing.c           |    7 ++++---
>  translation-table.c |   17 ++++++++++-------
>  3 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/packet.h b/packet.h
> index 65d66e4..e0b94a3 100644
> --- a/packet.h
> +++ b/packet.h
> @@ -214,7 +214,7 @@ struct batadv_tt_query_packet {
> 
>  struct batadv_roam_adv_packet {
>  	struct batadv_header header;
> -	uint8_t  reserved;
> +	uint8_t  flags;
>  	uint8_t  dst[ETH_ALEN];
>  	uint8_t  src[ETH_ALEN];
>  	uint8_t  client[ETH_ALEN];

I am not 100% sure because I haven't checked the code, but couldn't it be the 
case that we send random bits inside reserved at the moment? At least I cannot 
remember the part of the code that initialized reserver to any specific value. 
That would make the change incompatible with older batman-adv version.

Kind regards,
	Sven
--nextPart3422545.zoHi1BB7uo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJP6igPAAoJEF2HCgfBJntGMtoP/AhdRchJOFRef/FdInSwRrJr
3a0m/AQCPSeDo5wlwMI2NyNL9RMcQlxw46Be8VD2p3mAPee7ucHmDa4JYyrEri8x
86gRSBWA9aaMRbDFJowOmfdLfKxtl44P8K3MFa91/AqtYDV6bndbJtawQfuYw03N
PL57qlkOYqAVLQQe6vN6mOibvITCvS0w8YKQlfBB7Wp62OKMeBq64dPszTDrBgMH
EDIzf/278Meke9Bd1rVXEaz6djLmhLmzi/JyHB32wBufcFM9g3JWb0BAlw6qk9l0
CMy9HWORetXT593vyX0aM/OaPcKyRjRmHoZLpyM2Tj5WfOkINRhboh1VGm1C8wur
YfWTkHGfZMfVazrPkG5JLH/fuX30ldy8c4t6R/S9DJ2kamCH+lnPrjINsyWpNU/A
o6/ILFADEiu3OlWYpYbkOD77M7HeQTwPEz7R4o7/IFn6/svOcb4KqV9sMMIM30pF
KB/tth2ybIKknrkp07y1HsZ7dR2nLHDEy5OPpebShkPcFeu8/PTSwMWuaZ3Bdxmq
7wv+TN46jzJ3hHS2KyTURoEf7cphuLe3yAyQ7LefXASGArWGUs1ejJ0ULVNE4bP6
gtRzeI9lGhws3PVGbqu0Qt94Yp1DxPDFxvZOW27gQWsPKajOY0u5Lg0V+W8ev4gL
HEsLbn4fuywDZl2kkGXz
=DBgw
-----END PGP SIGNATURE-----

--nextPart3422545.zoHi1BB7uo--

