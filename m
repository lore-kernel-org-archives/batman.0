Return-Path: <andrew@lunn.ch>
Date: Tue, 7 Feb 2012 13:46:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120207124620.GB15165@lunn.ch>
References: <201202071719.22804.lindner_marek@yahoo.de>
	<1328606451-3418-2-git-send-email-lindner_marek@yahoo.de>
	<20120207121200.GA15165@lunn.ch>
	<201202072021.55937.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201202072021.55937.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/8] batman-adv: randomize initial seqno
 to avoid collision
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

On Tue, Feb 07, 2012 at 08:21:55PM +0800, Marek Lindner wrote:
> On Tuesday, February 07, 2012 20:12:00 Andrew Lunn wrote:
> > Does this sequence number have any security relevance? Does it make
> > sense to use the TCP sequence number generation code?
> 
> There is no security relevance I know of. The idea was simply to start with 
> random number. Random is a bit better than 1.  ;-)
> 
> Where can I find the TCP sequence number code you are referring to ?

I had to go find it, since i've never looked at it before.

net/core/secure_seq.c:

__u32 secure_tcp_sequence_number(__be32 saddr, __be32 daddr,
                                 __be16 sport, __be16 dport)

but it does not look very re-usable, since it takes all these
addresses. What might be usable is:

__u32 secure_ip_id(__be32 daddr)
{
        u32 hash[MD5_DIGEST_WORDS];

        hash[0] = (__force __u32) daddr;
        hash[1] = net_secret[13];
        hash[2] = net_secret[14];
        hash[3] = net_secret[15];

        md5_transform(hash, net_secret);

        return hash[0];
}

passing it the last four bytes of the originator MAC address?

	Andrew
