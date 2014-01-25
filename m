Return-Path: <antonio@meshcoding.com>
Message-ID: <52E38150.3010903@meshcoding.com>
Date: Sat, 25 Jan 2014 10:18:08 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAL0=0H2MA7WVq7wkEBsatEOV1S-RevY2KXSHeAEgHsLdtBddRA@mail.gmail.com>
 <20140124164713.7e0fceadfe444297f4fd7350@gmx.net>
 <CAL0=0H2-u+NQhXNiYc=EuZkY9ZsK5dc7o1ka3_tVmoovJbpopA@mail.gmail.com>
In-Reply-To: <CAL0=0H2-u+NQhXNiYc=EuZkY9ZsK5dc7o1ka3_tVmoovJbpopA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tplO9XGMQNWKgva544EK8nwBOMSMcUlDW"
Subject: Re: [B.A.T.M.A.N.] Is BATMAN alone enough to create wireless mesh
 networks?
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
--tplO9XGMQNWKgva544EK8nwBOMSMcUlDW
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 25/01/14 01:29, crocket wrote:
> So is BATMAN a full-fledged alternative to 802.11s?

No.

802.11s is implemented at the datalink layer (actually inside the
mac80211 kernel module) and provides you a way to establish a connection
with other peers.

With batman-adv you first need to establish the connection with the
other nodes by means of adhoc or infrastructure mode (or any other kind
of connection that creates a virtual Ethernet interface).

Therefore when using batman-adv (or batmand or bmx6) you first need to
establish a datalink layer connection and then you can use the protocol
on top of it.

In the case of 802.11s the datalink connection is handled by itself
directly.

I would say that it is a small difference, but then the sentence would be=
:

"{batman-adv + adhoc mode} is an alternative to 802.11s"

batman-adv took this approach because we believe that there is no need
to re-implement something that we already have (e.g. adhoc mode) and at
the same time this gives batman-adv more flexibility (it can be used
also on top of wired Ethernet interfaces).


Cheers,

>=20
> On Sat, Jan 25, 2014 at 12:47 AM, Elektra <onelektra@gmx.net> wrote:
>> Hi  =96
>>
>> B.A.T.M.A.N. refers to a routing algorithm.
>>
>> There are implementations of the routing algorithom at OSI layer 2 (ba=
tman-advanced) and layer 3 (batmand, bmx6)
>>
>> You can use all 3 variants for Android to build wireless mesh networks=
 and people are actually doing so (Serval)
>>
>> Integrating batman-advanced into Android requires you to not only have=
 root, but also provide a batman-adv kernel module that fits the kernel o=
f the device. This is fine, if someone like Google or Cyanogenmod would e=
nclude batman-adv in their Android builds, which would merely require to =
enable building the module in the kernel build process, as it is shipped =
with the vanilla kernel sources.
>>
>> batmand and bmx6 are user space programs that merely alter the routing=
 table. Integrating these is easier, since you merely require root permis=
sions to run them.
>>
>> Cheers,
>> Elektra
>>
>>
>>> I've been searching for wireless mesh network solutions.
>>> BATMAN showed up in google search results.
>>>
>>> I just wonder its role and the future of it, and I want to know if it=

>>> can power wireless mesh networks in android phones.
>>
>>
>> --
>> Elektra <onelektra@gmx.net>
>=20


--=20
Antonio Quartulli


--tplO9XGMQNWKgva544EK8nwBOMSMcUlDW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS44FXAAoJEEKTMo6mOh1VmPgP/ibrg2lvuSqMBrbdFopYFKPN
nXVVPckbTAsPpCdakB+mXFYUTm6VJQb8hr12ciEWvUX9+0H2O+qbzItl/+1FHIQX
M/cgM1ZlQ2qXHErfWasJly54wTq9iIe7NvNPnHJajm5iFYJGNjKDfeHawQMsNe/s
WKooPHPN2m1+8BXXcEMQrbKhcduDFNtOsWywSigQFMAevkyth3OwobE4oni95dyy
WoSOAX49KL4PGwoU/fgRMuOUMpW6eux5OoxuSBRNEGOU4r9Fv4Ik/ZN7BVZazGwH
xPFJl1I713JQiA4wwKkkeGUkM7n2WsD0XJQq30rcKUE9wqZNqHefePfqmcpHZlgk
9NwYqDfX9f/OKPVvruYoMMCj1bznfJ1ZEBfb4dvi0+tMOAuLOPoZhCH3RwvskUH5
1sY7991k2q4Q/CY+LFo6XpAvSMaSB8PEHgu/KuDQGi2uYh8qaLuNZrFYTriS3aY7
YGKk3KQ1Vsbfqm89lUQbhGiG7CRcqYCPmZm/rSnL0mjvWfbJXkYtF/rRuJ9Dp9qc
9gRV2xqXFn7ajLSlTUDySUnud7M+v1sMAWnLqHeWLjtHaclx1Ig7H9DnzGYuiL8i
qm4MewCTKB5Z9eW3tEOL3JjmvPVVNaeuC9z4lemRqYfNU4erEW3XMsnm2Ijr9yjt
8NuLBj68Pf4SRlGbjc7m
=NCuu
-----END PGP SIGNATURE-----

--tplO9XGMQNWKgva544EK8nwBOMSMcUlDW--
