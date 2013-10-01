Return-Path: <andrew@lunn.ch>
Date: Tue, 1 Oct 2013 22:26:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20131001202648.GT11097@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Alfred batadv-vis json conformance
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Janne Paatero <janne.paatero@ruag.com>

Hi Folks

I will soon need to parse the output of batadv-vis -f json.  However,
its not really, json, it does not pass json validation tools. Hence i
doubt i can use the standard parsing libraries.

There has been discussion similar to this recently, about alfred -r,
and a proposal to change the output to make it json conforming. I
would like to raise the discussion of modifying the vis output from
batadv-vis.

I have a simulation system of four nodes, fully interconnected, with
one double link, but is rather sort of translation table entries. The
current vis output is:

{ "primary" : "02:00:00:00:12:01" }
{ "router" : "02:00:00:00:12:01", "neighbor" : "02:00:00:00:10:01", "label" : "1.000" }
{ "router" : "02:00:00:00:12:01", "neighbor" : "02:00:00:00:13:01", "label" : "1.004" }
{ "router" : "02:00:00:00:12:01", "neighbor" : "02:00:00:00:11:01", "label" : "1.000" }
{ "router" : "02:00:00:00:12:01", "gateway" : "8e:4c:88:c4:76:c5", "label" : "TT" }
{ "primary" : "02:00:00:30:10:01" }
{ "secondary" : "02:00:00:00:10:01", "of" : "02:00:00:30:10:01" }
{ "router" : "02:00:00:30:10:01", "neighbor" : "02:00:00:30:13:01", "label" : "1.000" }
{ "router" : "02:00:00:00:10:01", "neighbor" : "02:00:00:00:12:01", "label" : "1.000" }
{ "router" : "02:00:00:00:10:01", "neighbor" : "02:00:00:00:13:01", "label" : "1.000" }
{ "router" : "02:00:00:00:10:01", "neighbor" : "02:00:00:00:11:01", "label" : "1.000" }
{ "router" : "02:00:00:30:10:01", "gateway" : "f6:00:48:13:d3:1e", "label" : "TT" }
{ "primary" : "02:00:00:00:11:01" }
{ "router" : "02:00:00:00:11:01", "neighbor" : "02:00:00:00:10:01", "label" : "1.000" }
{ "router" : "02:00:00:00:11:01", "neighbor" : "02:00:00:00:12:01", "label" : "1.000" }
{ "router" : "02:00:00:00:11:01", "neighbor" : "02:00:00:00:13:01", "label" : "1.000" }
{ "router" : "02:00:00:00:11:01", "gateway" : "ee:be:f3:0f:26:66", "label" : "TT" }
{ "primary" : "02:00:00:00:13:01" }
{ "secondary" : "02:00:00:30:13:01", "of" : "02:00:00:00:13:01" }
{ "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:10:01", "label" : "1.000" }
{ "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:12:01", "label" : "1.000" }
{ "router" : "02:00:00:30:13:01", "neighbor" : "02:00:00:30:10:01", "label" : "1.016" }
{ "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:11:01", "label" : "1.000" }
{ "router" : "02:00:00:00:13:01", "gateway" : "8e:4c:77:b3:65:b4", "label" : "TT" }

My first suggestion for a conforming output would be:  

[
  { "primary" : "02:00:00:00:12:01", 
    "neighbors" : [
        { "router" : "02:00:00:00:12:01", "neighbor" : "02:00:00:00:10:01", "label" : "1.000" },
        { "router" : "02:00:00:00:12:01", "neighbor" : "02:00:00:00:13:01", "label" : "1.004" },
        { "router" : "02:00:00:00:12:01", "neighbor" : "02:00:00:00:11:01", "label" : "1.000" }
    ],
    "TT" : [
      { "router" : "02:00:00:00:12:01", "gateway" : "8e:4c:88:c4:76:c5" }
    ]
  },
  { "primary" : "02:00:00:30:10:01",
    "secondary" : [
       "02:00:00:00:10:01"
    ],
    "neighbors" : [
      { "router" : "02:00:00:30:10:01", "neighbor" : "02:00:00:30:13:01", "label" : "1.000" },
      { "router" : "02:00:00:00:10:01", "neighbor" : "02:00:00:00:12:01", "label" : "1.000" },
      { "router" : "02:00:00:00:10:01", "neighbor" : "02:00:00:00:13:01", "label" : "1.000" },
      { "router" : "02:00:00:00:10:01", "neighbor" : "02:00:00:00:11:01", "label" : "1.000" }
    ],
    "TT" : [
      { "router" : "02:00:00:30:10:01", "gateway" : "f6:00:48:13:d3:1e" }
    ]
  },
  { "primary" : "02:00:00:00:11:01",
    "neighbors" : [
      { "router" : "02:00:00:00:11:01", "neighbor" : "02:00:00:00:10:01", "label" : "1.000" },
      { "router" : "02:00:00:00:11:01", "neighbor" : "02:00:00:00:12:01", "label" : "1.000" },
      { "router" : "02:00:00:00:11:01", "neighbor" : "02:00:00:00:13:01", "label" : "1.000" }
    ],
    "TT" : [
      { "router" : "02:00:00:00:11:01", "gateway" : "ee:be:f3:0f:26:66" }
    ]
  },
  { "primary" : "02:00:00:00:13:01",
    "secondary" : [ 
      "02:00:00:30:13:01"
    ],
    "neighbors" : [
       { "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:10:01", "label" : "1.000" },
       { "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:12:01", "label" : "1.000" },
       { "router" : "02:00:00:30:13:01", "neighbor" : "02:00:00:30:10:01", "label" : "1.016" },
       { "router" : "02:00:00:00:13:01", "neighbor" : "02:00:00:00:11:01", "label" : "1.000" }
    ],
    "TT" : [
       { "router" : "02:00:00:00:13:01", "gateway" : "8e:4c:77:b3:65:b4" }
    ]
  }
]

I'm also wondering if label and gateway could have more meaningful
names? TQ and host? Also, is TT the best?

I would like suggestions and comments from others with more experience
with json. Is the basic structure O.K. Are there better names to use?

There is also the issue of can we change the format of the current
output. Is it considered an ABI? Should I add a third format string
which can be passed with -f to produce true json, and leave the old
format as is, for backward compatibility?

Thanks
	Andrew
