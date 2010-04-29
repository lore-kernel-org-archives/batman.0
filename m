Return-Path: <andrew@lunn.ch>
Date: Thu, 29 Apr 2010 18:34:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100429163429.GF3734@lunn.ch>
References: <201004291621.08579.sven.eckelmann@gmx.de>
	<1272550944-8522-2-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1272550944-8522-2-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint 2/2] batman-adv: Reduce max
 characters on a line to 80
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

On Thu, Apr 29, 2010 at 04:22:24PM +0200, Sven Eckelmann wrote:
> Documentation/CodingStyle sets a strongly prefered limit of 80
> characters per line in "Chapter 2: Breaking long lines and strings".
> 
> Strings must be broken into smaller parts and long statements must be
> rewritten.

Hi Sven

This rules seems to be in dispute. I've seen comments that this should
not be done since it can prevent a grep -r from finding the string
when it is split over multiple lines.

But as you said, we repeatedly get patches from people trying to
remove these checkpatch warnings.....

So we need a compromise. Overall i like what you have done.

> -		printk(KERN_ERR "batman-adv:Registering the character device failed with %d\n",
> +		printk(KERN_ERR "batman-adv:"
> +		       "Registering the character device failed with %d\n",
>  			  tmp_major);

I like that you have consistently broken the text after
"batman-adv:". Hopefully people will grep without the prefix because
generally it has very little value.

> -		printk(KERN_WARNING "batman-adv:The newly added mac address (%pM) already exists on: %s\n",
> -		       addr, batman_if->dev);
> -		printk(KERN_WARNING "batman-adv:It is strongly recommended to keep mac addresses unique to avoid problems!\n");
> +		printk(KERN_WARNING "batman-adv:"
> +		    "The newly added mac address (%pM) already exists on: %s\n",
> +		    addr, batman_if->dev);
> +		printk(KERN_WARNING "batman-adv:"
> +		    "It is strongly recommended to keep mac addresses unique"
> +		    "to avoid problems!\n");

Thinking about the grep use case, i like that you have split after a
variable, which grep will not match on. 

> -		printk(KERN_ERR "batman-adv:Not using interface %s (retrying later): interface not active\n", batman_if->dev);
> +		printk(KERN_ERR "batman-adv:"
> +		       "Not using interface %s (retrying later): "
> +		       "interface not active\n", batman_if->dev);

Here i would of probably broken the line after %s to keep the rest together.

> @@ -281,8 +287,9 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
>  	if (!bat_priv->primary_if) {
>  		if (off == 0)
>  			return sprintf(buff,
> -				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
> -				       net_dev->name);
> +				     "BATMAN mesh %s disabled - "
> +				     "please specify interfaces to enable it\n",
> +				     net_dev->name);
>  
>  		return 0;
>  	}

How about combining to two if's into one, so reducing the indentation,
and break the line after %s?

> @@ -290,7 +297,8 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
>  	if (bat_priv->primary_if->if_status != IF_ACTIVE) {
>  		if (off == 0)
>  			return sprintf(buff,
> -				       "BATMAN mesh %s disabled - primary interface not active\n",
> +				       "BATMAN mesh %s disabled - "
> +				       "primary interface not active\n",
>  				       net_dev->name);
>  
>  		return 0;

Same again.

> @@ -458,13 +469,16 @@ void receive_bat_packet(struct ethhdr *ethhdr,
>  
>  	if (is_my_addr) {
>  		bat_dbg(DBG_BATMAN,
> -			"Drop packet: received my own broadcast (sender: %pM)\n",
> +			"Drop packet: received my own broadcast "
> +			"(sender: %pM)\n",

I know it probably looks a little odd, but maybe break before %pM so
the constant text is whole?

>  	if (is_broadcast) {
> -		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all packets with broadcast source addr (sender: %pM)\n", ethhdr->h_source);
> +		bat_dbg(DBG_BATMAN, "Drop packet: "
> +		"ignoring all packets with broadcast source addr "
> +		"(sender: %pM)\n", ethhdr->h_source);

Same again?

>  	if (is_my_oldorig) {
> -		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast echos (sender: %pM)\n", ethhdr->h_source);
> +		bat_dbg(DBG_BATMAN,
> +			"Drop packet: ignoring all rebroadcast echos "
> +			"(sender: %pM)\n", ethhdr->h_source);

Same again...

>  		return;
>  	}


>  
> @@ -508,12 +525,15 @@ void receive_bat_packet(struct ethhdr *ethhdr,
>  	is_duplicate = count_real_packets(ethhdr, batman_packet, if_incoming);
>  
>  	if (is_duplicate == -1) {
> -		bat_dbg(DBG_BATMAN, "Drop packet: packet within seqno protection time (sender: %pM)\n", ethhdr->h_source);
> +		bat_dbg(DBG_BATMAN,
> +			"Drop packet: packet within seqno protection time "
> +			"(sender: %pM)\n", ethhdr->h_source);

Probably does not fit this time :-(

> diff --git a/send.c b/send.c
> index caec6ef..7f3031d 100644
> --- a/send.c
> +++ b/send.c
> @@ -67,7 +67,8 @@ int send_skb_packet(struct sk_buff *skb,
>  
>  	if (!(batman_if->net_dev->flags & IFF_UP)) {
>  		printk(KERN_WARNING
> -		       "batman-adv:Interface %s is not up - can't send packet via that interface!\n",
> +		       "batman-adv:Interface %s is not up - "
> +		       "can't send packet via that interface!\n",

Maybe break after the %s?

>  	if (!bat_priv->primary_if) {
>  		if (off == 0)
>  			return sprintf(buff,
> -				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
> -				       net_dev->name);
> +				     "BATMAN mesh %s disabled - "
> +				     "please specify interfaces to enable it\n",
> +				     net_dev->name);
>  
>  		return 0;

Combine the two ifs and break on the %s?

> +/**
> +  *	orig_node - structure for orig_list maintaining nodes of mesh
> +  *	@last_valid: when last packet from this node was received
> +  *	@bcast_seqno_reset: time when the broadcast seqno window was reset
> +  *	@batman_seqno_reset: time when the batman seqno window was reset
> +  *	@flags: for now only VIS_SERVER flag
> +  *	@last_real_seqno: last and best known squence number
> +  *	@last_ttl: ttl of last received packet
> +  *	@last_bcast_seqno: last broadcast sequence number received by this host
> + */
> +struct orig_node {

Nice :-)

Overall, good patch.

	 Andrew
