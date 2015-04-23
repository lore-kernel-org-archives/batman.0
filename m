Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 23 Apr 2015 08:49:13 +0200
Message-ID: <1993182.YpbjlS2XkF@bentobox>
In-Reply-To: <1429729962-5365-1-git-send-email-sven@narfation.org>
References: <1429729962-5365-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next] batman-adv: Remove unused compat
	function batadv_free_rcu_softif_vlan
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

On Wednesday 22 April 2015 21:12:42 Sven Eckelmann wrote:
> The commit e78c16c0550c ("batman-adv: Revert "fix var name to keep
> compatibility with old kernels"") should have renamed the function to
> batadv_free_rcu_softif_vlan instead of adding a new function
> batadv_free_rcu_vlan because it was only used in this single place.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This patch is complete optional and would only silence a build_test warning
> until the master branch becomes the next branch. But this would create a
> merge conflict because batadv_free_rcu_softif_vlan is already removed in
> master.

Just as hint: If only this patch is new in next and you want to merge then you 
could merge by ignoring the changes in next to avoid the merge conflict:

 git merge -s ours next

Kind regards,
	Sven
