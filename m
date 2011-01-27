Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 27 Jan 2011 13:27:57 +0100
References: <1296052208-6041-1-git-send-email-lindner_marek@yahoo.de>
	<20110126154127.GA6813@lunn.ch>
In-Reply-To: <20110126154127.GA6813@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201101271327.58266.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: add raw wifi packet
	decapsulation support
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


Hi,

> > +	shost = wifi_hdr->addr2;
> > +	if (fc & IEEE80211_FCTL_FROMDS)
> > +		shost = wifi_hdr->addr3;
> > +	else if (fc & IEEE80211_FCTL_TODS)
> > +		shost = wifi_hdr->addr4;
> > +
> > +	dhost = wifi_hdr->addr1;
> > +	if (fc & IEEE80211_FCTL_TODS)
> > +		dhost = wifi_hdr->addr3;
> 
> What would happen if you happened to pick up a WDS packet? Four
> addresses in the packet. Do we see sensible addresses?

we should - that is what addr4 is used for but I did not test it. Let me know 
if it does not work for you.


> > +
> > +	hdr_len = 24;
> > +	if ((fc & IEEE80211_FCTL_FROMDS) && (fc & IEEE80211_FCTL_TODS))
> > +		hdr_len = 30;
> 
> Again, WDS? We are now a few bytes out when decoding the rest of the
> packet.

I don't understand what you are trying to say here. Are you sure it is not 
working or are you worried that WDS might not work ? If you have doubts please 
explain them in more detail.

Thanks,
Marek
