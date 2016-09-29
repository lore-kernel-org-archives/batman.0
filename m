Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu, 29 Sep 2016 18:05:25 +0200
Message-ID: <2166229.456RT91xVd@sven-edge>
In-Reply-To: <20160817210759.19357-2-linus.luessing@c0d3.blue>
References: <20160817210759.19357-1-linus.luessing@c0d3.blue>
 <20160817210759.19357-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1582225.lNqDtpUsda";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/2] batman-adv: fix race conditions
	on interface removal
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

--nextPart1582225.lNqDtpUsda
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Mittwoch, 17. August 2016 23:07:58 CEST Linus L=FCssing wrote:
[...]
> +/**
> + * batadv_forw_packet_queue - try to queue a forwarding packet
> + * @forw_packet: the forwarding packet to queue
> + * @lock: a key to the store (e.g. forw_{bat,bcast}_list_lock)
> + * @head: the shelve to queue it on (e.g. forw_{bat,bcast}_list)
> + *
> + * This function tries to (re)queue a forwarding packet. If packet was s=
tolen
> + * earlier then the shop owner will (usually) keep quiet about it.
> + *
> + * Caller needs to ensure that forw_packet->delayed_work was initialized.
> + */
> +static void batadv_forw_packet_queue(struct batadv_forw_packet *forw_pac=
ket,
> +				     spinlock_t *lock, struct hlist_head *head,
> +				     unsigned long send_time)
> +{

send_time is missing in kernel-doc


Kind regards,
	Sven

--nextPart1582225.lNqDtpUsda
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX7TvFAAoJEF2HCgfBJntGuO8QALqJOvHjBjiu3r1FmZqoWblf
9NoJQYvwb1u0Pko5h+lIfzRR79zE7JnzJlqi4WYbTJPPnBHvBvwtQO8PbB8XSrBa
QpzrKPOJ3BYRJmyMjWXjoFGnA1Ryvn7zhsfD/Nt72Az9wjLafS3IVCVpbl4wOpjD
6p6hFdBHBkMFFZScUZb3I0W34dkg9YGv5nLmNRj5H7hCcMemhmfysDYaJlSlAaoU
PrLLzE9MtXjBnBkYcpQrBC7Zx+VqhrL82HyoJDJVjYArqskyzI5GweGlmAI9UUFi
hj7wPmwUzhJZGMH5UpGv4ZtAZzXppSOrqleIEo6Rmat9aEyZkr2M/mXBeMDoSXF4
E+5380bG2UeN2JcJIvH4YMNYyf/kFT8DeV21Jq3xtsXPJxw1IL4DxUy7a+qMxTPr
EW++uMuPXBJmYdTfvcrKw1G3003dF8lUeoou3PYpX5813FyvcyLNhDtBwI72jAdR
F9i92bCVZQTg97i+dLovDGMQJz7R0Buc5zySVBk71sn04MCJy2ltEqplRy+XyAW/
zXwXcmJ5OHXXUeRcgCIu5Ausvj2U15tMScE4po/j66jsfjkkl9X0n7ra4mQpTUjr
a3gmRxJtGhozITly7onebnAfp0wITIfNha/N3kaSAj4ltD86UwTc6ij6mxBG5hbx
LhHXWeGfZsZhcthuTgcy
=4GSJ
-----END PGP SIGNATURE-----

--nextPart1582225.lNqDtpUsda--

