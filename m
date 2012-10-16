Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Oct 2012 17:13:41 +0800
References: <1350368170-9571-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1350368170-9571-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210161713.41361.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix kernel-doc for
	batadv_dat_entry
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

On Tuesday, October 16, 2012 14:16:10 Antonio Quartulli wrote:
> In the batadv_dat_entry structure last_update was lonely and was missing
> its own kernel-doc. This patch adds it.
> 
> This was introduced with ("batman-adv: Distributed ARP Table - implement
> local storage")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  types.h | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision 516b20d.

Thanks,
Marek
