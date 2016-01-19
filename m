Return-Path: <a@unstable.cc>
References: <1447443981-28246-1-git-send-email-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <569D85AB.9080403@unstable.cc>
Date: Tue, 19 Jan 2016 08:39:07 +0800
MIME-Version: 1.0
In-Reply-To: <1447443981-28246-1-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="k4oUBxlWHkTCtcQieObVdV0xCPT3DwU0w"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Remove recursive bat-on-bat
 netdevice check
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: Jetmir Gigollai <jetmir_gigollaj@web.de>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k4oUBxlWHkTCtcQieObVdV0xCPT3DwU0w
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sven and thanks for this RFC. Sorry for taking soo long to comment.



On 14/11/15 03:46, Sven Eckelmann wrote:
> batman-adv checks in different situation if a new device is already on =
top
> of a different batman-adv device. This is done by getting the iflink of=
 a
> device and all its parent. It assumes that this iflink is always a pare=
nt
> device in an acyclic graph. But this assumption is broken by devices li=
ke
> veth which are actually a pair of two devices linked to each other. The=

> recursive check would therefore get veth0 when calling dev_get_iflink o=
n
> veth1. And it gets veth0 when calling dev_get_iflink with veth1.
>=20

I agree that this check implemented this way represents a problem.
However I also believe that we should still have some kind of prevention
against this particular scenario (chain of batman interfaces), because
if ignored it could lead to troubles.

Unfortunately I don't know how to implement this check in an elegant and
extendible manner.

First of all we should add a check that follows the master interface,
but at the same time we should still follow the iflink, otherwise we
can't check relationships like VLAN_DEV->REAL_DEV. But how to implement
the latter without hitting the cyclic case is not clear to me ..

An option is to add a specific check for veth and break the recursion,
but this is not really nice, because the next time a cyclic interface
type will be introduced our check will become troublesome again.

Suggestions?


Cheers,

--=20
Antonio Quartulli


--k4oUBxlWHkTCtcQieObVdV0xCPT3DwU0w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWnYWxAAoJENpFlCjNi1MRIMwP/30bafBOyL4GyB31WojzMA3I
zifZTSIsPJQfEtymjt5XhsUFMLWOhooZLclO5vOH+4zQds5aGXxFWTgnE6+oZOYh
VRk2LU9WA5z4Vros7ElBTcy/zMSJDyNlkqFSbJdZ1DfQ98sLrzvgB3q4yqnu6R20
9H6T/Y1V8RoTTDFdUUlooVHXJ/ut96tpasyXylBptaIo5+1W9qRCJM35Ihz+esiT
/WbB6teXLmS43JUhY/wIXHWHMUFqxY4mhG8vEIxF2PZcumM6DuW9byKYFXuD/YhK
IbNion6w1+tCpKw51gKVbi/6ZiWVEEWYHSj0B/yP4FgOrOOqgem5vlhi5gMtM+BE
n+Vu+6Xg7WXiOmI6mVyey5vo2ZhfAeolPfQv74fkRLSl0qamCVBFP34E3t7yF3Cm
i/EzpOd8/EgDPGkHbgi/Atcw8mrHqr1xy76JYloD0UAvMOu4mCvDCqahHHa0qF30
fp+3z4juR/uZ/Nkd45QQoiFAIZdBWuocNi+rOJ2UtVdzjBqbCaq/JwCfXP+Fb7E/
tYNT94A8dpxR2I9FTG/lRzee9kAmA8gMM/4HXxM79XB2sjIj2rgZhoQStpS9uhU+
ghJ+Ee+uwrroItdvO4f7YytgrwrQmzT4/x0HWeHsTtyUInUZhIPwydpVr7f3gkmx
vOHc7u9LiPFQf3vWUB3z
=Y8If
-----END PGP SIGNATURE-----

--k4oUBxlWHkTCtcQieObVdV0xCPT3DwU0w--
