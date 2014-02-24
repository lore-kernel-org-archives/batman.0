Return-Path: <antonio@meshcoding.com>
Message-ID: <530AFF5A.8010901@meshcoding.com>
Date: Mon, 24 Feb 2014 09:14:18 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1393196418-4001-1-git-send-email-antonio@meshcoding.com>
 <1702820.sOKJFjBZI7@diderot> <530AEB3B.1050501@meshcoding.com>
In-Reply-To: <530AEB3B.1050501@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sKEMgkF06BG56x3WwjoGdwOFdPoB2CSD5"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix merge resolution
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sKEMgkF06BG56x3WwjoGdwOFdPoB2CSD5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24/02/14 07:48, Antonio Quartulli wrote:
> On 24/02/14 01:36, Marek Lindner wrote:
>> On Monday 24 February 2014 00:00:18 Antonio Quartulli wrote:
>>> --- a/send.c
>>> +++ b/send.c
>>> @@ -255,8 +255,8 @@ int batadv_send_skb_unicast(struct batadv_priv
>>> *bat_priv, struct batadv_orig_node *orig_node,
>>>                             unsigned short vid)
>>>  {
>>> -       struct batadv_unicast_packet *unicast_packet;
>>>         struct ethhdr *ethhdr;
>>> +       struct batadv_unicast_packet *unicast_packet;
>>>         int ret =3D NET_XMIT_DROP;
>>> =20
>>>         if (!orig_node)
>>
>> Don't we want longer declarations before shorter declarations ?
>=20
> Yes, but the point is that there is no patch doing this change.
> This line was moved during a merge...
>=20
> If you want to rearrange the variable declaration I'd suggest to do it
> with one patch changing them all.

Ok, as agreed on IRC you can drop this patch. I'll slightly change my
kernel tree to adapt it to the master branch :)


Cheers,

--=20
Antonio Quartulli


--sKEMgkF06BG56x3WwjoGdwOFdPoB2CSD5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTCv9fAAoJEEKTMo6mOh1VlBoP/0zT5vFqe4kWdIHPDRZlTVk/
CKzFh/yc62qIJz6gcJUPuV1/6Hj8iHuXRea8ghXfNmmvWdELcDXxMgrWEnvoZLLM
LJZ3uK9zfRsiTERn0j2aIvlNEMg7ZWQP3pffLnDSdmRIxIysFGUuRVUMTYF9dyd2
BGBat3ISb8EhhgXMcuLc+Qxz/Cx1h3NKWIR5JZomA7ZR/aWhRYnW7uT7KP/IIJyY
GWqMPWsZZsY1/P4lmp71pr5HujT8LUz7uRh8sFKb6sL6RtmRCKcRD8JQvMGodSEm
xKa+42GVtntngohdAeN1oILwRabWHJfv0XINXXQxaWm7EX2QTcBgrMjnEldn7qGs
zRRlL2phwxsXIPAX5cJBNeVXA8yEaM10oI/dloTIi29Gp4VurljDCvTVqpTtthyM
3d0LKg4RRQ6ZLqbVkVK2AlmCN7hSH1WwFOr+KP/jcU5UQYY7KOxJltBGOZ4jLGB3
cqfb0lqStgvsY6uPCMjvT2iLNtzpHqystUN150gSn6SwVeT14lJq7qaP2XQ3dcmU
qbVCbrb55XQE+NehSKhkXyS7UqVKOvic3Y+2PuEU1fd8sMJaeJ+Sm4FbtHvbFzde
UFb/3tXDF7/DuxLSxI6IbSZql8uB964KskhRdF57/6LhMMGykgRrB04EgB1TXVaC
/Ud7H+CIP7Yag/gj6rZP
=WVIe
-----END PGP SIGNATURE-----

--sKEMgkF06BG56x3WwjoGdwOFdPoB2CSD5--
