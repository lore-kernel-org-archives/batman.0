Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 11 Mar 2010 23:06:42 +0100
References: <1268325529-10998-1-git-send-email-linus.luessing@web.de>
	<1268342346-13713-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1268342346-13713-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart126840289.3dOrPczKSN";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201003112306.48652.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixing wrap-around bug in vis
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart126840289.3dOrPczKSN
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:
> -               if (vis_packet->seqno - old_info->packet.seqno <=3D 0) {
> +               if (vis_packet->seqno - old_info->packet.seqno
> +                   <=3D 1 << 7 * sizeof(vis_packet->seqno)) {

Shouldn't that be=20
 1 << 7 + 8 * (sizeof(vis_packet->seqno) - 1))?

Otherwise you would have left the the sizeof(vis_packet->seqno) most=20
significant bits 0 and the rest one. And maybe a seq_before/seq_after stati=
c=20
inline function could be created to make this thing a lot more readable. Yo=
u=20
could also do that in a macro if you don't want to assume the type of=20
vis_packet->seqno... which is probably what you tried by using sizeof

#define seq_before(x,y) ((x - y) >=3D 1 << 7 + 8 * (sizeof(x) - 1))
#define seq_after(x,y) ((y - x) >=3D 1 << 7 + 8 * (sizeof(x) - 1))
=2E...

And maybe you see here that the equal part which is needed bellow that line=
=20
isn't possible. So it must be changed to=20

if (!seq_after(vis_packet->seqno, old_info->packet.seqno))

I hope that this is right - please check twice.


Best regards,
	Sven

--nextPart126840289.3dOrPczKSN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLmWlyAAoJEF2HCgfBJntG3lYQAJs5YU695hmd0MPiE9vmIK4i
yzgLQxKiSWroaWk8eIfaXodx+Y/z0DZCxdSMV84MCK1eret0xDY+vfM3ATLu+eKC
E2su8WoduptVq9PAXblJq5XKpn9CPF52+ufKM4RO2UNSlc6DVKVBq123JR00wXM9
ilqRNtyJIcHZWBXrGpBtU5AsU3Eqck3IvbWJwaXu9vi8wnjFUn51Gxb8akWrXa4Z
ewqKGVRnG9oTQCTS/LPgN5cxS8bEKDwIhu7/vXhjfB+Mf9Cp4A+75bC0js/lcE74
VwrQS0JK0enZMr9tyTPtBCTxB2dlGn2uJ390kWsP2uhJiHlHIKAC3Ai9wuy4nPlS
FdgGSLvFv1EJOtBmh65X2X+8DyedSLusrOjA5nnxSGVbdVj4VWEvnB06mLOl/wMX
00dY97EpotSRxilGQ6A5umoEDeiwNW846wJZge54aIVhqsNBWgchq45ypDCgyh4D
J3UHvY0AP6AbN067xuKlLNfkc7NUwespy0iMWJh2k+2zFs/cPY4zlSyFbrL1cSnm
gGjXpNNm+MUe1A8gzXkLXxX/1J6d5wh/3oIqndfL/Vs26law52Kxcn/IRAiyUG9D
OSKAvlxLqhz0Z91PDoQf0upKkWIGX8yuyoGBDGoqxRAiO4MVQXW+F3yhSjV4IOew
pj5MxuFTerNR6IJnFrG+
=jZa5
-----END PGP SIGNATURE-----

--nextPart126840289.3dOrPczKSN--
