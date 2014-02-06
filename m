Return-Path: <antonio@meshcoding.com>
Message-ID: <52F3625D.206@meshcoding.com>
Date: Thu, 06 Feb 2014 11:22:21 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <52F2968D.8050101@makrotopia.org>
In-Reply-To: <52F2968D.8050101@makrotopia.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5PCoGSBM4tx51xAE3xhECqVMOQaHpnVNN"
Subject: Re: [B.A.T.M.A.N.] question regarding gateway_mode server
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, daniel@makrotopia.org
Cc: Ufo <ufo@public-ip.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5PCoGSBM4tx51xAE3xhECqVMOQaHpnVNN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/02/14 20:52, Daniel wrote:
> Hi!
>=20
> Is there a way how I can prevent a local DHCP-server from replying to
> non-gw_mode-client's DHCP requests?

No. Batman-adv can only act as "DHCP facilitator" but does not act as a
firewall. I assume you have read the documentation about gateway mode at
this link:

http://www.open-mesh.org/projects/batman-adv/wiki/Gateways

> The situation is that we got a central DHCP server on the mesh which sh=
ould be
> used by all nodes which do not have gw_mode set. In my understanding, s=
etting
> gw_mode to 'server' on another local DHCP server should prevent that DH=
CP server
> from receiving (and thus replying to) requests from clients with gw_mod=
e set to
> 'off',

No, it does not work like that. As I said before batman-adv acts like a
facilitator if the GW feature is enabled (server and client) but if it
is off then DHCP packets are delivered to the entire network like any
normal broadcast packet. I think this is explained in the doc too.

however, it seems like the local gw_mode=3D=3Dserver node occasionally
> replies to gw_mode=3D=3Doff clients (seems like the usual
> more-than-one-dhcp-server-on-a-subnet race condition)

Correct, because the broadcast packet reaches this node eventually.

> I'm aware that this could probably be solved using ebtables, however, d=
ue to the
> high performance impact and ugliness of ebtables, I'd prefer another wa=
y to fix it.

ebtables is not the only solution, iptables can be used to filter any IP
packet as well (which I guess is what you have in your network). For
more details about how to use this tool I'd suggest you to read its doc
directly (about kernel and userspace usage).

> Am I getting something wrong regarding the intended behavior of gw_mode=
=3D=3Dserver?

I think I explained this right above :)

> If needed, I can write a patch to implement that functionality and have=
 a
> gw_mode=3D=3Dexclusive_server or something like that in case the curren=
t behavior is
> actually intentional.

This is not an easy task to address because you have to understand from
which node the packet is coming from and with the current infrastructure
this is not easy: consider that a client might be moving from node to nod=
e.

In conclusion I think that any possible implementation would add quite
some complexity that is absolutely not wanted given that there are other
tools in Linux which can properly address the situation.


Cheers,


--=20
Antonio Quartulli


--5PCoGSBM4tx51xAE3xhECqVMOQaHpnVNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS82JhAAoJEEKTMo6mOh1VRMQP/i3QDQO6yvTWfVbwWHgdurZX
UTE/slLh/6NK2V5rcdydDHTIjemuQFMrZ6KzF2DHg5eKoH8nrgcBZ6VRHQklnn9b
6lnpfRkhf7rKetSX4cmj5eQv5QyDhpgpug6BzMSf9Aw14Q/x4aVXylDAbtzxpBYY
Y3nrUbJxOey5APPvDZZmLC2CbV2VId2mfA7J8Sm6U4lldhqKt2E9JSg9dSGHf56D
tM5+mDtVij/AgoGiiAIzVeWS3EnCihXN8xgAPQAORCOETGeUaMaB7LVutFCmnRAF
CMp9NP4lxQgqjwhG2hvBUDyVTv8WTjXn3iaU6JbEMoiX5wefxDfAFSyy666OQDyl
5e2RVqkyy9W8oH5+hRjxphJhAMvU/mgBMMk7Xb0Fn1ZLTTE1iyjM8MpyVBmwoeP8
AJXyaJZ8XyOWH3gR4s+jfpUr1qssf3/DGwzCjRVvHab57vHcInMZYObtlGZoaKm9
i0tl5zb6SHZKsjEcJUgkTYA8o1gFIFS4ygUY8txazwSsBZlD7s1Z0TQIqRDtFH3r
lhQjNkoVfwSANfZ0YhNyeXvY0Rof6bjfdtC0LuBaBZYf8H7kU5bD/uAjo6/Hbji0
s5mOTUF1jlmq+mmFzOpbt3Y9xed49Hl3RHq9vhvGuen9bEKIHfKApB4oN9UpREJl
CPjnihHf7a8gwtEsgQim
=LQ/E
-----END PGP SIGNATURE-----

--5PCoGSBM4tx51xAE3xhECqVMOQaHpnVNN--
