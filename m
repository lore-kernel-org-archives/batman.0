Return-Path: <antonio@meshcoding.com>
Message-ID: <52FA61BD.8040304@meshcoding.com>
Date: Tue, 11 Feb 2014 18:45:33 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1391874306-15627-1-git-send-email-sw@simonwunderlich.de>
 <52FA5DE6.8050005@hundeboll.net> <52FA5F12.5090406@meshcoding.com>
 <27300725.U6R9joZBFU@diderot>
In-Reply-To: <27300725.U6R9joZBFU@diderot>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MihHrEEWpoWorbS7BXt2EKceOvhUtnQK4"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: fix potential
 orig_node reference leak
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
--MihHrEEWpoWorbS7BXt2EKceOvhUtnQK4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 18:40, Marek Lindner wrote:
> On Tuesday 11 February 2014 18:34:10 Antonio Quartulli wrote:
>> true, but since the orig_node has not been returned yet there is no
>> other component in batman-adv which is using it.
>>
>> Otherwise, we may want to define and invoke a free_now() version of th=
is
>> function (like we have done for other objects). But I think kfree() is=

>> safe here.
>=20
> It may be safe now but will surely be forgotten later. A guaranteed sou=
rce for=20
> trouble. That is why we have cleanup routines for everything.
>=20

True, in particular because we (as bat_iv_ogm.c) do not know what
batadv_orig_node_new() has allocated - a kfree() would be fine if the
object was allocated with a plain kmalloc(), but this is not the case.

By the way we have a bug here:
if we jump to

 256 free_bcast_own:
 257         kfree(orig_node->bat_iv.bcast_own);

bcast_own gets free'd but not assigned to NULL. Later
batadv_orig_node_free_rcu() (scheduled by batadv_orig_node_free_ref())
will call batadv_iv_ogm_orig_free() that will try to kfree() bcast_own
again (line 98 in bat_iv_ogm.c), thus leading to a double free. no?


Cheers,


--=20
Antonio Quartulli


--MihHrEEWpoWorbS7BXt2EKceOvhUtnQK4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+mHAAAoJEEKTMo6mOh1VZ2wP/j5oGYyagZpGGuaFsiJeBg1R
UvXbhm0uYCNOtYXMs/EO6y3TwxSZtpOpYsx1ZW/XDA/Kdcm9npOcveuHfmsXM20/
3kB1bGxJiFIlQhIj2vyRHbPhOVAyWdGmNoPO+UOGtfrNSRgOmFUH5FbBAiKCOijI
Wv1iPYd2c9SptidsDVjQTFYunf4xzwP8yRk2iaFAm9NuQDCFwSEgx5DyxNoGrwkR
r9IEwGfZHFjtIIOSwVsU4DsnG+07LXVDZ67hvPggRWgdTpiMN8aQ7MWtv7Nrhrf4
+aaH+NXHMYaNb7/l8H0WkV/mJwQ6oM6vbK9ozPrhf4f/YZ3IjMiwLSNdFptPqcAJ
hF5ggxKc+alRnGKUA9e5gn5BTtSyAbzwTADZMh47eIAEzo6sfF7pazbthXDLkqRL
5JumEju0+f+R7Z3rEPZVwGgLnuhSRbEtg+LwEa0u+DdV48YW4twzVN3Ovn3s/QRD
TC2+B0EPixFyMYNFXO+gXWW+86S0A9fJ+tsHA9Evji4KLfq2Ltagy1CiLRH5hWNO
Nunjrf13gUZWyxgxfSj/oNV99KoYWj8bxZVaygFzshhKSTESKly+9iZ6Camn4Rz7
QBqchAvAqmSb+zCDGtYle2kPsfu09JGVKZofje2s6rmcIbebSkrpBAEKIoxDR+ub
k6t5UTJXbLG6Kc2f3dfi
=Oyok
-----END PGP SIGNATURE-----

--MihHrEEWpoWorbS7BXt2EKceOvhUtnQK4--
