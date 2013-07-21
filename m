Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 21 Jul 2013 19:10:39 +0800
References: <1373666760-3552-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1373666760-3552-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201307211910.40087.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: send GW_DEL event when the
	gw client mode is deselected
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

On Saturday, July 13, 2013 06:06:00 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Whenever the GW client mode is deselected, a DEL event has
> to be sent in order to tell userspace that the current
> gateway has been lost. Send the uevent on state change only
> if a gateway was currently selected.
> 
> Reported-by: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
> 
> v2:
> - fixed typo
> - fixed kernel doc
> - fixed comment in sysfs.c
> 
> 
>  gateway_client.c | 27 +++++++++++++++++++++++++++
>  gateway_client.h |  1 +
>  sysfs.c          |  4 ++++
>  3 files changed, 32 insertions(+)

Applied in revision 2bde624.

Thanks,
Marek
