Return-Path: <andrew@lunn.ch>
Date: Fri, 28 Jan 2011 18:24:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110128172416.GW23716@lunn.ch>
References: <1296052208-6041-1-git-send-email-lindner_marek@yahoo.de>
	<20110126154127.GA6813@lunn.ch>
	<201101271327.58266.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201101271327.58266.lindner_marek@yahoo.de>
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

On Thu, Jan 27, 2011 at 01:27:57PM +0100, Marek Lindner wrote:
> 
> Hi,
> 
> > > +	shost = wifi_hdr->addr2;
> > > +	if (fc & IEEE80211_FCTL_FROMDS)
> > > +		shost = wifi_hdr->addr3;
> > > +	else if (fc & IEEE80211_FCTL_TODS)
> > > +		shost = wifi_hdr->addr4;
> > > +
> > > +	dhost = wifi_hdr->addr1;
> > > +	if (fc & IEEE80211_FCTL_TODS)
> > > +		dhost = wifi_hdr->addr3;
> > 
> > What would happen if you happened to pick up a WDS packet? Four
> > addresses in the packet. Do we see sensible addresses?
> 
> we should - that is what addr4 is used for but I did not test it. Let me know 
> if it does not work for you.
> 
> 
> > > +
> > > +	hdr_len = 24;
> > > +	if ((fc & IEEE80211_FCTL_FROMDS) && (fc & IEEE80211_FCTL_TODS))
> > > +		hdr_len = 30;
> > 
> > Again, WDS? We are now a few bytes out when decoding the rest of the
> > packet.

OK. Sorry. I'm wrong.

What confused me is time spent debugging WDS in madwifi. It has macros
similar to what you have:

#define IEEE80211_FC1_DIR_NODS                  0x00    /* STA->STA */
#define IEEE80211_FC1_DIR_TODS                  0x01    /* STA->AP  */
#define IEEE80211_FC1_DIR_FROMDS                0x02    /* AP ->STA */
#define IEEE80211_FC1_DIR_DSTODS                0x03    /* AP ->AP  */

So i was expecting to see something like DSTODS. However the madwifi
macros are for the complete DIR field, where as you are looking at
individual bits. So 

(fc & IEEE80211_FCTL_FROMDS) && (fc & IEEE80211_FCTL_TODS) 

is equivalent to the madwifi IEEE80211_FC1_DIR_DSTODS.

So you header length calculation looks O.K.

   Andrew
