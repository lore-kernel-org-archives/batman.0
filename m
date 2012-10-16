Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Oct 2012 17:09:40 +0800
References: <1350367953-3503-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1350367953-3503-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210161709.40430.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix ifdef for DAT in types.h
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

On Tuesday, October 16, 2012 14:12:33 Antonio Quartulli wrote:
> It is better to fully enclose the batadv_priv_dat struct in the
> #ifdef/endif block instead of the enclosing only the field which would not
> compile while DAT is off.
> 
> This was introduced with ("batman-adv: Distributed ARP Table - add compile
> option")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  types.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied with minor modifications in revision e65e75c.

Thanks,
Marek
