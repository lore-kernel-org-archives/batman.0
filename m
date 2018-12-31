Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 31 Dec 2018 12:09:50 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20181231110950.GD4150@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-3-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207135846.6152-3-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC v3 02/19] batman-adv: Prepare framework for
 mesh genl config
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

On Fri, Dec 07, 2018 at 02:58:29PM +0100, Sven Eckelmann wrote:
> The batman-adv configuration interface was implemented solely using sysfs.
> This approach was condemned by non-batadv developers as "huge mistake".
> Instead a netlink/genl based implementation was suggested.
> 
> The main objects for this configuration is the mesh/soft-interface object.
> Its actual object in memory already contains most of the available
> configuration settings. The genl interface reflects this by allowing to
> get/set it using the mesh specific commands.
> 
> The BATADV_CMD_GET_MESH_INFO (or short version BATADV_CMD_GET_MESH) is
> reused as get command because it already provides the content of other
> information from the mesh/soft-interface which are not yet configuration
> specific.
> 
> The set command BATADV_CMD_SET_MESH will also notify interested userspace
> listeners of the "config" mcast group using the BATADV_CMD_SET_MESH command
> message type that settings might have been changed and what the current
> values are.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  include/uapi/linux/batman_adv.h |  16 +++-
>  net/batman-adv/netlink.c        | 159 +++++++++++++++++++-------------
>  2 files changed, 110 insertions(+), 65 deletions(-)
> 
> diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
> index 324a0e11..2d6a175e 100644
> --- a/include/uapi/linux/batman_adv.h
> +++ b/include/uapi/linux/batman_adv.h
> @@ -27,6 +27,7 @@
>  
>  #define BATADV_NL_NAME "batadv"
>  
> +#define BATADV_NL_MCAST_GROUP_CONFIG	"config"
>  #define BATADV_NL_MCAST_GROUP_TPMETER	"tpmeter"
>  
>  /**
> @@ -372,10 +373,14 @@ enum batadv_nl_commands {
>  	BATADV_CMD_UNSPEC,
>  
>  	/**
> -	 * @BATADV_CMD_GET_MESH_INFO: Query basic information about batman-adv
> -	 * device
> +	 * @BATADV_CMD_GET_MESH: Get attributes from softif/mesh
>  	 */
> -	BATADV_CMD_GET_MESH_INFO,
> +	BATADV_CMD_GET_MESH,
> +
> +	/**
> +	 * @BATADV_CMD_GET_MESH_INFO: Alias for @BATADV_CMD_GET_MESH
> +	 */
> +	BATADV_CMD_GET_MESH_INFO = BATADV_CMD_GET_MESH,
>  
>  	/**
>  	 * @BATADV_CMD_TP_METER: Start a tp meter session
> @@ -443,6 +448,11 @@ enum batadv_nl_commands {
>  	 */
>  	BATADV_CMD_GET_MCAST_FLAGS,
>  
> +	/**
> +	 * @BATADV_CMD_SET_MESH: Set attributes for softif/mesh
> +	 */
> +	BATADV_CMD_SET_MESH,
> +
>  	/* add new commands above here */
>  
>  	/**
> diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
> index b20801a3..d89761f8 100644
> --- a/net/batman-adv/netlink.c
> +++ b/net/batman-adv/netlink.c
> @@ -62,6 +62,7 @@ struct genl_family batadv_netlink_family;
>  
>  /* multicast groups */
>  enum batadv_netlink_multicast_groups {
> +	BATADV_NL_MCGRP_CONFIG,
>  	BATADV_NL_MCGRP_TPMETER,
>  };
>  
> @@ -78,6 +79,7 @@ enum batadv_genl_ops_flags {
>  };
>  
>  static const struct genl_multicast_group batadv_netlink_mcgrps[] = {
> +	[BATADV_NL_MCGRP_CONFIG] = { .name = BATADV_NL_MCAST_GROUP_CONFIG },
>  	[BATADV_NL_MCGRP_TPMETER] = { .name = BATADV_NL_MCAST_GROUP_TPMETER },
>  };
>  
> @@ -138,20 +140,29 @@ batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype)
>  }
>  
>  /**
> - * batadv_netlink_mesh_info_put() - fill in generic information about mesh
> - *  interface
> - * @msg: netlink message to be sent back
> - * @soft_iface: interface for which the data should be taken
> + * batadv_netlink_mesh_put() - Fill message with mesh attributes
> + * @msg: Netlink message to dump into
> + * @bat_priv: the bat priv with all the soft interface information
> + * @cmd: type of message to generate
> + * @portid: Port making netlink request
> + * @seq: sequence number for message
> + * @flags: Additional flags for message
>   *
> - * Return: 0 on success, < 0 on error
> + * Return: 0 on success or negative error number in case of failure
>   */
> -static int
> -batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
> +static int batadv_netlink_mesh_put(struct sk_buff *msg,
> +				   struct batadv_priv *bat_priv,
> +				   enum batadv_nl_commands cmd,
> +				   u32 portid, u32 seq, int flags)
>  {

[...]

>  #ifdef CONFIG_BATMAN_ADV_BLA
>  	if (nla_put_u16(msg, BATADV_ATTR_BLA_CRC,
>  			ntohs(bat_priv->bla.claim_dest.group)))
> -		goto out;
> +		goto nla_put_failure;
>  #endif
>  
>  	if (batadv_mcast_mesh_info_put(msg, bat_priv))
> -		goto out;
> +		goto nla_put_failure;

With the rename of "batadv_netlink_mesh_info_put" to
"batadv_netlink_mesh_put", I'm wondering whether
batadv_mcast_mesh_info_put() should be renamed, too.
batadv_mcast_mesh_put() would probably be a bit too generic.
But maybe something like batadv_mcast_nl_mesh_put()?


> +/**
> + * batadv_netlink_get_mesh() - Get softif attributes
> + * @skb: Netlink message with request data
> + * @info: receiver information
> + *
> + * Return: 0 on success or negative error number in case of failure
> + */
> +static int batadv_netlink_get_mesh(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct batadv_priv *bat_priv = info->user_ptr[0];
> +	struct sk_buff *msg;
> +	int ret;

Same question here for info->user_ptr[0], would a wrapper
make sense?
