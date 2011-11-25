Return-Path: <andrew@lunn.ch>
Date: Fri, 25 Nov 2011 09:45:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111125084556.GG6836@lunn.ch>
References: <1322173279-18338-1-git-send-email-ordex@autistici.org>
	<1322173279-18338-6-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1322173279-18338-6-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 5/7] batman-adv: Distributed ARP Table
 - add snooping functions for ARP messages
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

Hi Antonio

General question. In the Linux ARP decode code is:

/*
 *      Check for bad requests for 127.x.x.x and requests for multicast
 *      addresses.  If this is one such, delete it.
 */
        if (ipv4_is_loopback(tip) || ipv4_is_multicast(tip))
                goto out;

I don't see the same filtering here. What would happen if you did
receiver and cached such a bad request?

In a similar direction, how does duplicate address detection work?
i.e. i ARP my own address to see if somebody else is using it? 

Or do i just need to RTFM your GSOC documentation :-)

   Andrew
