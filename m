Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 9 Nov 2011 02:38:34 +0800
References: <1320670668-26961-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1320670668-26961-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201111090238.34584.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use unregister_netdevice()
	when softif_create fails
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

On Monday, November 07, 2011 20:57:48 Simon Wunderlich wrote:
> When entering softif_create(), the rtnl lock has already been acquired
> by store_mesh_iface().
> (store_mesh_iface() -> hardif_enable_interface() -> softif_create)
> 
> In case of an error, we should therefore call unregister_netdevice()
> instead of unregister_netdev().
> 
> unregister_netdev() tries to acquire the rtnl lock itself and deadlocks
> in this situation. unregister_netdevice() assumes that the rtnl lock
> is already been held.

Applied in revision c103efd.

Thanks,
Marek
