Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 18 Sep 2010 16:42:07 +0200
References: <1284738065-8715-10-git-send-email-sven.eckelmann@gmx.de>
	<1284744426-12239-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284744426-12239-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201009181642.08297.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 9/9] batman-adv: count batman_if list
	queries as reference
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

On Friday 17 September 2010 19:27:06 Sven Eckelmann wrote:
> The return of get_batman_if_by_netdev and get_active_batman_if leaks a
> pointer from the rcu protected list of interfaces. We must protect it to
> prevent a too early release of the memory. Those functions must increase
> the reference counter before rcu_read_unlock or it may be to late to
> prevent a free.

It seems this patch does not properly deal with bat_priv->primary_if. Please 
review my revised patch and let me know if you think it is ok.

Cheers,
Marek
