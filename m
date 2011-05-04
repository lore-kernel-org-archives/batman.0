Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 4 May 2011 16:39:18 +0200
References: <1304497532-16946-1-git-send-email-sven@narfation.org>
In-Reply-To: <1304497532-16946-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105041639.19293.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: cosmetic: Use ethtool
	ethtool_cmd_speed API
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

On Wednesday 04 May 2011 10:25:32 Sven Eckelmann wrote:
> From: David Decotigny <decot@google.com>
> 
> This updates the network drivers so that they don't access the
> ethtool_cmd::speed field directly, but use ethtool_cmd_speed()
> instead.
> 
> For most of the drivers, these changes are purely cosmetic and don't
> fix any problem, such as for those 1GbE/10GbE drivers that indirectly
> call their own ethtool get_settings()/mii_ethtool_gset(). The changes
> are meant to enforce code consistency and provide robustness with
> future larger throughputs, at the expense of a few CPU cycles for each
> ethtool operation.

Applied in revision a2a2603.

Thanks,
Marek
