Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 7 Oct 2012 02:39:05 +0800
References: <1349078263-5834-1-git-send-email-ordex@autistici.org>
 <1349078263-5834-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1349078263-5834-5-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210070239.05435.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 4/9] batman-adv: Distributed ARP Table
	- implement local storage
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

On Monday, October 01, 2012 15:57:38 Antonio Quartulli wrote:
> Since batman-adv cannot inter-operate with the host ARP table, this patch
> introduces a batman-adv private storage for ARP entries exchanged within
> DAT. This storage will represent the node local cache in the DAT protocol.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  compat.c                |   8 ++
>  compat.h                |   1 +
>  debugfs.c               |  20 ++++
>  distributed-arp-table.c | 296
> ++++++++++++++++++++++++++++++++++++++++++++++++ distributed-arp-table.h
> |   4 +
>  main.c                  |   7 ++
>  main.h                  |   1 +
>  types.h                 |  22 ++++
>  8 files changed, 359 insertions(+)

Applied in revision f6badf9.

Thanks,
Marek
