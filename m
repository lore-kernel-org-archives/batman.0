Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 25 Aug 2013 14:53:24 +0800
References: <1377156073-556-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1377156073-556-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308251453.25054.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: print the VID in the
	dat_cache output
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

On Thursday, August 22, 2013 15:21:11 Antonio Quartulli wrote:
> Now that DAT is vlan aware, it should also print the VID
> along with the MAC address of each cached entry.
> 
> Introduced by: 3e26722bc9f248ec4316749fc1957365c0fa5e4b
> ("batman-adv: make the Distributed ARP Table vlan aware")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  distributed-arp-table.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied in revision 19c31e8.

Thanks,
Marek
