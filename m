Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 24 Oct 2011 14:12:01 +0200
References: <1319237739-7686-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1319237739-7686-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201110241412.02159.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: unify hash_entry field
	position in tt_local/global_entry
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

On Saturday, October 22, 2011 00:55:39 Antonio Quartulli wrote:
> Function tt_response_fill_table() actually uses a tt_local_entry pointer to
> iterate either over the local or the global table entries (it depends on
> the what hash table is passed as argument). To iterate over such entries
> the hlist_for_each_entry_rcu() macro has to access their "hash_entry"
> field which MUST be at the same position in both the tt_global/local_entry
> structures.

Patch was applied in revision 474f917.

Thanks,
Marek

PS: Antonio, please keep in mind that I apply this patch as a temporary 
measure not as the final fix.
