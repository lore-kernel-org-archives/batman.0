Return-Path: <a@unstable.cc>
References: <1447443981-28246-1-git-send-email-sven@narfation.org>
 <569D85AB.9080403@unstable.cc> <20160119012226.GE26877@lunn.ch>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <569E2D72.4010304@unstable.cc>
Date: Tue, 19 Jan 2016 20:34:58 +0800
MIME-Version: 1.0
In-Reply-To: <20160119012226.GE26877@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ov5llbkguPxh3qx72weCJj4O8DWP74JWr"
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jetmir Gigollai <jetmir_gigollaj@web.de>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ov5llbkguPxh3qx72weCJj4O8DWP74JWr
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 19/01/16 09:22, Andrew Lunn wrote:
> On Tue, Jan 19, 2016 at 08:39:07AM +0800, Antonio Quartulli wrote:
>> Hi Sven and thanks for this RFC. Sorry for taking soo long to comment.=

>>
>>
>>
>> On 14/11/15 03:46, Sven Eckelmann wrote:
>>> batman-adv checks in different situation if a new device is already o=
n top
>>> of a different batman-adv device. This is done by getting the iflink =
of a
>>> device and all its parent. It assumes that this iflink is always a pa=
rent
>>> device in an acyclic graph. But this assumption is broken by devices =
like
>>> veth which are actually a pair of two devices linked to each other. T=
he
>>> recursive check would therefore get veth0 when calling dev_get_iflink=
 on
>>> veth1. And it gets veth0 when calling dev_get_iflink with veth1.
>>>
>>
>> I agree that this check implemented this way represents a problem.
>> However I also believe that we should still have some kind of preventi=
on
>> against this particular scenario (chain of batman interfaces), because=

>> if ignored it could lead to troubles.
>>
>> Unfortunately I don't know how to implement this check in an elegant a=
nd
>> extendible manner.
>>
>> First of all we should add a check that follows the master interface,
>> but at the same time we should still follow the iflink, otherwise we
>> can't check relationships like VLAN_DEV->REAL_DEV. But how to implemen=
t
>> the latter without hitting the cyclic case is not clear to me ..
>>
>> An option is to add a specific check for veth and break the recursion,=

>> but this is not really nice, because the next time a cyclic interface
>> type will be introduced our check will become troublesome again.
>>
>> Suggestions?
>=20
> Hi Antonio
>=20
> I've got a set of patches i went to send out as soon, once net-next
> reopens. They add support for network name spaces.
>=20
> One of the issues i had is in this piece of code and with veth. The
> other end of the veth can be in a different name space. Hence you
> cannot look it up using the ifindex in the current name space. So i
> made the code just exit with an O.K. if the parent device cannot be
> found.

Is this really ok ? Isn't it possible to create "loops" by jumping from
one namespace to the other ?

> =20
> Something to think about when redesigning this code. The parent could
> be in a different network stack!

exactly my point above! :)
So this means that an interface A might have A.iflink pointing to a
device in another namespace ? Is this what you are saying ? will there
be any way to "retrieve" the namespace of such device?

>=20
> You probably can handle veth and both ends in the same namespace. It
> should not be too difficult to detect two interfaces which are the
> parent of each other. You just need to keep a bit more state when
> doing the recursion. It does however get more complex when there are
> more than two devices in a parent loop. But can that happen?

first of all I'd like to answer the question: which device type can
create a loop? only veth? or there are other possibilities?

But having more than one interface in the parent loop should probably
never happen..

This said, what's your plan about this code? How are you going to change
it? :)


Thank you very much for your feedback Andrew!

Cheers,

--=20
Antonio Quartulli


--Ov5llbkguPxh3qx72weCJj4O8DWP74JWr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWni11AAoJENpFlCjNi1MRteEQAIAdB9rL0pJN9SdbNhMTFDT+
coh4ilGm1kwq9g3dmlllHCbAWgV0XEhNeipggazQPQyAaTwsUYySZhmf6kWtECMB
E8WH7xSXIhBVi1lewKfYIafEDuoY/8DGGz7XHTw+eOS1dL414HDnFIKfGnmoULoc
+rRFFAK/fb/sP5uoPRFU81CHasIxpGfgvYhVX98QH/xXWnxC8Rrc/2ny55HO7wk/
1/PJqBBVyl+HVQVvgJJ5A+oYBdw+h57Jux/tKFo5hlq0lYS+djbXGbAZWhCoeHiN
nrsmWcI5YwBZ4zJFDKAV48Mn4L0K0jeqNNZMpnqO6M89hrjzq8p115jpQ4hl8gCB
JP28A7RjyRWGk+jVnSQ0H3MgdWygZIJAr69JwTnavAXMksEQdTHlQmLVphflG0hJ
Lnwxzoq7yDoa9Y8mxgVO66FzXD8TwYuZxtXBvUUNug8rExHZsBo4cy6QMXDLzQJH
DFlQFr4apNdSS3HzmdsxbHd2Lv68UrjV0UwJHml5ZdFtJy5gNmgHqRcPnbdgVmEd
l7QSsVB1XHzZ80CXxXNN7KTtYG6bgjnZw92bgFIxyDFJOmaL4QGHPZZWge/GSqtM
u7lWJS7h8vjwxdqoeqeuBPjKUWKiEboxes/pG8PQzXS56LIlYvWp+el6YEryOx7s
TS2TJ/pGDHreLkWedkv2
=g9+z
-----END PGP SIGNATURE-----

--Ov5llbkguPxh3qx72weCJj4O8DWP74JWr--
