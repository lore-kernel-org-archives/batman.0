Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 29 Aug 2010 02:04:11 +0200
References: <1282910025-30645-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1282910025-30645-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201008290204.11733.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't call unregister_netdev
	with locked rtnl semaphore
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

On Friday 27 August 2010 13:53:45 Sven Eckelmann wrote:
> A consistent workaround is to change store_mesh_iface and
> hardif_remove_interfaces to call rtnl_lock before they call the
> mentioned child function, release the semaphore afterwards and change
> unregister_netdev in softif_destroy to unregister_netdevice.
> 
> Reported-by: Kazuki Shimada <zukky@bb.banban.jp>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>

Applied in revision 1779.

Thanks,
Marek
