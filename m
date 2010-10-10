Return-Path: <andrew@lunn.ch>
Date: Sun, 10 Oct 2010 10:45:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20101010084527.GD19495@lunn.ch>
References: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
	<1286685001-15227-2-git-send-email-linus.luessing@web.de>
	<20101010043931.GA32458@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101010043931.GA32458@Sellars>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Introduce generic
 BAT_ATTR_* macros
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

On Sun, Oct 10, 2010 at 06:39:31AM +0200, Linus L??ssing wrote:
> Especially for this commit, I'm not quite sure, if the usage of
> the macros is ok and appropritate or just a too extensive use / abuse
> of them. So comments highly appreciated :).

Just my personal preference. I suggest others comment as well.
 
> > +/* Use this, if you are going to turn a [name]_enabled in bat_priv on or off */
> > +#define BAT_ATTR_SWITCH(_name, _mode, _post_func)			\

I would probably break this up into 3 macros. 
(And problem rename to BOOL instead of SWITCH.)
BAT_ATTR_STORE_SWITCH()
BAT_ATTR_SHOW_SWITCH()
BAT_ATTR_SWITCH()

where BAT_ATTR_SWITCH() just invokes the other two. 

> > +static ssize_t store_##_name(struct kobject *kobj, struct attribute *attr, \
> > +		      char *buff, size_t count)				\
> > +{									\
> > +	struct device *dev = to_dev(kobj->parent);			\
> > +	struct net_device *net_dev = to_net_dev(dev);			\
> > +	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
> > +	void (*post_func)(struct net_device *) = _post_func;		\
> > +	int ret;							\
> > +	ret = store_switch_attr(buff, count, net_dev, (char *)attr->name, \
> > +				 &bat_priv->_name##_enabled);		\
> > +	if (post_func && ret)						\
> > +		post_func(net_dev);					\
> > +	return ret;							\
> > +}									\

Maybe turn the above into an inline function and then have the macro
define a tiny wrapper function which just calls the inline function?

> > +static ssize_t show_##_name(struct kobject *kobj, struct attribute *attr, \
> > +			    char *buff)					\
> > +{									\
> > +	struct device *dev = to_dev(kobj->parent);			\
> > +	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));	\
> > +	return sprintf(buff, "%s\n",					\
> > +		       atomic_read(&bat_priv->_name##_enabled) == 0 ?	\
> > +		       "disabled" : "enabled");				\
> > +}

This is small enough that it is O.K. as a macro.

Then the same again for BAT_ATTR_UINT...

     Andrew
