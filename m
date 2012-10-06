Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 7 Oct 2012 02:43:49 +0800
References: <1349078263-5834-1-git-send-email-ordex@autistici.org>
 <1349078263-5834-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1349078263-5834-7-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210070243.50305.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 6/9] batman-adv: Distributed ARP Table
	- add snooping functions for ARP messages
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

On Monday, October 01, 2012 15:57:40 Antonio Quartulli wrote:
> In case of an ARP message going in or out the soft_iface, it is intercepted
> and a special action is performed. In particular the DHT helper functions
> previously implemented are used to store all the ARP entries belonging to
> the network in order to provide a fast and unicast lookup instead of the
> classic broadcast flooding mechanism.
> Each node stores the entries it is responsible for (following the DHT
> rules) in its soft_iface ARP table. This makes it possible to reuse the
> kernel data structures and functions for ARP management.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  distributed-arp-table.c | 265
> ++++++++++++++++++++++++++++++++++++++++++++++++ distributed-arp-table.h
> |  11 ++
>  main.h                  |   2 +
>  routing.c               |  29 +++++-
>  send.c                  |   4 +
>  soft-interface.c        |  16 ++-
>  6 files changed, 325 insertions(+), 2 deletions(-)

Applied in revision 75ca71d.

Thanks,
Marek
