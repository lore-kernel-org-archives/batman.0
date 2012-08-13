Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Aug 2012 11:14:21 +0200
Message-ID: <2227002.UhFQFI5sO4@bentobox>
In-Reply-To: <1344514526-30256-2-git-send-email-montik@autistici.org>
References: <1344514526-30256-1-git-send-email-montik@autistici.org>
 <1344514526-30256-2-git-send-email-montik@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart122263134.hAAHGEz3mh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [RFC 1/3] batman-adv: bandwidth meter
	implementation
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


--nextPart122263134.hAAHGEz3mh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 09 August 2012 14:15:24 Edo Monticelli wrote:
[...]
> +dst_unreach:
> +	/* TODO not in .h
> +	icmp_to_send->msg_type = DESTINATION_UNREACHABLE;
> +	batadv_socket_add_packet(socket_client, icmp_to_send, packet_len);
> +	 */
[...]
> +		goto out; /* TODO send an ack! */
[...]
> +		goto out; /* TODO ?? */
[...]
> +		/* TODO redefine BW_PACKET_LEN */
> +		skb_reserve(skb, ETH_HLEN);
> +		icmp_to_send = (struct batadv_icmp_packet *)
> +					skb_put(skb, bw_packet_len);
[...]
> +		/* TODO notify batctl */
> +		spin_unlock_bh(&bat_priv->bw_list_lock);
> +		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> +			   "Meter: trying to interrupt an already over connection\n");
> +		return;
> +	}
[...]
> +		/* TODO notify batctl */
> +		spin_unlock_bh(&bat_priv->bw_list_lock);
> +		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> +			   "Meter: test to or from the same node already ongoing, 
aborting\n");
> +		goto out;
> +	}

Mh, Looks like some open tasks... ;)


Can you also convert (and of course add) the documentation of all new 
functions/structures to KernelDoc style. Example templates can be found at 
http://www.open-mesh.org/projects/batman-adv/wiki/KernelDoc

Kind regards,
	Sven
--nextPart122263134.hAAHGEz3mh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQKMVtAAoJEF2HCgfBJntGKDwQAI9WKflm/QYtIxIxHNI8vIgD
QbOOVaHzPTn6l3LVcubACA9kHroDZ3PnVsVCAVrAB5GWPWPwIOULzLY/Kfo84kSC
NXGTjpXWc0R+HvJzj8hKKToZawLhHXa6Gzq0sT1w93zs0BSyT206E5SIdsz2J572
UnlNWJ31isDq1luMSnDqWoSD4aFU1iyELyDaKHC4Ma5wkt4SiTmsIo6rJD34oanK
CyfFuljlYB2/5zPr5yJuAigHLtYQvPpNU9XRAOYh6aYIjS9wMwhZEEMjIk8LAkPg
MZmRf1EjawVb0Bm2OrgCbKuVprgmCQzATsxkKWaOKzHtLimv3pY+DdMNlqVktZtK
tBAioWJM2z2osOL6QutynUbwrTvewmnGaQnb0k6HdU8IoT637dSAs15qQIoUAQUr
5/3h1JFpaLFlWjVQbkM8bgQs1UUDrCkoIp8HT9vflLQItW08jcAkaj9BhjTpau9H
9AYvp7XUySVCGFVW1oAK2SUXlhsp15fPsKpsypCPZn5aI/JrdWBiGRhlZ+k40VR+
PDLthsWG152fExuiM4wFQBRgDd7pFLR+InHSdkR5alO61y5lzKb3Sn9i0pYi75XG
sNz3lieIemh1mdbEFbAR8xHoGobR87qdFxGAXXXpTv6fc02HDn1XL/vzsQEty24H
YeLDWgyQLTWq2FZ296zK
=X/lq
-----END PGP SIGNATURE-----

--nextPart122263134.hAAHGEz3mh--

