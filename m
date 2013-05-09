Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 9 May 2013 17:31:33 +0800
References: <1367881578-3353-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1367881578-3353-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305091731.33754.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: reorder clean up
	routine in order to avoid race conditions
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
Cc: Antonio Quartulli <ordex@autistici.org>

On Tuesday, May 07, 2013 07:06:18 Antonio Quartulli wrote:
> nc_worker accesses the originator table during its periodic
> work, but since the originator table is freed before
> stopping the worker this leads to a global protection fault.
> 
> Fix this by killing the worker (in nc_free) before freeing
> the originator table.
> 
> Moreover tidy up the entire clean up routine by running all
> the subcomponents freeing procedures first and then killing
> the TT and the originator tables at the end.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2:
> - based on top of maint
> - commit message reworded
> 
>  main.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Applied in revision 763f413.

Thanks,
Marek
