Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 13 Nov 2012 16:30:02 +0800
References: <1352408130-22971-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1352408130-22971-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211131630.02654.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: don't add TEMP
	clients belonging to other backbone nodes
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

On Friday, November 09, 2012 04:55:29 Antonio Quartulli wrote:
> The "early client detection" mechanism must not add clients belonging
> to other backbone nodes. Such clients must be reached by directly
> using the LAN instead of the mesh.
> 
> This was introduced by 724d05c8215e4e8186097121595ef20b6ba601b7
> ("batman-adv: detect not yet announced clients")
> 
> Reported-by: Glen Page <glen.page@thet.net>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  translation-table.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied in revision 9b5c6ae.

Thanks,
Marek
