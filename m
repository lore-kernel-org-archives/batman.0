Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 13 Nov 2012 18:33:58 +0800
References: <1352409376-28885-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1352409376-28885-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211131833.58596.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: reduce local TT entry
	timeout to 10 minutes
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

On Friday, November 09, 2012 05:16:15 Antonio Quartulli wrote:
> The current timeout is set to one hour. However a client connected to the
> mesh network will always generate traffic. In the worst case it will send
> ARP requests every 4 or 5 minutes. On the other hand having a long timeout
> means storing dead entries for one hour leads to very big trans-tables
> containing useless clients.
> 
> This patch reduces the timeout to 10 minutes
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  main.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 736dcf6.

Thanks,
Marek
