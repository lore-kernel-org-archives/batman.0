Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 7 Oct 2012 02:40:15 +0800
References: <1349078263-5834-1-git-send-email-ordex@autistici.org>
 <1349078263-5834-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1349078263-5834-6-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210070240.15433.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 5/9] batman-adv: Distributed ARP Table
	- add ARP parsing functions
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

On Monday, October 01, 2012 15:57:39 Antonio Quartulli wrote:
> ARP messages are now parsed to make it possible to trigger special actions
> depending on their types (snooping).
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  distributed-arp-table.c | 202
> ++++++++++++++++++++++++++++++++++++++++++++++++ distributed-arp-table.h
> |   2 +
>  packet.h                |   8 +-
>  3 files changed, 211 insertions(+), 1 deletion(-)

Applied in revision 359c95b.

Thanks,
Marek
