Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 4 May 2011 16:50:18 +0200
References: <1304363978-16164-1-git-send-email-sven@narfation.org>
	<1304416299-906-1-git-send-email-linus.luessing@web.de>
	<1304416299-906-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1304416299-906-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201105041650.19337.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Remove unnecessary
	hardif_list_lock
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

On Tuesday 03 May 2011 11:51:38 Linus L=C3=BCssing wrote:
> hardif_list_lock is unneccessary because we already ensure that no
> multiple admin operations can take place through rtnl_lock.
> hardif_list_lock only adds additional overhead and complexity.
>=20
> Critical functions now check whether they are called with rtnl_lock
> using ASSERT_RTNL.
>=20
> It indirectly fixes the problem that orig_hash_del_if() expects that
> only one interface is deleted from hardif_list at a time, but
> hardif_remove_interfaces() removes all at once and then calls
> orig_hash_del_if().

Applied in revision 7e95055.

Thanks,
Marek
