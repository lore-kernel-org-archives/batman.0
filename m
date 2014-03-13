Return-Path: <antonio@meshcoding.com>
Message-ID: <53218FEB.8000100@meshcoding.com>
Date: Thu, 13 Mar 2014 12:00:59 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAMcTwKrV4OVZP6v3hD2_4t8DWsmymGYgu9xMZa6aexrWQuORtQ@mail.gmail.com>
In-Reply-To: <CAMcTwKrV4OVZP6v3hD2_4t8DWsmymGYgu9xMZa6aexrWQuORtQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iWeNNU2eWh73kOpbHXe0FxD78nANGBkA3"
Subject: Re: [B.A.T.M.A.N.] IP connection lost when a node is rebooted
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
--iWeNNU2eWh73kOpbHXe0FxD78nANGBkA3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 13/03/14 10:24, Itamar Landsman wrote:
> HI,
> I am running a project using Raspberry pi machines that create a
> batman-adv mesh.
> Each of the rpis has three wifi devices. each of the wifi devices
> hosts a separate ad-hoc network. This way I can get to work on three
> separate channels and let batman worry about paths.
>=20
> My problem is that whenever I reboot a device, it comes back to life
> but IP connection is never regained until; I reboot all other devices.
>=20
> I have tried to move the IP address from the bt0 interface to a bridge
> interface that hosts br0 with no success.
>=20
> Any ideas?
>=20
> I am using the "Out of the box" batman-adv modules and batctl that
> come with the most recent raspbian repo.

Unfortunately I don't know what version of batman-adv is shipped iwth
raspbian. Can you check the exact version by typing "batctl -v" ?

This "issue" seems similar to something we already talked about in the
past: it's a side effect of using DAT.

DAT caches ARP entries, therefore when you reboot your node and bat0
gets a "different" (randomly generated) MAC address, you should wait for
all the other nodes in the network to drop their cached ARP entry and
request the new one associated with your IP (this is a simplistic
explanation of how ARP usually work).

I hop I made the "issue" clear.
You can check if you are really using DAT by typing "batctl dat".

For more details about DAt, please check our wiki[1]


Cheers,


[1] http://www.open-mesh.org/projects/batman-adv/wiki/DistributedArpTable=


--=20
Antonio Quartulli


--iWeNNU2eWh73kOpbHXe0FxD78nANGBkA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTIY/vAAoJEEKTMo6mOh1VIuUQAIOUBugio//E1/ZYdEx636CX
n4XPY87UrrGgWiy9myyPOhLKO7u03SfKwn1eCM85Bm+iDq5EGLKdMt6+NEkqYR2e
Y+aGYlBknDoIP2+n8S8m84mDV35Mi/B7hI/gP23+lHkJAqeHMZZHIbGn4DokQg9B
cK3iixOeFiI0ewW8WOalpPvKf/kXQNT0hiAK2Er/8jo10bzBTXOFxwDRJeQHUFmP
8/v5Q76J09rEWb3xxYKgDx269ne9F95MB1NVErkG/m1F2/rw0WyblQcAg9Avp6WX
BawpZ/lOb0+WQNExMnSUbAl/pnluWNx5ce2Lkr4wS3fHrvnFpwFlwz4Ro8bXxe8J
Prx35kJFQ0mqB58NoxE2TvdozC2+KVXLEhZCrRH5n+gV2sTD7hsJDFa2c7iJROGA
bRJrMplPHUDFOI9nLl3kCHMvPTYLQqPdLANL5JKACaXx4t8NnUXpdDYA03ZN8iMn
stCO5u4QGGz18JA9YEq6SeHoYUmgiurxvnDS44/4S6YNhx0xyc8jhQKAp3F41b38
JhPEhN6cBWvbm+l6UQk8WadAGxNXDaDb79TxcRSmgKPxztTmO3E4nMN4c0bAEDMu
GXRHUyp9p93c7Avlbh8oc7gak/OmKRexd9kCvTnZJUcF/jFdoag6KFXl0k8R0eEJ
Ki4PvFV0aoiAnsoVpjaj
=Jc2c
-----END PGP SIGNATURE-----

--iWeNNU2eWh73kOpbHXe0FxD78nANGBkA3--
