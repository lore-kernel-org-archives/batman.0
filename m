Return-Path: <antonio@meshcoding.com>
Message-ID: <550AF2DD.5000707@meshcoding.com>
Date: Thu, 19 Mar 2015 17:01:33 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <OF5389A718.644E8229-ONC1257E0D.00566F9A-C1257E0D.0056A5A0@phoenixcontact.com>
In-Reply-To: <OF5389A718.644E8229-ONC1257E0D.00566F9A-C1257E0D.0056A5A0@phoenixcontact.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RIORWmusI1jisF0Cx6JXjLEhPniqCUtKw"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: bugfix for kernel crash in
 batadv_tt_local_table_free
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RIORWmusI1jisF0Cx6JXjLEhPniqCUtKw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On 19/03/15 16:46, Andreas Pape wrote:
> This missing check lead to a kernel crash when a hard_if is removed on =
a=20
> node forwarding
> untagged and tagged traffic (VLANID 0) to and from the mesh network.
>=20

Did you actually see the crash? if so, can you please report the stacktra=
ce?

When creating bat0 (untagged interface), a "fake" vlan object is created
with vid =3D BATADV_NO_FLAGS, therefore in this context the object "vlan"=

should never be NULL because there is always an object to retrieve.

Cheers,

> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> ---
>  translation-table.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/translation-table.c b/translation-table.c
> index b20812b..4d3ab8d 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -1143,8 +1143,10 @@ static void batadv_tt_local_table_free(struct=20
> batadv_priv *bat_priv)
>                         /* decrease the reference held for this vlan */=

>                         vlan =3D batadv_softif_vlan_get(bat_priv,
>  tt_common_entry->vid);
> -                       batadv_softif_vlan_free_ref(vlan);
> -                       batadv_softif_vlan_free_ref(vlan);
> +                       if (vlan) {
> +                               batadv_softif_vlan_free_ref(vlan);
> +                               batadv_softif_vlan_free_ref(vlan);
> +                       }
> =20
>                         batadv_tt_local_entry_free_ref(tt_local);
>                 }
>=20

--=20
Antonio Quartulli


--RIORWmusI1jisF0Cx6JXjLEhPniqCUtKw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVCvLgAAoJEJgn97Bh2u9eDeAP/17UsTzwA6vAvvlYIzVpFDHT
TZmAIc+ga9rU3lLoX5biEVwo1ELgiMb+XeiN0rL0U+BfUu44GqTo8g+10BPRHwld
aeoP4PHZ6i7gjekUxoPIAIoVo45fnL1xAVecmFi1IarqZxNdojINnWfpwO+gq7O7
SKanCGtj2qHC2fQ3jokAyRPpBiuwt08WOAQRaD2XfpF/lrlf3iH03d/Y+q2/A+EJ
zljsS/euIVSTN/Ye832FOBBpW3Ke5no3s5pF+u0Fnxq12dZ4GoxgfELA1QyBiSh3
azWK3Uo8OC5H1KpsYgpH2rRB4Sffd0LSoymXcI2njQXwaMd1+iTlJR4P9QG0wU/F
ML5XRrXcoGK0QYqMvuRF6Mj/imukq7nEuE0eX9OOx5dq1UMoKgMzfRu8HAJFJP3M
VO7+hjM9EDNmgtw9e6nN3LSVLmicfzz2rU1H6hAb6jcYOM7sW5c8COcxBhqT92G6
2NWVPklPTC7C2teOvj/9/+uZX1sMVr5800PKvYHgBpKO063JdMntBbB/s5q+jntX
ZroO+YrHg3I43E0xcoewEriTzVOl+zWpfEwjRKGRvBBzZVsvO7oxy4rTbAz49ecc
8zNKTMGQG88PcRQGBXjQuQyQF/GA7Pgsg52V5kFmBCpJ16QE+9xlq3lgjrKQzaCm
Z+mL6A2XJIK2bBDWqkE+
=4r09
-----END PGP SIGNATURE-----

--RIORWmusI1jisF0Cx6JXjLEhPniqCUtKw--
