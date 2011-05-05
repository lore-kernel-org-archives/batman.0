Return-Path: <andrew@lunn.ch>
Date: Thu, 5 May 2011 15:34:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110505133424.GC1528@lunn.ch>
References: <1304579589-5222-1-git-send-email-ordex@autistici.org>
	<1304579589-5222-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1304579589-5222-2-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: add wrapper function to
 throw uevent in userspace
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thu, May 05, 2011 at 09:13:07AM +0200, Antonio Quartulli wrote:
> Using throw_uevent() is now possible to trigger uevent signal that can
> be recognised in userspace. Uevents will be triggered through the
> /devices/virtual/net/{MESH_IFACE} kobject.
> 
> A triggered uevent has three properties:
> - type: the event class. Who generates the event (only 'gw' is currently
>   defined). Corresponds to the BATTYPE uevent variable.
> - action: the associated action with the event ('add'/'change'/'del' are
>   currently defined). Corresponds to the BAACTION uevent variable.
> - data: any useful data for the userspace. Corresponds to the BATDATA
>   uevent variable.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  bat_sysfs.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  bat_sysfs.h |    4 +++
>  main.h      |   11 +++++++++
>  3 files changed, 84 insertions(+), 0 deletions(-)
> 
> diff --git a/bat_sysfs.c b/bat_sysfs.c
> index 497a070..83c0980 100644
> --- a/bat_sysfs.c
> +++ b/bat_sysfs.c
> @@ -32,6 +32,16 @@
>  #define kobj_to_netdev(obj)	to_net_dev(to_dev(obj->parent))
>  #define kobj_to_batpriv(obj)	netdev_priv(kobj_to_netdev(obj))
>  
> +static char *uev_action_str[] = {
> +	"add",
> +	"del",
> +	"change"
> +};
> +
> +static char *uev_type_str[] = {
> +	"gw"
> +};
> +
>  /* Use this, if you have customized show and store functions */
>  #define BAT_ATTR(_name, _mode, _show, _store)	\
>  struct bat_attribute bat_attr_##_name = {	\
> @@ -594,3 +604,62 @@ void sysfs_del_hardif(struct kobject **hardif_obj)
>  	kobject_put(*hardif_obj);
>  	*hardif_obj = NULL;
>  }
> +
> +int throw_uevent(struct bat_priv *bat_priv, enum uev_type type,
> +		 enum uev_action action, char *data)
> +{
> +	int ret = -1;
> +	struct hard_iface *primary_if = NULL;
> +	struct kobject *bat_kobj;
> +	char *uevent_env[4] = { NULL, NULL, NULL, NULL };
> +
> +	primary_if = primary_if_get_selected(bat_priv);
> +	if (!primary_if)
> +		goto out;
> +
> +	bat_kobj = &primary_if->soft_iface->dev.kobj;
> +
> +	uevent_env[0] = kmalloc(strlen("BATTYPE=") +
> +				strlen(uev_type_str[type]) + 1,
> +				GFP_ATOMIC);
> +	if (!uevent_env[0])
> +		goto out;
> +
> +	sprintf(uevent_env[0], "BATTYPE=%s", uev_type_str[type]);

Hi Antonio

I don't particularly like having BATTYPE= twice, once in the kmalloc
and a second time in the sprintf. Maybe somebody will decide that
BATUTYPE is a better name, change the sprintf, forget about the
kmalloc, and overflow the allocated memory by one byte. snprintf will
prevent the corruption. I've made this sort of stupid error myself,
and it takes longer to debug than to write a bit more defensive code
which prevents the error.

> +
> +	uevent_env[1] = kmalloc(strlen("BATACTION=") +
> +				strlen(uev_action_str[action]) + 1,
> +				GFP_ATOMIC);
> +	if (!uevent_env[1])
> +		goto out;
> +
> +	sprintf(uevent_env[1], "BATACTION=%s", uev_action_str[action]);
> +
> +	/* If the event is DEL, ignore the data field */
> +	if (action == UEV_DEL)
> +		goto throw;

I would replace this goto with a plain if statement. 

> +
> +	uevent_env[2] = kmalloc(strlen("BATDATA=") +
> +				strlen(data) + 1, GFP_ATOMIC);
> +	if (!uevent_env[2])
> +		goto out;
> +
> +	sprintf(uevent_env[2], "BATDATA=%s", data);
> +
> +throw:
> +	ret = kobject_uevent_env(bat_kobj, KOBJ_CHANGE, uevent_env);
> +out:
> +	kfree(uevent_env[0]);
> +	kfree(uevent_env[1]);
> +	kfree(uevent_env[2]);
> +
> +	if (primary_if)
> +		hardif_free_ref(primary_if);
> +
> +	if (ret)
> +		bat_dbg(DBG_BATMAN, bat_priv, "Impossible to send "
> +			"uevent for (%s,%s,%s) event\n",
> +			uev_type_str[type], uev_action_str[action],
> +			(action == UEV_DEL ? "NULL" : data));

The value of ret could be interesting here, especially if kobject_uevent_env() failed.

> +	return ret;
> +}

  Andrew
