Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 25 Mar 2013 18:19:19 +0800
References: <1364199850-24647-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1364199850-24647-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201303251819.19645.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 next] batman-adv: fix interface clean
	up on error
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

On Monday, March 25, 2013 16:24:10 Antonio Quartulli wrote:
> When enabling an hard_iface for the first time, the
> hard_iface->soft_iface member is initialised with the newly
> created soft_iface.
> However, in case of error during the activation procedure
> this member has to be set to NULL again, otherwise the
> hard_iface will result busy and will not be possible to use
> it anymore
> 
> This issue has been introduced with
> edd08535c00a42143989118bc999060893ce0a41 ("batman-adv: Allow to modify
> slaves of soft-interfaces through rntl_link")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2:
> - based on next (the commi introducing the problem is in next, not in
> maint) - added "introduced-by" in the commit message
> 
> 
>  hard-interface.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision a1eecdd.

Thanks,
Marek
