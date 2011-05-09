Return-Path: <ordex@autistici.org>
Date: Mon, 9 May 2011 22:26:52 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110509202652.GA30350@ritirata.org>
References: <1304579589-5222-1-git-send-email-ordex@autistici.org>
	<1304946150-6026-3-git-send-email-ordex@autistici.org>
	<20110509144812.GB31070@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110509144812.GB31070@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 3/3] batman-adv: improved gateway
 tq-based selection
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

Hi Andrew, hi everyone,

On lun, mag 09, 2011 at 04:48:12 +0200, Andrew Lunn wrote:
> > +	while (*p != 255 && !ret) {
> > +		/* p now points to the first octect: option type */
> > +		if (*p == 53) {
> > +			/* type 53 is the message type option.
> > +			 * Jump the len octect and go to the data octect */
> > +			if (pkt_len < 2)
> > +				goto out;
> > +			pkt_len -= 2;
> > +			p += 2;
> > +
> > +			/* check if the message type is what we need */
> > +			if (*p == DHCP_REQUEST)
> > +				ret = true;
> 
> Why do you continue parsing the options if it is not a DHCP_REQUEST?
> Do you think there will be a second, third, fourth option information
> element 53?

No. There is no reason to continue parsing the options. 
I'll modify the if so that I can exit the while loop as soon as I
find the option 53.

Thanks for finding this detail!

Regards,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
