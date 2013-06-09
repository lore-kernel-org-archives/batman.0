Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 9 Jun 2013 22:11:47 +0800
References: <1370340711-1399-1-git-send-email-ordex@autistici.org>
 <1370340711-1399-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1370340711-1399-6-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201306092211.47639.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 05/13] batman-adv: make the Distributed
	ARP Table vlan aware
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <ordex@autistici.org>

On Tuesday, June 04, 2013 18:11:43 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> The same IP subnet can be used on different VLANs, therefore
> DAT has to differentiate whether the IP to resolve belongs
> to one or the other virtual LAN.
> To accomplish this task DAT has to deal with the VLAN tag
> and store it together with each ARP entry.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  distributed-arp-table.c | 122
> ++++++++++++++++++++++++++++++++----------------
> types.h                 |   2 +
>  2 files changed, 85 insertions(+), 39 deletions(-)

Applied in revision 3e26722.

Thanks,
Marek
