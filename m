Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 24 Oct 2011 14:05:51 +0200
References: <1319014945-32281-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<20111023094053.GB6828@ritirata.org>
	<4EA3E1A9.6020801@fisher-privat.net>
In-Reply-To: <4EA3E1A9.6020801@fisher-privat.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201110241405.51477.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove references for global
	tt entries
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

On Sunday, October 23, 2011 11:43:05 Alexey Fisher wrote:
> On 23.10.2011 11:40, Antonio Quartulli wrote:
> > Hello,
> > 
> > On Wed, Oct 19, 2011 at 11:02:25AM +0200, Simon Wunderlich wrote:
> >> struct tt_global_entry holds a reference to an orig_node which must be
> >> decremented before deallocating the structure.
> >> 
> >> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> >> ---
> > 
> > I got a feedback on IRC from fishor_ who applied the patch while trying
> > to eliminate the kernel panic problem on module unload. The refcount has
> > not been printed, therefore we do not know if the patch really corrects
> > it but at least we know that this patch doesn't crash batman-adv :-)
> > 
> > Cheers,
> 
> tested-by: Alexey Fisher <bug-track@fisher-privat.net>

Patch was applied in revision 5da9ad7.

Thanks,
Marek
