Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 12 Jan 2013 18:53:25 +0800
References: <1357837761-30461-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1357895991-2865-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1357895991-2865-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301121853.25901.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: postpone sysfs removal
	when unregistering
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Friday, January 11, 2013 17:19:51 Simon Wunderlich wrote:
> When processing the unregister notify for a hard interface, removing
> the sysfs files may lead to a circular deadlock (rtnl mutex <->
> s_active).
> 
> To overcome this problem, postpone the sysfs removal in a worker.
> 
> Reported-by: Sasha Levin <sasha.levin@oracle.com>
> Reported-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
> Changes from PATCHv2:
>  * kerneldoc for functions
> 
> Changes from PATCHv1:
>  * INIT_WORK() in respective struct initialization functions
>  * kerneldoc
> 
> Changes from RFCv1:
>  * use work_struct properly, instead of delayed_work
>  * postpone for softifs as well as for hardifs
> 
> Postponing the sysfs removal for the hardif unregister is easier than
> other alternatives involving deferring. This should bring us to the
> same level to the bridge code, which also messes with sysfs in the
> notifier processing function, and uses rtnl_trylock when called
> from within sysfs.
> 
> As far as I could understand the net/core code, only the unregister
> case is the critical one, so the original bug should hopefully be
> fixed.
> ---
>  hard-interface.c |   24 ++++++++++++++++++++++--
>  soft-interface.c |   32 +++++++++++++++++++++++++++++---
>  types.h          |    6 ++++++
>  3 files changed, 57 insertions(+), 5 deletions(-)

Applied in revision a33c882.

Thanks,
Marek
