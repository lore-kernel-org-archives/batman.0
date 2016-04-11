Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 12 Apr 2016 00:10:55 +0800
Message-ID: <1705474.RaJlENpRPT@voltaire>
In-Reply-To: <1457776173-11982-1-git-send-email-sven@narfation.org>
References: <1457776173-11982-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4637563.W0QMdVGxuD";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: add detection for complex
	bridge loops
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
Cc: Simon Wunderlich <simon.wunderlich@open-mesh.com>

--nextPart4637563.W0QMdVGxuD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 12, 2016 10:49:33 Sven Eckelmann wrote:
> From: Simon Wunderlich <simon.wunderlich@open-mesh.com>
> 
> There are network setups where the current bridge loop avoidance can't
> detect bridge loops. The minimal setup affected would consist of two
> LANs and two separate meshes, connected in a ring like that:
> 
>    A...(mesh1)...B
>    |             |
>  (LAN1)        (LAN2)
>    |             |
>    C...(mesh2)...D
> 
> Since both the meshes and backbones are separate, the bridge loop
> avoidance has not enough information to detect and avoid the loop
> in this case. Even if these scenarios can't be fixed easily,
> these kind of loops can be detected.
> 
> This patch implements a periodic check (running every 60 seconds for
> now) which sends a broadcast frame with a random MAC address on
> each backbone VLAN. If a broadcast frame with the same MAC address
> is received shortly after on the mesh, we know that there must be a
> loop and report that incident as well as throw an uevent to let others
> handle that problem.
> 
> Signed-off-by: Simon Wunderlich <simon.wunderlich@open-mesh.com>
> [sven@narfation.org: fix conflicts with current version]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - rebased patch
>  - fix checkpatch errors
>  - fix kernel-doc errors
> 
> Patch was resurrected from https://patchwork.open-mesh.org/patch/4154/
> 
> I've requested an rebased version at
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014640.html
> but done it myself because it was rather trivial.
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 139
> +++++++++++++++++++++++++++++++++
> net/batman-adv/main.h                  |   4 +
>  net/batman-adv/packet.h                |   1 +
>  net/batman-adv/sysfs.c                 |   6 +-
>  net/batman-adv/types.h                 |   8 ++
>  5 files changed, 156 insertions(+), 2 deletions(-)

Applied in revision a998bf5.

Thanks,
Marek

--nextPart4637563.W0QMdVGxuD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXC8yPAAoJEFNVTo/uthzAhJ4H/RzbV4a539upVTkRMwKoh+xL
SNkNC0zWifFWvEvmtBiGeC533g72Y1Bi5wuj6zc38onu8YlXyoT0M4GZXFMIW4M5
3OkJDrXXls1Fx5MXIdpe+g/DkzVlKoxJXjMDbH4rIiHY+zRW3HT8fpZSOVctt6ct
+GABvhuBF/a//tczB1dbdkr28J04czmG7Zik+j3YyTudO2t7NqAhM+t3bYY7eOjP
MB50SAiijZvkJg7ReQsDBhRdlvw+IyPanqGRH+5FX83ikjNE1ZiHgoKtLkcmhTNh
WTt+Jj4Z+4xgb94hKvjshZeOECckDftqndGx3vu/8lUQE3lmVVQr4UDqItqc+BU=
=a/sE
-----END PGP SIGNATURE-----

--nextPart4637563.W0QMdVGxuD--

