Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Dec 2016 21:28:33 +0100
Message-ID: <740883563.LbP4XMaFY9@sven-edge>
In-Reply-To: <20161006064142.20003-3-linus.luessing@c0d3.blue>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <20161006064142.20003-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4160459.CjJZC0o5yR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/4] batman-adv: Store and transmit
	own neighborhood hash
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

--nextPart4160459.CjJZC0o5yR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 6. Oktober 2016 08:41:39 CET Linus L=FCssing wrote:
>  struct batadv_elp_packet {
>         u8     packet_type;
> @@ -247,6 +258,8 @@ struct batadv_elp_packet {
>         u8     orig[ETH_ALEN];
>         __be32 seqno;
>         __be32 elp_interval;
> +       __be16 reserved;
> +       __be16 tvlv_len;
>  };

Um, you simply increase the size of the elp_packet? Isn't this potentially=
=20
breaking compat with older versions? batadv_v_elp_packet_recv is using=20
BATADV_ELP_HLEN (sizeof(struct batadv_elp_packet)) as minimal size/header_l=
en=20
in batadv_check_management_packet.

Only thing saving you here is the padding on some links. But this padding=20
could cause some odd behaviour in batadv_tvlv_containers_process2 when=20
tvlv_len is bogus/padding.

Kind regards,
	Sven

--nextPart4160459.CjJZC0o5yR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlhRq3EACgkQXYcKB8Em
e0ZI0hAAgZ2MCg/lqWOuUzf9envCPC6dgurCk1N4ucv6KuGf34YZMT1ELM8Lx2cJ
82fTlGvolNmuQybQh95taryyOQFZ3wtIkOz3xiVDR8LJDolPa9H44XB0SyJPEMl8
5xXKPF1hYdHRfPZxMB2XdXA0Cjjrfr5zSFrwiCLuMjqxaktpI60/5PxY5P9bSA3b
6zWFY7Y5sk/Ymb0Ij+QCtOtmiw4eCHFqAq1sY1Kxmwaf6DzVAii/JNbZFapp+dvk
KO9l2bcK6XGldnOqxcZCsq04wosPmsOt+qnW6p0TVMUPRZZ/yAIXOO2G6xdM1l95
QeWtfAKd6BBpWZcg18Zpvlqa/W05yJPxtcuMYs7m/VkRCwrlkdI9/XJCDJXK1K4Z
MSeRaivorGC3MhRmIFtdNYrGHTKKzXKTe5tHu20UdgDFFLzpEo3mMAuYxPhL5m3Y
decOC7VCSFQqxgLCMNBZlxOjffevTe7c41BgcHb0JLUZDZ6huqGt83g9IjCzxh73
6L415BISWxEjmsHF8K1JLtzSWjVGM+VhIPLsVyTtNCeHxnxPetG3kXmzP34op8op
GlsrqdLVMfMRTjHNxV8L+Sqgjz1HCfbu+3V9vDoeHDBBjRHjDDHKSDM8oODf3XJW
6Oerb8wODeTC6aCx29kF8PRlb/Kksp9OoEFL5uaJXmYlRTAOGLM=
=gvAb
-----END PGP SIGNATURE-----

--nextPart4160459.CjJZC0o5yR--

