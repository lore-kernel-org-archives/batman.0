Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 25 Aug 2013 14:56:45 +0800
References: <1377156073-556-1-git-send-email-ordex@autistici.org>
 <1377156073-556-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1377156073-556-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308251456.46332.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: fix ARP header parsing
	in DAT
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Antonio Quartulli <ordex@autistici.org>

On Thursday, August 22, 2013 15:21:12 Antonio Quartulli wrote:
> In case of VLAN packets flowing into the DAT module, the
> parsing routines have to consider the correct header size
> when accessing an ARP packet.
> 
> Introduced by: 3e26722bc9f248ec4316749fc1957365c0fa5e4b
> ("batman-adv: make the Distributed ARP Table vlan aware")
> 
> Reported-by: Marco Dalla Torre <marco.dallato@gmail.com>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> Tested-by: Marco Dalla Torre <marco.dallato@gmail.com>
> ---
>  distributed-arp-table.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Applied in revision ae6b6b3.

Thanks,
Marek
