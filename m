Return-Path: <antonio@meshcoding.com>
Message-ID: <52FB29BA.9090005@meshcoding.com>
Date: Wed, 12 Feb 2014 08:58:50 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-8-git-send-email-antonio@meshcoding.com>
 <20140211171207.GE24633@lunn.ch> <52FA6347.2050901@meshcoding.com>
 <20140212074422.GB30814@lunn.ch>
In-Reply-To: <20140212074422.GB30814@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bHJOO6BQkCsqrA6qARh3gg8SdIRXUkoEq"
Subject: Re: [B.A.T.M.A.N.] [RFC 07/23] batman-adv: OGMv2 - add basic
	infrastructure
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
--bHJOO6BQkCsqrA6qARh3gg8SdIRXUkoEq
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/14 08:44, Andrew Lunn wrote:
>>>> +	bat_priv->bat_v.ogm_buff_len =3D BATADV_OGM2_HLEN;
>>>> +	ogm_buff =3D kmalloc(bat_priv->bat_v.ogm_buff_len, GFP_ATOMIC);
>>>
>>> Maybe use kzalloc to ensure it is zero?
>>
>> Not really needed because each field is explicitly assigned later. But=

>> to be sure we sit on the safe side we can do that: in the end we are n=
ot
>> in the fastpath here.
>=20
> I know some of your structures have explicit align bytes. It would be
> good to ensure they are zero so that they could be used in the future
> without having a protocol version bump. So i think it is a good
> patterns to follow in general when not on the fast path.

True. _I_ had this problem in the past already :-)
I'll use kzalloc then!

Thanks!


>=20
> 	Andrew
>=20


--=20
Antonio Quartulli


--bHJOO6BQkCsqrA6qARh3gg8SdIRXUkoEq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+ym+AAoJEEKTMo6mOh1VzQEP/0un7RnfQ5lWzCcNcXCWdHLD
/haJbLzTnkur1Z44IXm5h7iBgvLuPGlTWd1PgTThEyN69nDTW5YYGCBGcWqqZzn2
NJEZnH5Iw95p16Y8xWlnvnK6PDrWNe0TJBbbkvFmp1ZSb2ZT/uxOHFWiHZWTC2BL
Fb6uwkq77wKJNk+NN+DUrwyVB4xp43TGkq1Gv0Y9+2Hz89Pg1PmRaQvMvtDWp/XD
HgixGt0e5EynlNSzkTnFNjyqVRRodlqHinMCEnYWOQicpr5ulQuF8xDAyk4ssGh6
auaLG37gEx5CbJsTbCvfomKxUqLHifBcfSbytsTzog95V7Lu/oacNQLmyXOsnxsR
YTGcD/NZMsxAy67Pirx9VpA8/Wi2lLvIBZpGhcEO1RJ8ZKOkCp7n3mL/Iq0JDvWt
QWnL1H/cg3XmHJDpDk1V88TX3rRYzRak6uwgalBMTMRPX7KWJEX8XPmeRLfGbyWB
z9a7LgmtToi367+nV9GP8AnYu8rOzpdTknJHtzuSbTT8rcqPFX664JiFq+5Yqcnw
PGov7xx5S+k2oxwPs2PEvNu9KVY0Hql92teTRpFoeZ0AuJ+aKaQZPVxMgFd/pL/H
HPyJmZzjAD7s4q6kO9gcZ+CVAETfoSTM0U+lYkWdP/i+7zPY4UvFOpTv5+wGuHgr
OoOsRJ2LC32k9ioVV5iP
=zoz4
-----END PGP SIGNATURE-----

--bHJOO6BQkCsqrA6qARh3gg8SdIRXUkoEq--
