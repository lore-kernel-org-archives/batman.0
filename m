Return-Path: <linus.luessing@web.de>
Date: Thu, 1 Jul 2010 00:42:43 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100630224243.GA22928@Sellars>
References: <1277920995-25503-1-git-send-email-linus.luessing@web.de>
	<201006302135.50499.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201006302135.50499.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Add timeout filtering option for
 originators
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

On Wed, Jun 30, 2010 at 09:35:49PM +0200, Marek Lindner wrote:
> On Wednesday 30 June 2010 20:03:13 Linus Lüssing wrote:
> > +	char msecs_buff[4];
> > +	memset(msecs_buff, '0', sizeof(msecs_buff));
> > +	msecs_buff[3] = '\0';
>
> Shouldn't a simple 
> memset(msecs_buff, 0, sizeof(msecs_buff));
> be enough ?
The intention of the msecs_buff was, to do some zeroed alignment
which is not possible with sscanf automatically (so without it, a
-t 0.99 were converted to 99ms instead of 990).
The last one is is for just marking the end of the string (note,
'0' != '\0' ;) ).
> 
> 
> 
> > +			if (sscanf(optarg, "%3d.%3s", &orig_timeout_secs,
> > +			else if (sscanf(optarg, "%3d", &orig_timeout_secs) == 1) { ; }
> > +			else {
> 
> I don't quite understand the sense of the "else if" here. You could also 
> write:
> else if (sscanf(optarg, "%3d", &orig_timeout_secs) != 1)
Yep, you're right, I guess I was thinking too 'imperative' here
:D.
> and write no else block but I don't see why 1 second should be accepted and 
> nothing else ?
Nope, sscanf returns the number of succesfully scanned values, so
the 1 is not actually 1sec. But you're right, it can't read more
than 1 with only one %d in it anyway, so checking sscanf() < 1
would be fine too.

Anyway, I guess you're right, that integer arithmetics was pretty
much like using a slegdehammer to crack a nut in this case :).

See new patches for a less 'creative' approach :P.
> 
> Regards,
> Marek
> 

Cheers, Linus
