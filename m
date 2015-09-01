Return-Path: <antonio@meshcoding.com>
References: <1440600113-21305-1-git-send-email-sw@simonwunderlich.de>
 <1440600113-21305-3-git-send-email-sw@simonwunderlich.de>
 <55E5692D.8090909@meshcoding.com> <1647977.TX5clMHFCZ@prime>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55E58C63.1090500@meshcoding.com>
Date: Tue, 1 Sep 2015 13:30:43 +0200
MIME-Version: 1.0
In-Reply-To: <1647977.TX5clMHFCZ@prime>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9elnV6Gp4epGnRhPR7lcDraGkrIHUxm3N"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv2 2/3] batman-adv: avoid keeping
 false temporary entry
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, alessandro@mediaspot.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9elnV6Gp4epGnRhPR7lcDraGkrIHUxm3N
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 01/09/15 13:00, Simon Wunderlich wrote:
> On Tuesday 01 September 2015 11:00:29 Antonio Quartulli wrote:
>> On 26/08/15 16:41, Simon Wunderlich wrote:
>>> In the case when a temporary entry is added first and a proper tt ent=
ry
>>> is added after that, the temporary tt entry is kept in the orig list.=

>>> However the temporary flag is removed at this point, and therefore th=
e
>>> purge function can not find this temporary entry anymore.
>>
>> When can this really happen? When a temporary client has roamed to a n=
ew
>> originator before it could be claimed by the first one ? Or are there
>> other cases ? I think it is important to make this clear, because the
>> original logic was such as the expected behaviour was to receive an AD=
D
>> event from the same originator where the temporary client was seen.
>>
>> Other than this, the patch looks good.
>=20
> I've seen the problem in that problematic case which was fixed in PATCH=
v1.=20
> Practically, it is unlikely to happen unless there is a malicious attac=
ker or=20
> another bug like the one described earlier - that is, speedy join is tr=
iggered=20
> without any actual TT update.
>=20
> The main problem I've perceived here was that the TT entry got the temp=
orary=20
> flag removed even if the original sender didn't supply a proper TT=20
> announcement yet. The reason for this was that it got a proper reply fr=
om=20
> another orig node.
>=20
> The roaming case you've described would also cause the temporary client=
 to be=20
> removed, but might be added later through a ''proper'' TT announcement.=

>=20
> Do you think I should include any of this in the commit message?

I think you should mention something that makes this case "real": I'd
just say that it is possible that a client detected behind a given
originator moves before an actual claim is made, so triggering this
particular configuration.

I hope you think this is fine.

Cheers,

--=20
Antonio Quartulli


--9elnV6Gp4epGnRhPR7lcDraGkrIHUxm3N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5YxnAAoJEOb/4TMchkvfNNwQAJoB4JXVeODPYTx7+7Jxrrnp
NQ87Kq6FL4grWggnmJ+kfJuG4ghC+AvEX+z6MJsFraTY1G5ZqhC3ZjGDriB/u4Ja
Y7IWagyz4H4dPmXaIqxz8uZ6LFJPQctjA/iKgPYSuu05DCxpF1yv2uj5zG1Z3sRd
TKQAsabUGfrTAnoIJZNDBj8kKoMLBaou3qNLcNYgPpMZ+5SlLoDG3omoEp15r+Zo
Tj5qhcl1wNYF/670VWO7DoX57Wd+wJUJjtGZSwHVfKYnqFQ0KXlpuXdkwuX5dZkV
xberJ/xP7Z3lV25qB6sdSxnvnPX8eEFo4mEX6mQhHoBiNBOEYQ5edZd9AblSMbKP
TK5GQhiXMY3eKFe/neaq1OmZRLcwqudA8kxEagJ4cPSihpyj1hz+h8nfgaEr4O2i
YTZf2CDlC2knjSwt+snLaXzXSRTyuXy21uH4r2dgl5QCsOFVVY2x88t3dVdRB7uD
2Iybh9ZQm8aejzf9kmgutJHjYdjATF2TqxjuK+/bCQRLYkXTrbN9P4mMBv6dMxuW
uZToPBZNRXW9BUmXsHWO0uOLVu2v4kbvTmS1lYMB5Dz8EZvXFbce+XOSGqKELAlL
22r80ARrErOa5hqey3+2m+OY1cj+MU1VlmmWLwkLo43/c5S3bZFisWZNQlvFBleX
tKUWYjMDUeT9hJNPDn+M
=gkyA
-----END PGP SIGNATURE-----

--9elnV6Gp4epGnRhPR7lcDraGkrIHUxm3N--
