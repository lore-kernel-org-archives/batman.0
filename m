Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 9 May 2013 15:57:53 +0800
References: <1368084945-2531-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1368084945-2531-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305091557.53587.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: make DAT drop ARP
	requests targeting local clients
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

On Thursday, May 09, 2013 15:35:45 Antonio Quartulli wrote:
> In the outgoing ARP request snooping routine in DAT, ARP
> Request sent by local clients which are supposed to be
> replied by other local clients can be silently dropped.
> 
> The destination host will reply by itself through the LAN
> and therefore there is no need to involve DAT.
> 
> Reported-by: Carlos Quijano <carlos@crqgestion.es>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> Tested-by: Carlos Quijano <carlos@crqgestion.es>
> ---
>  distributed-arp-table.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied in revision d6bd8b3.

Thanks,
Marek
