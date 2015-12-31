Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 31 Dec 2015 12:07:12 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20151231110712.GD30632@otheros>
References: <2457136.iz2mu7y0Mc@voltaire>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2457136.iz2mu7y0Mc@voltaire>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. V leaves the nest
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

Hi,

It's nice to see how the whole BATMAN V idea has matured over the
years and both the documentation and code having become very
clean and simple to read :).


However, I think there is at least one more bug in the
specification that needs fixing, the one I had mentioned to Simon
some days ago on IRC, that with the current writing, there would
never be a selected router.

There are also two more things I would (still) like to discuss
regarding the OGMv2 specification in the wiki:

* Is the check "If the received neighbor is not (yet) a router,
  drop the OGMv2" still necessary? If yes why?

* Suggestion: Change "If the OGMv2 sequence number is not newer or equal
  compared to the last received OGMV2 (from any neighbor for this
  originator) and if the throughput is not better, drop the OGMv2"
  to:
  "[...] (from the currently selected router for this originator) [...]"

  (-> is another sequence number check here redundant?
      see "Age check above"? maybe some merging+reordering here?)

* What does "is adopted"/"are applied" mean in section 3.2.2 and
  section 4? Maybe clarify when the internal stats are updated and
  when the OGMv2? ->

* Suggestion:
  * Move "forward penalties are applied" to section 4
    and change it to "forward penalties are applied to the OGMv2"
  * Change "Path Throughput is adopted if its lower than the link
    throughput to the neighbor, otherwise the link throuput is
    adopted" to:
    "If the link throughput to the neighbor this OGMv2 was
    received from is lower than the Path Throughput of the OGMv2
    then set the Path Throughput of the OGMv2 to this link throughput."
  * Remove "The Path throughput for the considered outoging
    interface is adopted" from section 4.


Also, I guess there is some awareness about potentially slow
convergence speeds. One of the reasons the idea with "RIP"
occured. But I think next to dead nodes, there are some more
scenarios with slow convergence speeds which depends on the
latency of links. Going to write a wiki page with pictures on
that, I think it should at least be documented before a release
(I'd have some ideas to fix it later in a backwards compatible
way, ensuring a convergence within one sequence number - it fact
that fix was in the original OGMv2 page I had written back then
;) ).

Cheers, Linus
