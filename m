Return-Path: <andrew@lunn.ch>
Date: Thu, 13 Feb 2014 10:45:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140213094516.GB7193@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-15-git-send-email-antonio@meshcoding.com>
 <20140212085812.GH30814@lunn.ch> <52FB68B2.80507@meshcoding.com>
 <52FB96D2.4080406@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52FB96D2.4080406@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 14/23] batman-adv: ELP - compute the metric
 based on the estimated throughput
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

On Wed, Feb 12, 2014 at 04:44:18PM +0100, Antonio Quartulli wrote:
> On 12/02/14 13:27, Antonio Quartulli wrote:
> > On 12/02/14 09:58, Andrew Lunn wrote:
> >> On Tue, Feb 11, 2014 at 01:48:14PM +0100, Antonio Quartulli wrote:
> >>> From: Antonio Quartulli <antonio@open-mesh.com>
> >>>
> >>> Implement a stub get_throughput() function which returns the
> >>> estimated throughput towards a given neighbour.
> >>> Its result is then used to compute the metric value.
> >>>
> >>> The metric is updated each time a new ELP packet is sent,
> >>> this way it is possible to timely react to a metric
> >>> variation which can imply (for example) a neighbour
> >>> disconnection.
> >>
> >> It is very much a style issue, but i would probably split this into
> >> two patches. Updating the metric at send time rather than receive
> >> should have nothing to do with estimated bandwidth.
> > 
> > Yes, to make it easier I will first move the reading at sending time and
> > then I'll introduce the throughput estimation.
> > 
> > 
> 
> 
> Andrew,
> 
> I just rechecked the code and I realised that these "2 changes" are one
> only because there is no "second change".
> 
> Before this patch ELP does not perform any metric estimation.
> 
> This patch adds the estimation mechanism and in particular adds it along
> the ELP message sending path.
> 
> 
> Maybe this was not clear? Maybe some previous patch gave you the
> impression that a sort of metric estimation was already performed in the
> receiving routine?

Ah, ok, it was this comment which confused me:

+       /* Instead of updating the metric each "received" ELP packet, it is
+        * better to do it on each ELP sending. This way, if a node is dead and
+        * does not send packets anymore, batman-adv is still able to timely
+        * react to its death.

The "instead of" suggests it was previously done differently. The
BATMAN philosophy has been in the past to react on received packets,
so i can understand where this came from. But i think this comment
could be worded:

/* The metric is updated on each sent packet.  This way, if a node is
* dead and no longer sends packets, batman-adv is still able to 
* react timely to its death. */

  Andrew
