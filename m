Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Nov 2013 13:31:11 +0800
Message-ID: <6858187.HqJ4FjDvbE@diderot>
In-Reply-To: <1384360685-366-3-git-send-email-antonio@meshcoding.com>
References: <1384360685-366-1-git-send-email-antonio@meshcoding.com>
 <1384360685-366-3-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10820862.oZMcfqH0Q6";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/6] batman-adv: mark a local client as
	isolated when needed
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


--nextPart10820862.oZMcfqH0Q6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 13 November 2013 17:38:01 Antonio Quartulli wrote:
> @@ -474,7 +474,7 @@ static void batadv_tt_global_free(struct batadv_priv
> *bat_priv, * Returns true if the client was successfully added, false
> otherwise. */
>  bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t
> *addr, -                        unsigned short vid, int ifindex)
> +                        unsigned short vid, int ifindex, uint32_t mark)
>  {
>         struct batadv_priv *bat_priv = netdev_priv(soft_iface);
>         struct batadv_tt_local_entry *tt_local;

Kernel doc ?

Cheers,
Marek

--nextPart10820862.oZMcfqH0Q6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJShwMgAAoJEFNVTo/uthzAkDUH/jlyCPlka62LRkr+b5N97JY9
J6yt6L2qslDyo2MXcAGzdCAe+MD/XAaRkD2VSaRN0GhDFgPzmAHNpcx79XfB4rP3
5z9he4/inEebOr0nV6+wQPi4RaUl4UUxvMTu4kEIFk6U7k6Qu8LZbH88SC3hgfRh
uIgptbdHQW6uA4kUcPLD2q9TCUwlv4MQcoJsZH7kTuCt32WXtWejJ1dXJyMd32tR
dZ9C8W5us6vfREFOD7IqTjhso+Bd6bOhOQHHwKjzSLhaaWzgnETYpSAVomXVcS1/
Wc4mbVIcDncfBMOPGN3+2HbKxvm0PlCd5IfVhmAuBsRV2rIUdPYZHQTRdsnyMxU=
=gOi4
-----END PGP SIGNATURE-----

--nextPart10820862.oZMcfqH0Q6--

