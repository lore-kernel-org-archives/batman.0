Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 16:16:39 +0200
Message-ID: <2403515.P9aVkiGJpp@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8345717.vEB8GI2dtN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH v3 0/9] batctl: rtnetlink interface
	manipulation + userspace icmp
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

--nextPart8345717.vEB8GI2dtN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

I had to merge the ICMP and rtnetlink patchset [1] into one single patchset
because the two remaining ICMP patches depend on the rtnetlink query
functionality. This is already the biggest change to the patchset(s). Other
minor things are:

 * remove patchset already in master
 * rebased patchset(s) on top of current master
 * changed __unused to __maybe_unused

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-July/015941.html
[2] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-July/016046.html

Sven Eckelmann (9):
      batctl: Use rtnl to query list of softif devices
      batctl: Add command to create/destroy batman-adv interface
      batctl: Use rtnl to add/remove interfaces
      batctl: Parse interface arguments relative to last parsed option
      batctl: Allow to disable automatic interface create/destroy
      batctl: Move interface command to extra file
      batctl: Move check_mesh_iface* to functions.c
      batctl: Add helper to generate instant random bytes
      batctl: Implement non-routing batadv_icmp in userspace

 Makefile      |   2 +
 functions.c   | 248 +++++++++++++++++++++++
 functions.h   |  12 +-
 icmp_helper.c | 633 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 icmp_helper.h |  58 ++++++
 interface.c   | 457 ++++++++++++++++++++++++++++++++++++++++++
 interface.h   |  29 +++
 main.c        |   1 +
 man/batctl.8  |   7 +-
 netlink.c     | 178 ++++++++++++++++-
 netlink.h     |   3 +
 ping.c        |  42 ++--
 sys.c         | 215 +-------------------
 sys.h         |   3 -
 traceroute.c  |  42 ++--
 15 files changed, 1654 insertions(+), 276 deletions(-)


--nextPart8345717.vEB8GI2dtN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBi7HAAoJEF2HCgfBJntGh2wP/jTnOsDzwnjIn72jU/KDGrsb
/qXhn22V+ze/ZDecJ79nyxU39d76/P0gPO3gYyd4DYOiR/YZlJg0w844XTrlIv4A
cy1B6xtkTdbaGs4R/bAq5+VlqoZYZPyvL74WbFRc0lnNha63m7c30eV+puvSPgzt
O/ol+4/PMyymJnEQRBD4rHP7gEot/ohL2Racz78o7ujPicC8fopKUPRmXNPkjjDy
iWUQBz+iGVCYuJO44VFCoi4w2Eu/EbFBOddPy9bKDEMg3iN26Mtlk6dUxFtcs+kN
nORrh3v8VpyLo033LxGhWLMwUlxCX4MasbsjHIdZXaQhoYP+qd0YDCpJpayDEx3e
a3nkZ2e+uPIVazTb0nsXAOUJRBYizsR5S0qI5lJW77gOwkNxLGFVotud6hXkUPEt
87a+TITjND5JvtKCOAAzmGyxAgg9WPesd8Yoo9BgIIiMqvxkuV5fQqzyNAkNYvAW
kpHzMUdEB1PQEkKqGtqtPUnDF7+hvYwJ44kWorXgEF7zKA0iEWGJZtNNTVJfbHwo
LetcIeJQN3mpG0ZVVp+wKV2kUd/s0nS0M7kw7puVj+xA8DdHYoFtiv4d8MPZyc+U
irYsVtPB81SIkfAx/+exNOCmwRii4vfb61juBIKRXKxNF7qcM/Qd4P5h+v01SZhN
HD6GWaXa98QwwFqnID2Y
=6SWY
-----END PGP SIGNATURE-----

--nextPart8345717.vEB8GI2dtN--

