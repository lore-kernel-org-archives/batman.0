Return-Path: <andrew@lunn.ch>
Date: Mon, 21 Mar 2016 15:51:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160321145111.GB30210@lunn.ch>
References: <1458157872-15879-1-git-send-email-andrew@lunn.ch>
 <1458157872-15879-3-git-send-email-andrew@lunn.ch>
 <2389171.6qzBFbKr0u@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2389171.6qzBFbKr0u@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] alfred: Mount debugfs before
 reducing capabilities
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

On Fri, Mar 18, 2016 at 12:27:38PM +0100, Sven Eckelmann wrote:
> On Wednesday 16 March 2016 20:51:12 Andrew Lunn wrote:
> > --- a/batadv_query.c
> > +++ b/batadv_query.c
> > @@ -90,16 +90,9 @@ int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac)
> >  
> >  int batadv_interface_check(const char *mesh_iface)
> >  {
> > -	char *debugfs_mnt;
> >  	char full_path[MAX_PATH + 1];
> >  	FILE *f;
> >  
> > -	debugfs_mnt = debugfs_mount(NULL);
> > -	if (!debugfs_mnt) {
> > -		fprintf(stderr, "Could not find debugfs path\n");
> > -		return -1;
> > -	}
> > -
> [...]
> > diff --git a/main.c b/main.c
> > index 9610398..52dca97 100644
> > --- a/main.c
> > +++ b/main.c
> [...]
> > @@ -160,6 +161,9 @@ static struct globals *alfred_init(int argc, char *argv[])
> >  		{NULL,			0,			NULL,	0},
> >  	};
> >  
> > +	/* We need full capabilities to mount debugfs, so do that now */
> > +	debugfs_mount(NULL);
> > +
> >  	ret = reduce_capabilities();
> >  	if (ret < 0)
> >  		return NULL;
> > 
> 
> There were some return value checks for the debugfs_mount calls which you've
> removed. Why isn't here some kind of check with error handling/warning, ...?

Hi Sven

I think the other times debugfs mount was called was just before it
was used. So a mount failure means the code that follows is going to
fail.

Putting the mount very early in the program means it could be about to
do something which does not require debugfs. e.g. run in client
mode. So the most we can do a print a warning, something like: "No
access to debugfs. Some functionality may not work".

The other option is a bigger change. Move the calls to
reduce_capabilities() and debugfs_mount() to later, after the option
parsing. We then have a better idea if debugfs is needed or not, and
can then print a fatal error.

	Andrew
 
