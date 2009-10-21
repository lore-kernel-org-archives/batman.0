Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 21 Oct 2009 14:00:51 +0200
References: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com>
	<45f642440910210035t5e5b8589kc676459a1470bbdb@mail.gmail.com>
	<200910211200.24602.sven.eckelmann@gmx.de>
In-Reply-To: <200910211200.24602.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1489758.SnDD3SVyPQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200910211400.55696.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] basic B.A.T.M.A.N-adv setup
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart1489758.SnDD3SVyPQ
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> I think that you found a bug in batman-adv. Please add the wlan0 interface
>  to /proc/net/batman-adv/interfaces when wlan0 is up.
Ok, problem is that the interface starts as IF_INACTIVE, then switches to=20
IF_TO_BE_ACTIVATED when you activate it with ifconfig, but never reaches=20
IF_ACTIVE.
It should get the IF_TO_BE_ACTIVATED status in hardif_activate_interface an=
d=20
the IF_ACTIVE in schedule_own_packet. I would guess that this function is=20
never called in that situation.

=46ollowing called-by tree:
=2D schedule_own_packet
  - send_outstanding_bat_packet
    - new_aggregated_packet (indirect over worker queue)
      - add_bat_packet_to_list
        - schedule_own_packet (who sees the loop here?)
        - schedule_forward_packet
  - hardif_add_interface

I would guess that either schedule_own_packet must be moved to=20
hardif_activate_interface or the worker queue must be started otherwise whe=
n=20
hardif_activate_interface is called in hard_if_event. I would leave the tha=
t=20
to Marek as he knows what side effects are problematic in that situation

Best regards,
	Sven

--nextPart1489758.SnDD3SVyPQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJK3vf0AAoJEF2HCgfBJntGRpsP/0MC4uApqVMigZmjB4AMY0z+
X4xVRuSkrjmBLdDt/nxLM3Doo4bBF/GcBe35TVfK9l7w0fZufMabcnVixKpHppXv
8frC8Rinw+gpQ5I2q5BmsnFcUoC0ua2ldE1Ytk9mJp4OC28OnQ25hWNJrrWZ4Xsq
ct/WTGmW+7d4njNZls1kIS9ftS6WbDc8huv6X4S2yZT3tIPIiOxO5DG3KVvRwKcT
g7OfPQrwsnBNwAOVdIJDj56KyoiXJY5YEzWy+rTR46eLuqTmNzKaPiR7ICBg2ouC
CKxFAGvjVk/pRHBUBJ8zYTqMFQcgF7IJKqJbAWLA8H5Xp8OjocxM6TeIJmLwPc5e
It9H2Vmv3AKhofJI5pWZ7qlU3ygp/TCgThEaFl2hDe/NFZlfzx+NYNjPLRB50X1B
e63EDj4UngPVqNag7I6JCMmibLebvJufFnwoUlPkCqsprQR5jUohG8GED11Jhyru
R8mvBjmppOMn/jrf2QY0d9s0TUD8E/uZ78qIY0GSvFwZUtSsI5IuzPJqc/wItgc/
AG4MtgkIyiKTJErMrsexU9cOKwNXm1EZuOUOuPnadSU2NDw489RsTqWUj/QwhnFW
8bg7VkziFnQKzocWzRBAN8N3YRWMOy3AJmPr+ng8UR8BRwKB/3x0wDhTXKLMXP7q
0+LVeGhWkl1SJt6eR2Nc
=lgVd
-----END PGP SIGNATURE-----

--nextPart1489758.SnDD3SVyPQ--
