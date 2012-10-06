Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 7 Oct 2012 02:38:10 +0800
References: <1349078263-5834-1-git-send-email-ordex@autistici.org>
 <1349078263-5834-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1349078263-5834-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210070238.10358.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 3/9] batman-adv: Distributed ARP Table
	- create DHT helper functions
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

On Monday, October 01, 2012 15:57:37 Antonio Quartulli wrote:
> Add all the relevant functions in order to manage a Distributed Hash Table
> over the B.A.T.M.A.N.-adv network. It will later be used to store several
> ARP entries and implement DAT (Distributed ARP Table)
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  Makefile.kbuild         |   1 +
>  distributed-arp-table.c | 270
> ++++++++++++++++++++++++++++++++++++++++++++++++ distributed-arp-table.h
> |  58 +++++++++++
>  hard-interface.c        |   3 +
>  main.h                  |   6 ++
>  originator.c            |   2 +
>  types.h                 |  30 ++++++
>  unicast.c               |   8 +-
>  unicast.h               |   4 +
>  9 files changed, 378 insertions(+), 4 deletions(-)
>  create mode 100644 distributed-arp-table.c
>  create mode 100644 distributed-arp-table.h

Applied in revision 34b3c38.

Thanks,
Marek
