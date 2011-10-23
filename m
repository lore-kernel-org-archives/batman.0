Return-Path: <ordex@autistici.org>
Date: Sun, 23 Oct 2011 11:40:54 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111023094053.GB6828@ritirata.org>
References: <1319014945-32281-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1319014945-32281-1-git-send-email-siwu@hrz.tu-chemnitz.de>
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Hello,

On Wed, Oct 19, 2011 at 11:02:25AM +0200, Simon Wunderlich wrote:
> struct tt_global_entry holds a reference to an orig_node which must be
> decremented before deallocating the structure.
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---

I got a feedback on IRC from fishor_ who applied the patch while trying to
eliminate the kernel panic problem on module unload. The refcount has not been
printed, therefore we do not know if the patch really corrects it but at least
we know that this patch doesn't crash batman-adv :-)

Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
