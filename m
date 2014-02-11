Return-Path: <andrew@lunn.ch>
Date: Tue, 11 Feb 2014 17:59:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140211165923.GD24633@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-7-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392122903-805-7-git-send-email-antonio@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 06/23] batman-adv: ELP - adding sysfs
 parameter for elp interval
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <antonio@open-mesh.com>

On Tue, Feb 11, 2014 at 01:48:06PM +0100, Antonio Quartulli wrote:
> From: Linus Luessing <linus.luessing@web.de>
> 
> This parameter can be set individually on each interface and
> allows the configuration of the ndp interval for the link

s/ndp/elp

> quality measurements during runtime. Usually it is desirable
> to set it to a higher (= slower) value on interfaces which
> have a more static characteristic (e.g. wired interfaces)
> or very dense neighbourhoods to reduce overhead.
> 
> Developed by Linus during a 6 months trainee study period in
> Ascom (Switzerland) AG.
> 
> Signed-off-by: Linus Luessing <linus.luessing@web.de>
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> [antonio@open-mesh.com: respin on top of the latest master]
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  sysfs-class-net-batman-adv | 8 +++++++-
>  sysfs.c                    | 7 +++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/sysfs-class-net-batman-adv b/sysfs-class-net-batman-adv
> index 7f34a95..2884c98 100644
> --- a/sysfs-class-net-batman-adv
> +++ b/sysfs-class-net-batman-adv
> @@ -1,4 +1,11 @@
>  
> +What:           /sys/class/net/<mesh_iface>/batman-adv/elp_interval
> +Date:           Mar 2012

Might make sense to update this to 2014?

      Andrew
