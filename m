Return-Path: <ordex@autistici.org>
Date: Sun, 8 May 2011 21:21:34 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110508192134.GC4631@ritirata.org>
References: <1304579589-5222-1-git-send-email-ordex@autistici.org>
	<1304579589-5222-2-git-send-email-ordex@autistici.org>
	<20110505133424.GC1528@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110505133424.GC1528@lunn.ch>
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

On gio, mag 05, 2011 at 03:34:24 +0200, Andrew Lunn wrote:
> > +	uevent_env[0] = kmalloc(strlen("BATTYPE=") +
> > +				strlen(uev_type_str[type]) + 1,
> > +				GFP_ATOMIC);
> > +	if (!uevent_env[0])
> > +		goto out;
> > +
> > +	sprintf(uevent_env[0], "BATTYPE=%s", uev_type_str[type]);
> 
> Hi Antonio
> 

Hi Andrew,

> I don't particularly like having BATTYPE= twice, once in the kmalloc
> and a second time in the sprintf. Maybe somebody will decide that
> BATUTYPE is a better name, change the sprintf, forget about the
> kmalloc, and overflow the allocated memory by one byte. snprintf will
> prevent the corruption. I've made this sort of stupid error myself,
> and it takes longer to debug than to write a bit more defensive code
> which prevents the error.

I definitely agree. I thin that using a define like
#define UEV_TYPE_VAR "BATTYPE="
would be more elegant.
In this case I can avoid to use snprintf. Do you agree on this?

> > +	/* If the event is DEL, ignore the data field */
> > +	if (action == UEV_DEL)
> > +		goto throw;
> 
> I would replace this goto with a plain if statement. 

Mh..ok. I abused of this if->goto style even if not really needed

> > +	if (ret)
> > +		bat_dbg(DBG_BATMAN, bat_priv, "Impossible to send "
> > +			"uevent for (%s,%s,%s) event\n",
> > +			uev_type_str[type], uev_action_str[action],
> > +			(action == UEV_DEL ? "NULL" : data));
> 
> The value of ret could be interesting here, especially if kobject_uevent_env() failed.

Mh, Ok. I can print it into the message. Is there a function in the kernel to
transform it in a proper string?

Thank you very much.

Regards,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
