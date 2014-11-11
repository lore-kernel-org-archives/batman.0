Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 11 Nov 2014 23:56:03 +0100
Message-ID: <2091412.EK1SUSK0CW@sven-edge>
In-Reply-To: <1414917484-13213-1-git-send-email-antonio@meshcoding.com>
References: <1414917484-13213-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart283152604.XqIeIE9qbR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv5] batctl: tcpdump - parse TVLV containers
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart283152604.XqIeIE9qbR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> +typedef void (*batctl_tvlv_parser_t)(void *buff, ssize_t buff_len);
> +
> +/* location [i][j] contains the parsing function for TVLV of type 'i' and
> + * version 'j + 1'
> + */
> +batctl_tvlv_parser_t tvlv_parsers[][1] = {
> +       [BATADV_TVLV_GW][0] = batctl_tvlv_parse_gw_v1,
> +       [BATADV_TVLV_DAT][0] = batctl_tvlv_parse_dat_v1,
> +       [BATADV_TVLV_NC][0] = batctl_tvlv_parse_nc_v1,
> +       [BATADV_TVLV_TT][0] = batctl_tvlv_parse_tt_v1,
> +       [BATADV_TVLV_ROAM][0] = batctl_tvlv_parse_roam_v1,
> +};
[....]
> +       while (tvlv_len > 0) {
> +               tvlv_hdr = (struct batadv_tvlv_hdr *)ptr;
> +               len = ntohs(tvlv_hdr->len);
> +
> +               parser = tvlv_parsers[tvlv_hdr->type][tvlv_hdr->version - 1];
> +               parser(tvlv_hdr + 1, len);
> +
> +               /* go to the next container */
> +               ptr = (uint8_t *)(tvlv_hdr + 1) + len;
> +               tvlv_len -= sizeof(*tvlv_hdr) + len;
> +       }
> +}
> +
[....]
> +       while (tvlv_len > 0) {
> +               tvlv_hdr = (struct batadv_tvlv_hdr *)ptr;
> +               len = ntohs(tvlv_hdr->len);
> +
> +               parser = tvlv_parsers[tvlv_hdr->type][tvlv_hdr->version - 1];
> +               parser(tvlv_hdr + 1, len);
> +
> +               /* go to the next container */
> +               ptr = (uint8_t *)(tvlv_hdr + 1) + len;
> +               tvlv_len -= sizeof(*tvlv_hdr) + len;
> +       }
>  }

I've already explained this to Antonio but here again in public:

 * neither type nor version are validated
 * the type can point in tvlv_parsers  to an invalid (non-existing) entry
 * the version of this entry can also point to an invalid parser
 * this is a big problem because I can crash batctl td with data packets
   send from other people (even valid data packets with mcast tvlv)
 * I've already experienced this problem when using nodes from a company
   which ships this patch since a while (> 4 months)

Maybe it can be redone with some switch statements or
(more space consuming) full tables which can handle all input data. Of course
a check of the returned parser is still necessary inside the loops.

Kind regards,
	Sven
--nextPart283152604.XqIeIE9qbR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUYpQGAAoJEF2HCgfBJntGF1gP/A9GZByomxnTIVsz/r0k28Jw
rjlwjAH9daYUNkfoqASK12mcSe1r9hAcfV4dlaGI++8kebiIN37vT3v5BY00hH7c
5LzZdtOC7x4pMnQqelxanSpnh2CElUCWCWseCnNxYo8KKUcK9Vr8YcXL3lXdP9it
T7U6SXdaqRKropN+5j8jpoN/Oeh+Ngg2XYAge9OPW82iy3UtzchDi4eWaVyKBSmH
TVN9sMpZ5MftpLzPmGng7YS2+xp4YeGKHeiUfD7oGhME9WiT6nJOCLV3Bz9X8e7t
e10YqVY79qlmD9TqQeecqS7WWC4tnfQ+6A4I3sH99JfdeJK8yIpmyWTaEWH+nCAK
Ulymd382lyEmV+pcK1aX0ny/dXDrV9QU970/re6la7WVhiD2xgIPTz9VAM9GMhvT
7QztHHuBNig4iNnhiYD54Bd4Otexr2EMIorjtsVe8ze8UNc6vGeqih+fh8JMK2ny
OZizoF5UJQrGb2/B9ZQeoG7veSNS/aQK8uSidLodeuxGzJnLJHImhvtnkkC71Uqb
gTbJQ0p25wPXN7dO5y1Sd0D9CsX+hZHQBkRsTbpH0dw1wbiMhYCkHYtS+CB1Wj/K
REd9WZSxt3k+BXhHy4hvDT92r+8OYmv6i3RzPD2W0Dhbu/RqYEJi8QfFKmDuvlln
Pnh/9OFdxA724+U4YtxC
=BW7q
-----END PGP SIGNATURE-----

--nextPart283152604.XqIeIE9qbR--

