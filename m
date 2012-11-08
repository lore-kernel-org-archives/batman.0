Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 8 Nov 2012 21:35:32 +0800
References: <1352379248-31144-1-git-send-email-ordex@autistici.org>
 <1352380871-13610-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1352380871-13610-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211082135.32360.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: correctly pass the client
	flag on tt_response
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

On Thursday, November 08, 2012 21:21:11 Antonio Quartulli wrote:
> When a TT response with the full table is sent, the client flags
> should be sent as well. This patch fix the flags assignment when
> populating the tt_response to send back
> 
> This was introduced by ("batman-adv: detect not yet announced clients")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> v2:
>  - added missing BATADV_
> v3:
>  - instead of passing the WIFI flag only, we now pass all the flags
> 
>  translation-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision d46bf9e.

Thanks,
Marek
