Return-Path: <antonio@meshcoding.com>
Message-ID: <52FA0252.6040209@meshcoding.com>
Date: Tue, 11 Feb 2014 11:58:26 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392114403-4069-1-git-send-email-antonio@meshcoding.com>
 <52F9FD08.9040307@meshcoding.com>
In-Reply-To: <52F9FD08.9040307@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LoA25GvJLFfq2mR9mqnEuffExrMF2P5hd"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix memory access by setting
 mac_header in DAT
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
--LoA25GvJLFfq2mR9mqnEuffExrMF2P5hd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 11:35, Antonio Quartulli wrote:
> On 11/02/14 11:26, Antonio Quartulli wrote:
>> In the TX path we now have functions that rely on the
>> skb->mac_header field. DAT does not set such field when
>> creating its own ARP packets thus leading to wrong memory
>> access.
>>
>> Fix it by always setting the mac_header after having forged
>> the ARP packet.
>>
>> Reported-by: Russel Senior <russell@personaltelco.net>
>> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
>> Tested-by: Russel Senior <russell@personaltelco.net>
>=20
> This patch is supposed to be applied on maint.

Introduced by 41b38727749a94c1a65cf0f4be9bfe1cbaf0adeb
("batman-adv: fix potential kernel paging error for unicast transmissions=
")

In this patch we have the introduction of eth_hdr() in
batadv_send_skb_unicast() which creates the problem..


Cheers,

--=20
Antonio Quartulli


--LoA25GvJLFfq2mR9mqnEuffExrMF2P5hd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+gJWAAoJEEKTMo6mOh1VHCUQAKH2mEVVdSHnhsNOTuZPEyxd
k5Ml2x5usOZOv95Knr7eC5ajLtiLoKeWZayhxpzr5RYVqZbQyzqmjVhwA+lBQ9wf
aTk5maii0kz0DmBm3QCC1m2XhuDEy01I6YGUJk0Y8qn3ixnoLkkYCmmwB6SscZFg
je+1wJC02OSoQbsayYrqqr5UgZaiVpS5LeDT2Dl4AkHue8agOgiIRTqZNFtXbBEV
EQhAOF9i26g6cIXKRY6rB04eQWhER+e5iUxcXOQ52goSWH8DEok3hA9jwXuxfxW0
QbMpzHbEbp2E0XWSVskL1XMVCAEWuARQX9vwEY6+fVhr6lTb6ch/xAm+QHV+KQsb
6dGnfnd1a5Md2nzIoe9BSKRNz1bHKNVHEwcylHsJPwzALjDQkXDX+kTBDxOEyEN6
amIDHs1d8Y4HvX7yqAIoeuqGjC8vfI3sfQQGm+EhB4p3WhFOZoOjCiDkIo26uPKg
fu4WDqV+j+dl+1qoRTusnq0SDGl+uZswBe1rqtdto5Euff3r6Dia8YuijWP0yjkn
sS6HXGzFb5wpOrsDImJvZwZ/ZmaTSSoMLMJ1cvcYaZ60x2cXGX3yeoGlKCvp73be
qk4wjsjVtntbmy1nhzgzNsxgCNAngfsDIe0jQwJn7NBksNbfJCW7mL/Yegs+eWhf
yF0oyNFCIOmmelZWDsAJ
=+JPo
-----END PGP SIGNATURE-----

--LoA25GvJLFfq2mR9mqnEuffExrMF2P5hd--
