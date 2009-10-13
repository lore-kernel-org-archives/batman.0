Return-Path: <andrew@lunn.ch>
Date: Tue, 13 Oct 2009 10:00:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091013080020.GF21060@lunn.ch>
References: <20091012081122.GB12833@lunn.ch>
	<65D79C94-1997-418C-B773-54D0E79D5FA3@7degrees.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65D79C94-1997-418C-B773-54D0E79D5FA3@7degrees.co.za>
Subject: Re: [B.A.T.M.A.N.] Changing vis output ready for mainline...
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

> Couple of questions:
> 
> * Would (<TQ_Value> / 255) be equivalent to the label value in the
> current vis output?


Here is the current kernel code:

#define TQ_MAX_VALUE 255
[snip]
    /* kernel has no printf-support for %f? it'd be better
     * to return this in float. */
    int_part = TQ_MAX_VALUE / entry->quality;
    frac_part = (1000 * TQ_MAX_VALUE / entry->quality) -
            (int_part * 1000);
[snip]
            seq_printf(seq,
                       "\t\"%s\" -> \"%s\" [label=\"%d.%d\"]\n",
                       from, to, int_part, frac_part);

  Andrew
