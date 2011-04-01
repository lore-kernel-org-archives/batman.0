Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 1 Apr 2011 21:59:27 +0200
References: <1301640559-4152-1-git-send-email-sven@narfation.org>
	<1301640559-4152-2-git-send-email-sven@narfation.org>
In-Reply-To: <1301640559-4152-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201104012159.27730.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix imbalanced locking
	in gw_node_update
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

On Friday 01 April 2011 08:49:19 Sven Eckelmann wrote:
> 8ffdea813e32cee3c60be36fb9e6a5e077e51ea0 used rcu_read_unlock without
> using rcu_read_lock when gw_get_selected_gw_node didn't return a valid
> gw_node.

Applied a slightly modified variant in revision g76eab02.

Thanks,
Marek

PS: I prefer the goto patch over the return statement. :-)
