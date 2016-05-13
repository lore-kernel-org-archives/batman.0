Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 13 May 2016 19:37:11 +0200
Message-ID: <2059800.IKvSZ5WLNp@prime>
In-Reply-To: <1463034697-8867-2-git-send-email-apape@phoenixcontact.com>
References: <1463034697-8867-1-git-send-email-apape@phoenixcontact.com>
 <1463034697-8867-2-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1657068.p0A6XecnbU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 1/6] batman-adv: prevent multiple ARP
	replies sent by gateways if dat enbled
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

--nextPart1657068.p0A6XecnbU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday 12 May 2016 08:31:32 Andreas Pape wrote:
> @@ -1003,6 +1004,20 @@ bool batadv_dat_snoop_outgoing_arp_request(struct
> batadv_priv *bat_priv, goto out;
>  		}
> 
> +		/* If BLA is enabled, only send ARP replies if we have claimed
> +		 * the destination for the ARP request or if no one else of
> +		 * the backbone gws belonging to our backbone has claimed the
> +		 * destination.
> +		 */
> +		if (!batadv_bla_handle_local_claim(bat_priv,
> +						   dat_entry->mac_addr, vid)) {
> +			batadv_dbg(BATADV_DBG_DAT, bat_priv,
> +				   "Device %pM claimed by another backbone gw. Don't send ARP 
reply!",
> +				   dat_entry->mac_addr);
> +			ret = true;
> +			goto out;
> +		}
> +

There is still my question/comment pending for this from your PATCHv2. I'll 
quote:

I  would agree to Antonio that sending a claim is not necessary, and might 
actually lead to bad choices of the outgoing backbone gateway. After all, at 
this point any "random" backbone gateway may answer to this request, just 
because it has the DAT entry, but maybe may actually not be able to reach the 
client via the mesh.

I think checking if a local claim exists is a good idea, but sending a claim 
is not a good idea - this might introduce effects which will be even more 
complicated to debug.

Cheers,
     Simon
--nextPart1657068.p0A6XecnbU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXNhDHAAoJEKEr45hCkp6hCXAP/2yi6f7TMuA2SjYVMVcbNIL8
2whet9A6pewD00HzyoigGhQVQQ6QxdCyL6C4i6Opvqcu25AMiSVXAplEzBXi28JQ
o3QUWDwXMhMuZ7Rby5xH9JfnLx1leDw+HPzeA7aJp4dYBHuuFWKuWGGtYv+9CvC/
e+cFnLpH/2CuFWC9L1PZ/Yf7CWpL6SjZwEbUxYwWLR4pDLOpH4itmYut5Vvk6w7O
61qK8MXnRfI8d5k8xGWGH/7nDgGzae/xSk3v7QeaRDBYwGgaJCjjM7QC2PbxjpXd
+yOCFDUd/84vb2emUK4QGBLHflIjyPhPw/BvK7KsRCkcfKYdvHyKD6RvsiSBPFIP
H92d1WuCyxRsT0yxfmMx+ls1HLxk4aAiwWc0s3FeSbK7AcfpvFQWeTO9PKI354zu
2Du+K9Y7+aFmaNnf8yNoP+8CyIZhGb6qWnsmIu0jlHDwbMEgVLZs/MksNHmtzq5T
YdVzklGoZ5RJ3WUq+5xdBbiV2EGMtD407+ZOePVmphDk5SVCj7dHgfXXPwz4bl8T
ym/1f8HTkXWarBwpk+aXxlY3iyvZX7y7uLCa+dNW8u1aElCS+sHdRVp9ao5przsk
jjQGgkDc5ZMJjJnFENFor8kEaZScKTtZ8Q6SRWAq+U8GwqTtL8sasLJQ8zG9KlxE
Wwk5poJZfXpx6kDoBxKT
=g7cu
-----END PGP SIGNATURE-----

--nextPart1657068.p0A6XecnbU--

