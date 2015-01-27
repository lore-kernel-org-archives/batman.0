Return-Path: <gmazzurco89@gmail.com>
Sender: Gioacchino Mazzurco <gmazzurco89@gmail.com>
From: Gioacchino Mazzurco <gio@eigenlab.org>
Date: Tue, 27 Jan 2015 11:48:09 +0100
Message-ID: <2512638.rHeWM5fpXe@giomium>
In-Reply-To: <b4fac27152a34dd39d59ca0b83de0157a8f7805f.1422326992.git.mschiffer@universe-factory.net>
References: <b4fac27152a34dd39d59ca0b83de0157a8f7805f.1422326992.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [OpenWrt-Devel] [PATCH netifd] bridge: allow
	enabling or disabling the multicast querier independently of
	IGMP snooping
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
To: "'b.a.t.m.a.n@lists.open-mesh.org'" <b.a.t.m.a.n@lists.open-mesh.org>

Reading this mail seems that who installa batman-adv nodes should do this 
setting manually, doesn't batman-adv know/(can estimate) who is the goode node 
were to put the querier?

What happen if we have the querier on every node?

Thanks!

On Tuesday, January 27, 2015 03:49:52 AM Matthias Schiffer wrote:
> In larger networks, especially big batman-adv meshes, it may be desirable to
> enable IGMP snooping on every bridge without enabling the multicast querier
> to specifically put the querier on a well-connected node.
> 
> This patch adds a new UCI option 'multicast_querier' for bridges which
> allows this. The default is still the value of the 'igmp_snooping' option
> to maintain backwards compatiblity.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  bridge.c       | 8 +++++++-
>  system-linux.c | 2 +-
>  system.h       | 1 +
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/bridge.c b/bridge.c
> index f8478ad..f7dbf61 100644
> --- a/bridge.c
> +++ b/bridge.c
> @@ -32,6 +32,7 @@ enum {
>  	BRIDGE_ATTR_HELLO_TIME,
>  	BRIDGE_ATTR_MAX_AGE,
>  	BRIDGE_ATTR_BRIDGE_EMPTY,
> +	BRIDGE_ATTR_MULTICAST_QUERIER,
>  	__BRIDGE_ATTR_MAX
>  };
> 
> @@ -45,6 +46,7 @@ static const struct blobmsg_policy
> bridge_attrs[__BRIDGE_ATTR_MAX] = { [BRIDGE_ATTR_MAX_AGE] = { "max_age",
> BLOBMSG_TYPE_INT32 },
>  	[BRIDGE_ATTR_IGMP_SNOOP] = { "igmp_snooping", BLOBMSG_TYPE_BOOL },
>  	[BRIDGE_ATTR_BRIDGE_EMPTY] = { "bridge_empty", BLOBMSG_TYPE_BOOL },
> +	[BRIDGE_ATTR_MULTICAST_QUERIER] = { "multicast_querier", BLOBMSG_TYPE_BOOL
> }, };
> 
>  static const struct uci_blob_param_info bridge_attr_info[__BRIDGE_ATTR_MAX]
> = { @@ -547,6 +549,7 @@ bridge_apply_settings(struct bridge_state *bst,
> struct blob_attr **tb) cfg->stp = false;
>  	cfg->forward_delay = 2;
>  	cfg->igmp_snoop = true;
> +	cfg->multicast_querier = true;
>  	cfg->bridge_empty = false;
>  	cfg->priority = 0x7FFF;
> 
> @@ -560,7 +563,10 @@ bridge_apply_settings(struct bridge_state *bst, struct
> blob_attr **tb) cfg->priority = blobmsg_get_u32(cur);
> 
>  	if ((cur = tb[BRIDGE_ATTR_IGMP_SNOOP]))
> -		cfg->igmp_snoop = blobmsg_get_bool(cur);
> +		cfg->multicast_querier = cfg->igmp_snoop = blobmsg_get_bool(cur);
> +
> +	if ((cur = tb[BRIDGE_ATTR_MULTICAST_QUERIER]))
> +		cfg->multicast_querier = blobmsg_get_bool(cur);
> 
>  	if ((cur = tb[BRIDGE_ATTR_AGEING_TIME])) {
>  		cfg->ageing_time = blobmsg_get_u32(cur);
> diff --git a/system-linux.c b/system-linux.c
> index 4737fa6..ef90880 100644
> --- a/system-linux.c
> +++ b/system-linux.c
> @@ -772,7 +772,7 @@ int system_bridge_addbr(struct device *bridge, struct
> bridge_config *cfg) bridge->ifname, cfg->igmp_snoop ? "1" : "0");
> 
>  	
system_set_dev_sysctl("/sys/devices/virtual/net/%s/bridge/multicast_querie
> r", -		bridge->ifname, cfg->igmp_snoop ? "1" : "0");
> +		bridge->ifname, cfg->multicast_querier ? "1" : "0");
> 
>  	args[0] = BRCTL_SET_BRIDGE_PRIORITY;
>  	args[1] = cfg->priority;
> diff --git a/system.h b/system.h
> index 9a2326b..94e0dd9 100644
> --- a/system.h
> +++ b/system.h
> @@ -50,6 +50,7 @@ struct bridge_config {
>  	enum bridge_opt flags;
>  	bool stp;
>  	bool igmp_snoop;
> +	bool multicast_querier;
>  	unsigned short priority;
>  	int forward_delay;
>  	bool bridge_empty;

