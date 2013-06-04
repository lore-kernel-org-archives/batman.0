Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 4 Jun 2013 17:06:17 +0800
References: <1370252930-3601-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1370252930-3601-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201306041706.17319.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] net: pass info struct via netdevice
	notifier
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

On Monday, June 03, 2013 17:48:50 Antonio Quartulli wrote:
> From: Jiri Pirko <jiri@resnulli.us>
> 
> So far, only net_device * could be passed along with netdevice notifier
> event. This patch provides a possibility to pass custom structure
> able to provide info that event listener needs to know.
> 
> Signed-off-by: Jiri Pirko <jiri@resnulli.us>
> 
> v2->v3: fix typo on simeth
>         shortened dev_getter
>         shortened notifier_info struct name
> v1->v2: fix notifier_call parameter in call_netdevice_notifier()
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [ordex@autistici.org: added compat code]
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  compat.h         | 6 ++++++
>  hard-interface.c | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Applied in revision 92bc8cd.

Thanks,
Marek
