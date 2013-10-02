Return-Path: <andrew@lunn.ch>
Date: Wed, 2 Oct 2013 15:36:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20131002133600.GD16339@lunn.ch>
References: <20131001202648.GT11097@lunn.ch>
 <20131002130548.GA24077@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131002130548.GA24077@pandem0nium>
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

On Wed, Oct 02, 2013 at 03:05:48PM +0200, Simon Wunderlich wrote:
> Hey Andrew,
> 
> On Tue, Oct 01, 2013 at 10:26:48PM +0200, Andrew Lunn wrote:
> > Hi Folks
> > 
> > I will soon need to parse the output of batadv-vis -f json.  However,
> > its not really, json, it does not pass json validation tools. Hence i
> > doubt i can use the standard parsing libraries.
> 
> Yes, it is only JSON line-wise, but not the whole output. This output format
> however is the same as we have/had in the batctl JSON output which comes
> from the kernel (I think that was your contribution in the first place?).
> 
> Therefore I'd like to leave this old format as it is to allow communities
> to seamlessly switch from batctl json vis to alfred-vis.

Hi Simon

That is what i was expecting. So when i did the first implementation
this morning, i added a new format, cjson, for conforming json. Not
the best of names, but i could not think of anything better.

> I don't want to "parse" any transferred data in alfred, but we can do this
> for tools like alfred-vis 

No parsing needed, its just needs new functions to print it. RFC patch
to come soon.

> >   { "primary" : "02:00:00:00:13:01",
> >     "secondary" : [ 
> >       "02:00:00:30:13:01"
> >     ],
> >     "neighbors" : [
> >        { "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:10:01", "label" : "1.000" },
> >        { "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:12:01", "label" : "1.000" },
> >        { "router" : "02:00:00:30:13:01", "neighbor" : "02:00:00:30:10:01", "label" : "1.016" },
> >        { "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:11:01", "label" : "1.000" }
> >     ],
> >     "TT" : [
> >        { "router" : "02:00:00:00:13:01", "gateway" : "8e:4c:77:b3:65:b4" }
> >     ]
> >   }
> > ]
> > 
> > I'm also wondering if label and gateway could have more meaningful
> > names? TQ and host? Also, is TT the best?
> 
> Hm, that is a good question. We also have the batman v with new metrics
> coming up,

I've not been following BATMAN V too well. Is it metric, or metrics?
Can we simply change label to metric?

> Maybe we can change the names to:
>  * for neighbors: router->nexthop
>  * TT: "gateway" -> "client", "router" -> "node", maybe also change TT to clients?

So here is what i have implemented.

# batadv-vis -f cjson 
[
  { "primary" : "02:00:00:00:12:01",
    "neighbors" : [
       { "router" : "02:00:00:00:12:01",
         "neighbor" : "02:00:00:00:10:01",
         "metric" : "1.000" },
       { "router" : "02:00:00:00:12:01",
         "neighbor" : "02:00:00:00:13:01",
         "metric" : "1.012" },
       { "router" : "02:00:00:00:12:01",
         "neighbor" : "02:00:00:00:11:01",
         "metric" : "1.000" }
    ],
    "clients" : [
       { "node" : "02:00:00:00:12:01",
         "client" : "8e:4c:88:c4:76:c5" }
    ]
  }
]

	Andrew
