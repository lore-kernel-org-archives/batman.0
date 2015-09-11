Return-Path: <ynezz@mengele.ibawizard.net>
Date: Fri, 11 Sep 2015 17:19:56 +0200
From: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Message-ID: <20150911151956.GF19674@ibawizard.net>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
References: <1441980723-3805-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1441980723-3805-1-git-send-email-sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: lock crc access
	in	bridge loop avoidance
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

Simon Wunderlich <sw@simonwunderlich.de> [2015-09-11 16:12:03]:

> @@ -1669,11 +1685,15 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
>  		hlist_for_each_entry_rcu(claim, head, hash_entry) {
>  			is_own = batadv_compare_eth(claim->backbone_gw->orig,
>  						    primary_addr);
> +
> +			spin_lock_bh(&claim->backbone_gw->crc_lock);
> +			backbone_crc = claim->backbone_gw->crc;
> +			spin_lock_bh(&claim->backbone_gw->crc_lock);

shouldn't this be spin_unlock_bh?

-- ynezz
