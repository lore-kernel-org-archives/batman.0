Return-Path: <andrew@lunn.ch>
Date: Sun, 8 May 2011 22:11:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110508201148.GA17431@lunn.ch>
References: <1304579589-5222-1-git-send-email-ordex@autistici.org>
	<1304579589-5222-2-git-send-email-ordex@autistici.org>
	<20110505133424.GC1528@lunn.ch>
	<20110508192134.GC4631@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110508192134.GC4631@ritirata.org>
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

> I definitely agree. I thin that using a define like
> #define UEV_TYPE_VAR "BATTYPE="
> would be more elegant.
> In this case I can avoid to use snprintf. Do you agree on this?

Yes, that is safer. 
 
> > > +	if (ret)
> > > +		bat_dbg(DBG_BATMAN, bat_priv, "Impossible to send "
> > > +			"uevent for (%s,%s,%s) event\n",
> > > +			uev_type_str[type], uev_action_str[action],
> > > +			(action == UEV_DEL ? "NULL" : data));
> > 
> > The value of ret could be interesting here, especially if kobject_uevent_env() failed.
> 
> Mh, Ok. I can print it into the message. Is there a function in the kernel to
> transform it in a proper string?

I don't think so. At least i cannot find a kstrerror(). It is messy,
since each architecture can define its own numbers for the
symbols. Most don't and use asm-generic/errno.h, but Sparc for example
has an errno.h which is compatible to SunOS.

Just print the decimal value. Anybody who is competent enough to debug
the code should be able to map a value back to a symbol.

    Andrew
