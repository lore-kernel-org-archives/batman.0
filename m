Return-Path: <andrew@lunn.ch>
Date: Thu, 3 Oct 2013 11:05:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20131003090507.GC20056@lunn.ch>
References: <20131001202648.GT11097@lunn.ch>
 <20131002130548.GA24077@pandem0nium>
 <20131002160106.GA1939@neomailbox.net>
 <524D0A04.4090702@hundeboll.net> <20131003081124.GA20056@lunn.ch>
 <20131003082221.GC1939@neomailbox.net>
 <20131003085316.GB20056@lunn.ch>
 <20131003090056.GD1939@neomailbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131003090056.GD1939@neomailbox.net>
Subject: Re: [B.A.T.M.A.N.] Alfred batadv-vis json conformance
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Janne Paatero <janne.paatero@ruag.com>

> > > What about the source version? How did you get it from the module?
> > 
> > It is the alfred version, not the kernel module version.
> 
> Ok (but I don't see how it can be useful)

If for some reason we need to change the format in a none backwards
compatible way, it gives us a key we can use to determine what format
is in use.

It is just an idea, i've no strong preference.

   Andrew
