Return-Path: <andrew@lunn.ch>
Date: Tue, 3 May 2016 14:20:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160503122046.GK16990@lunn.ch>
References: <1462222618-29761-1-git-send-email-andrew@lunn.ch>
 <3295917.zMxpBmcd5T@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3295917.zMxpBmcd5T@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: Use netlink to replace some of
 debugfs
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc, mareklindner@neomailbox.ch

On Tue, May 03, 2016 at 09:07:35AM +0200, Sven Eckelmann wrote:
> [...]
> > +ifeq ($(origin LIBNL_GENL_CFLAGS) $(origin LIBNL_GENL_LDLIBS), undefined undefined)
> > +  LIBNL_GENL_NAME ?= libnl-genl-3.0
> > +  ifeq ($(shell $(PKG_CONFIG) --modversion $(LIBNL_GENL_NAME) 2>/dev/null),)
> > +    $(error No $(LIBNL_GENL_NAME) development libraries found!)
> > +  endif
> > +  LIBNL_GENL_CFLAGS += $(shell $(PKG_CONFIG) --cflags $(LIBNL_GENL_NAME))
> > +  LIBNL_GENL_LDLIBS += $(shell $(PKG_CONFIG) --libs $(LIBNL_GENL_NAME))
> > +endif
> > +CFLAGS += $(LIBNL_GENL_CFLAGS)
> > +LDLIBS += $(LIBNL_GENL_LDLIBS)
> 
> @Simon, @Matthias, @Antonio, @Marek: Should the header file be included in
> batctl like nl80211.h in iw. Or should we always require the current kernel
> header files installed to build batctl?

Once the code is mostly complete and stable, i think a local copy
would be good. It does seems to be the common way.

While doing development work, it saved me copying the header file
around for each change.

I can make this change in the next version.

> [...]
> > +struct mandatory_attr {
> > +	int attr;
> > +	int datalen;
> > +};
> > +
> > +static int last_err;
> > +
> > +static int invalidate_mandatory_attrs(struct nlattr *attrs[],
> > +				      const struct mandatory_attr *mandatory[],
> > +				      int num)
> > +{
> > +	int i;
> > +	int len;
> > +
> > +	for (i = 0; i < num; i++) {
> > +		if (!attrs[mandatory[i]->attr])
> > +			return EINVAL;
> > +		len = nla_len(attrs[mandatory[i]->attr]);
> > +		if (mandatory[i]->datalen && (len != mandatory[i]->datalen))
> > +			return EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct mandatory_attr mandatory_attr_version= {
> > +	BATADV_ATTR_VERSION, 0 };
> [...]
> > +static const struct mandatory_attr *info_hard_mandatory[] = {
> > +	&mandatory_attr_version,
> > +	&mandatory_attr_algo_name,
> > +	&mandatory_attr_hard_ifname,
> > +	&mandatory_attr_hard_address,
> > +};
> > +
> > +static int info_callback(struct nl_msg *msg, void *arg __unused)
> > +{
> [...]
> > +	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
> > +		      genlmsg_len(ghdr), NULL)) {
> > +		fputs("Received invalid data from kernel.", stderr);
> > +		exit(1);
> > +	}
> > +
> > +	if (invalidate_mandatory_attrs(attrs, info_mandatory,
> > +				       ARRAY_SIZE(info_mandatory))) {
> > +		fputs("Missing/invalid attributes from kernel\n", stderr);
> > +		exit(1);
> > +	}
> 
> Interesting idea to check the mandatory attributes with a common function. But
> shouldn't be the length checked by the nl_parse(..., policy) [1]? This is
> especially important because you don't check the type.

I could be missing something, but i don't see how to check the type,
i.e. string, u8, u16, etc. The header file is defining attribute
types:

enum {
        BATADV_ATTR_UNSPEC,
        BATADV_ATTR_VERSION,
        BATADV_ATTR_ALGO_NAME,
        BATADV_ATTR_MESH_IFINDEX,

There does not seem to be a way to say that BATADV_ATTR_VERSION is
also an NLA_STRING.

However, yes, i should do the length checking as part of nl_parse.

	 Andrew
