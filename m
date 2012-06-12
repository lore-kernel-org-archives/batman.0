Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 12 Jun 2012 19:41:16 +0800
References: <1337119580-1026-1-git-send-email-martin@hundeboll.net>
	<1339485903-8857-1-git-send-email-sven@narfation.org>
In-Reply-To: <1339485903-8857-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201206121941.17220.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Correctly check return
	value from debugfs_create_dir
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tuesday, June 12, 2012 15:25:03 Sven Eckelmann wrote:
> From: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
>=20
> The setup code in batadv_socket_setup() and debug_log_setup() wrongly
> assumes that debugfs_create_file() returns !0 on error. Since it
> actually returns a pointer on success[1], the following check should
> be inverted.
>=20
> Also, use the return value from the two setup functions in
> batadv_debugfs_add_meshif().
>=20
> [1] http://www.fsl.cs.sunysb.edu/kernel-api/re464.html
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> [sven@narfation.org: Fix conflicts with namespace patches]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  debugfs.c     |   11 +++++++----
>  icmp_socket.c |    4 ++--
>  2 files changed, 9 insertions(+), 6 deletions(-)

Applied in revision 86b9780.

Thanks,
Marek
