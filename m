Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 27 Jun 2009 15:39:22 +0800
References: <1246057870-1880-1-git-send-email-sven.eckelmann@gmx.de>
	<1246057870-1880-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1246057870-1880-2-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906271539.24722.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] [batman] Convert to new net_device_ops
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

On Saturday 27 June 2009 07:11:10 Sven Eckelmann wrote:
> The current version of batman-gateway uses the netdevice structure
> instead of netdevice ops introduced by v2.6.28-rc5-510-gd314774. The
> compatibility version was removed in v2.6.30-rc6-851-ge3804cb. We need
> to change now change to this new structure to be able to compile it
> against linux-2.6.31.

Thanks. I applied both.

Regards,
Marek

