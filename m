Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 24 Aug 2009 17:02:32 +0800
References: <20090823130934.GA28556@ma.tech.ascom.ch>
In-Reply-To: <20090823130934.GA28556@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200908241702.32201.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [batman-adv] Use prinkt instead of debug_log
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hey,

> If batman is to get into mainline, the use of debug_log will need to
> be removed. This is a first step in this direction. It replaces
> debug_log calls for CRITICAL, WARNING and NOTICE with printk calls.
> It tries to consistently prefix all such output with "batman:" making
> it easier to find such output mixed in with other kernel messages.
> LOG_TYPE_BATMAN and LOG_TYPE_ROUTES has not been changed.

thanks a lot for your patch and thoughts. 
Does this patch mean you got in touch with a maintainer and he/she suggested 
to do that ? What else did he/she suggest ?
I'm asking because I want to understand in which direction we are moving 
before I start rowing.  ;-)

Regards,
Marek
