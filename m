Return-Path: <andrew@lunn.ch>
Date: Sat, 26 Mar 2011 17:14:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110326161439.GK17979@lunn.ch>
References: <20110326130451.GC10750@ritirata.org>
	<201103261631.42903.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201103261631.42903.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] TTL yes, TTL no
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

On Sat, Mar 26, 2011 at 04:31:42PM +0100, Marek Lindner wrote:
> 
> Hi,
> 
> > In these days I was wondering whether the TTL field in the OGM packet is
> > really useful or not...Due to hop_penalty an OGM will be discarded as
> > soon as the TQ will reach 0 (which is a sort of TTL mechanism itself).
> > At this point why is the TTL field needed?
> 
> uhm.., you probably are right. As long as there is a hop penalty it also 
> functions as a TTL. Keep in mind that it is possible to set the hop penalty to 
> zero. With the current default hop penalty of 10 the maximum number of hops is 
> limited to 25.

Humm, i could be wrong here.....

static uint8_t hop_penalty(const uint8_t tq, struct bat_priv *bat_priv)
{
        int hop_penalty = atomic_read(&bat_priv->hop_penalty);
        return (tq * (TQ_MAX_VALUE - hop_penalty)) / (TQ_MAX_VALUE);
}

So 10% is deducted, not 10 absolute. So assuming perfect links, TQ
will be:

255
245
235
226
217
208
200
192
184
177
170
163
157
151
145
139
134
129
124
119
114
110
106
102
98
94
90
86
83
80
77
74
71
68
65
62
60
58
56
54

etc...

Depending on how the rounding works, i think somewhere after hop 72
the TQ is always 12.

But maybe i'm not understanding something correctly....

    Andrew
