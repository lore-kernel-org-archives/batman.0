Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 Feb 2016 22:17:29 +0100
Message-ID: <1458257.UDBVY9kErm@sven-edge>
In-Reply-To: <1456492697-29708-1-git-send-email-apape@phoenixcontact.com>
References: <1456492697-29708-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1491021.9QJbR40MZH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/7] batman-adv: speed up dat by
	snooping received ip traffic
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

--nextPart1491021.9QJbR40MZH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 February 2016 14:18:17 Andreas Pape wrote:
> +				iphdr = (struct iphdr *)(vhdr +
> +						sizeof(struct vlan_ethhdr));

Forgot this one: sizeof(*vhdr) == 18. So you basically calculated

    (u8 *)vhdr + 18 * 18

But I would guess that you actually wanted to calculate

    (u8 *)vhdr + 18

Kind regards,
	Sven
--nextPart1491021.9QJbR40MZH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW0MDpAAoJEF2HCgfBJntG9UcP/jYk6oz9Aj3CFctq9ZbdSehY
6DeaLCw9aquejiL7Y69xUrKOAd7tk++VNNyjZ6Zax5QCsWvn5viQttgOSfNFtVxs
Kl/9F3rbqQ2ZHYS65tzHFxx+hQhEtvBSBrOMAOxZDcwNjxhG0yP4uEChnxxp+noA
hJL1xQLcdmz+l13r1hUTPyih+J5821AxqQLdNgMjQsSWqnMwNdgnVGjwWcER6bkb
frNiHvQWD6GR7sw7lMJlQ5EmPCbOlpk09i5kKJqsWMIDtYFlVxGk4tQEaau/YkBN
dmGpbcIwIyPC/YAZSWw4n9Balw+PKDMG0g979Kt3zok0L2iFxNpNZdISRAoE+5LK
uV81VWmQroGUNiwNKHs0WB7fut0wSGCjbhA677pzcfb5rok42+6mpjIhE1ETyr//
dmlRaF0bFd55/jmqFNONhSkzeCkaqwGO+evMs/I548OEpfk+6IBsipqe3wrCcoo9
h/RGWh0uO7RnWoZVuMehh3MxWA2imQaDX5xPYAFDC1SpbINLTpMZhGzaSK7chaR2
omMhkGMDNRqaaTTJ6i+aVq270hK/SZGiZSX8A3bsPE/VNR9NYbUjHC7tx5956PVb
IHSZEoMJzOUOsmU8V+FPn5IeU3s4Iixtk6troiYUVEDyQAvSbDx3iy4enG68Gc+N
tYgLxKPJ6bWcZ7Nhnuxw
=2z2j
-----END PGP SIGNATURE-----

--nextPart1491021.9QJbR40MZH--

