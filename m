Return-Path: <a@unstable.cc>
References: <20180310235321.1324-1-linus.luessing@c0d3.blue>
 <2042233.hTAz9L1TrL@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <8d6c7fcc-7681-721b-554d-9110574ed5b6@unstable.cc>
Date: Tue, 13 Mar 2018 16:02:34 +0800
MIME-Version: 1.0
In-Reply-To: <2042233.hTAz9L1TrL@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="u2yu2RveSu06v8SruQhWZyrJFPfcERKXW"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 0/2] batman-adv: netlink support for
 DAT and MCAST
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u2yu2RveSu06v8SruQhWZyrJFPfcERKXW
Content-Type: multipart/mixed; boundary="2fY6B3z7F5q0gWMZmnchJseeifQme2uMv";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Message-ID: <8d6c7fcc-7681-721b-554d-9110574ed5b6@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 0/2] batman-adv: netlink support for DAT
 and MCAST
References: <20180310235321.1324-1-linus.luessing@c0d3.blue>
 <2042233.hTAz9L1TrL@sven-edge>
In-Reply-To: <2042233.hTAz9L1TrL@sven-edge>

--2fY6B3z7F5q0gWMZmnchJseeifQme2uMv
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 11/03/18 18:54, Sven Eckelmann wrote:
> On Sonntag, 11. M=E4rz 2018 00:53:19 CET Linus L=FCssing wrote:
>> This patchset adds netlink support for dumping DAT cache and multicast=

>> flags tables.
>>
>> Changes in v2:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> - Added missing includes, "#include <linux/netlink.h>" and
>>   "#include <uapi/linux/batman_adv.h>", to distributed-arp-table.c
>> - Added missing forward declaration for "struct netlink_callback" to
>>   distributed-arp-table.h
>> - Changed nla_put_u32() to nla_put_in_addr() for BATADV_ATTR_DC_ADDRES=
S,
>>   removed the then obsolete ntohl() conversion
>> - Added missing include, "#include <linux/netlink.h>", to multicast.c
>> - Changed nla_put_u8() to nla_put_u32() for BATADV_ATTR_MCAST_FLAGS an=
d
>>   BATADV_ATTR_MCAST_FLAGS_PRIV to enhance extensibility
>=20
> Thanks for the doing the requested changes.
>=20
> @Antonio: Can you please check whether you are ok with the new netlink =
names=20
> and types.
>=20
>> +       [BATADV_ATTR_DC_ADDRESS]        =3D { .type =3D NLA_U32 },
>> +       [BATADV_ATTR_DC_HWADDRESS]      =3D { .len =3D ETH_ALEN },
>> +       [BATADV_ATTR_DC_VID]            =3D { .type =3D NLA_U16 },
>=20

Personally I'd find "DAT_CACHE" easier to parse than "DC".
I know we have the "batctl dc" command, but that's more to keep the CLI
compact.

This said, DAT was meant to be extended in the future and not store only
IPv4 addresses. This said, shouldn't we use a more specific name for the
address?

Another observation: do these attributes need to be DAT specific? or can
we just define (or reuse) a generic HWADDRESS attribute that we might
already be using somewhere else (i.e. for TT)?


Regards,

--=20
Antonio Quartulli


--2fY6B3z7F5q0gWMZmnchJseeifQme2uMv--

--u2yu2RveSu06v8SruQhWZyrJFPfcERKXW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlqnhZ4ACgkQB6U8WA7y
zXSenw//ZkrP5Z8q+nGHF7HgUT5XOVldjBOXZirfQS/aAEfsQYh5FCBikEHLa0vD
NZF9QAkEAAu8bHVOGj+dS1pxxbGvocY38DO0sNU7OSMuTrC67LAdpJJCMZrBzuY4
kuusnrJmxFf/6XHXcP7Mn1366qOyE+vSsyZE/7VwdNPPixBvFkjB/xSje5GP7b5E
jHsnZlfpDedgetoQ5jgWszwD7t12NRngGq+uwHAi0KHSeA18RipthvFg9ZYKEiZq
Y9g9iqakwGNLfljvgbY36sVZ4WVSEjxoYSHB79OBNGVcFc5YUApWZXhMqXqFrwGe
riqWohWpheNHud1gLnUEl6mFLkeG/AkkllPyPjLMmusZNGlzbPmkXngKdZazBJ+m
4AIRDMZ8XDPn9fPBJxinwkjZ7RAeLq8A0CpVw4ScRvkMSuGURjxoRoxFP4zraH8p
q57UmE0lcXNsFILhaUTz6WnVXksjGasb/P4GUvbCjE5GU7ulCMgWpywrz83MCZ4c
p0u+nZhKybwQY33dvlJe1oyHlgJPeTqOIxV7+Y922ODLEkfr9T6s5y++ZLRITs23
O5QH72Rcphnn4kgjn6RdmFnChFIbYB7abdzlWntaTbXki1OlXhR1xQOE/QkXrpOF
g9pVcDFRTssKGny6UaAwakzHwm/2/NYf+myLFUsFOO0BeuboD4w=
=euIp
-----END PGP SIGNATURE-----

--u2yu2RveSu06v8SruQhWZyrJFPfcERKXW--
