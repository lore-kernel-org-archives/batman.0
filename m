Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2 1/2] batman-adv: BATMAN_V: introduce per hard-iface
 OGMv2 queues
Date: Sun, 04 Aug 2019 20:36:34 +0200
Message-ID: <2424516.9MKKcQ5zTs@sven-edge>
In-Reply-To: <20190804180632.489-2-linus.luessing@c0d3.blue>
References: <20190804180632.489-1-linus.luessing@c0d3.blue>
 <20190804180632.489-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1800788.icWLctkV9F";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart1800788.icWLctkV9F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 4 August 2019 20:06:31 CEST Linus L=FCssing wrote:
> +        * @aggr_len: length of the OGM aggregate (excluding ethernet fra=
me
> +        *  size)

Did you really mean "ethernet frame size" here? Not ethernet header size? A=
t=20
least this would match following part of the second patch:

On Sunday, 4 August 2019 20:06:32 CEST Linus L=FCssing wrote:
> +       skb_aggr =3D dev_alloc_skb(aggr_len + ETH_HLEN + NET_IP_ALIGN);
> +       if (!skb_aggr) {
> +               batadv_v_ogm_aggr_list_free(hard_iface);
> +               return;
> +       }

Kind regards,
	Sven
--nextPart1800788.icWLctkV9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl1HJbIACgkQXYcKB8Em
e0azaw//dR7OmSoGy/YcQuBvVgVhdIoCUnqyCXICr6cDfZ7V4XNHQbBZaKKO6cdO
80FF0JADmhRO7BMrwMc1x3lLMDK8DqNs6ckBXp4/TfZHiRRrjWRj/vSn+j2eKEND
ees8EyXewfgFREX7sfnHW6QoNJ468GKCWO9Q/PBFVYneHpW0aDXf+oYfzBE8qUUX
GU6Rm1rWkLLXMrSRGOtbDFxl+AoVSvOzaZdaqhYaB6xoAr2hjzVEyEWcwRXeY7Cz
6fXANFsrzkri6GLBuvEC83pBV2HmNZEyViIgrn2LzNjUfOFyniVgy0LMs0ngizb5
Lztx1/1MD7FCtvH1QUSyFZassKheipJJx6pp6DHyBAGaf0Vk6zpmONL/xHeUkMHK
s4kvQY88eREyZsIjLOzqbOt3nVPPP8bav+AMoRW4eYSov3z/YRfT7Ik5i9LjERS/
8gk48w6JV3Ss+RaIlQZVzPQTJhCKcFsOzFnMsBHj0g7oJ3h9mx4gR4dgQ7o41+xJ
K7eyTI4eY7TYGpo/Aruo+wBaK+XOdbFkeaamC3ilvz3T/xpBAFZ5n1NZz6jGR5e6
DxXD1UuUNwDsu6JTgs4BQ77HpHQQ0WCFraHdfsvuuSByaE1fD5+YZlM4DKIaFg0S
yRNw5wl4/GCTA2M+nK2NpmnPhziVja3JHUeqWKcdRrX2xYLoevA=
=jPM6
-----END PGP SIGNATURE-----

--nextPart1800788.icWLctkV9F--



