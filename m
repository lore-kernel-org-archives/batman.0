Return-Path: <andrew@lunn.ch>
Date: Tue, 3 May 2016 15:08:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160503130857.GC16952@lunn.ch>
References: <1462222618-29761-1-git-send-email-andrew@lunn.ch>
 <1679465.5nkEMONaEr@bentobox> <20160503124719.GB16952@lunn.ch>
 <3986955.uBauJeRErD@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3986955.uBauJeRErD@bentobox>
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Tue, May 03, 2016 at 02:54:26PM +0200, Sven Eckelmann wrote:
> On Tuesday 03 May 2016 14:47:19 Andrew Lunn wrote:
> > On Tue, May 03, 2016 at 02:26:34PM +0200, Sven Eckelmann wrote:
> > > On Tuesday 03 May 2016 14:20:46 Andrew Lunn wrote:
> > > [...]
> > > > There does not seem to be a way to say that BATADV_ATTR_VERSION is
> > > > also an NLA_STRING.
> > > 
> > > Please check "policy" in the link I gave you.
> > 
> > I did. And i still don't get how you can check the type.
> > 
> >   Andrew
> 
>    struct nla_policy {
>             uint16_t        type;
>             uint16_t        minlen;
>             uint16_t        maxlen;
>    };
> 
> there is an entry for type, minlen and maxlen. The type member is to check for
> the type. Here is an example how to check the type from batctl:
> 
>     static struct nla_policy info_data_link_policy[IFLA_MAX + 1] = {
>     	[IFLA_LINKINFO]	= { .type = NLA_NESTED },
> 	    [IFLA_LINK]	= { .type = NLA_U32 },
>     };
>     [...]
>     	ret = nlmsg_parse(n, sizeof(struct ifinfomsg), tb, IFLA_MAX,
>     			  info_data_link_policy);

Ah. Now i get it.

The problem is the overloaded 'type'. An attribute in a message has a
header which includes a type. It takes the value
e.g. BATADV_ATTR_VERSION. In nla_policy, we again have type, but this
time it takes e.g. NLA_U32.

Once you figure out type != type, it all becomes clear...

     Andrew

