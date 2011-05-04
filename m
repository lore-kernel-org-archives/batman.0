Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 4 May 2011 16:57:16 +0200
References: <1304416299-906-2-git-send-email-linus.luessing@web.de>
	<1304421006-7137-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1304421006-7137-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201105041657.17393.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Avoid deadlock between
	rtnl_lock and s_active
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

On Tuesday 03 May 2011 13:10:06 Linus L=FCssing wrote:
> From: Sven Eckelmann <sven@narfation.org>
>=20
> The hard_if_event is called by the notifier with rtnl_lock and tries to
> remove sysfs entries when a NETDEV_UNREGISTER event is received. This
> will automatically take the s_active lock.
>=20
> The s_active lock is also used when a new interface is added to a meshif
> through sysfs. In that situation we cannot wait for the rntl_lock before
> creating the actual batman-adv interface to prevent a deadlock. It is
> still possible to try to get the rtnl_lock and immediately abort the
> current operation when the trylock call failed.

Applied in b278a6c.

Thanks,
Marek
