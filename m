Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 9 Jan 2016 03:29:25 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160109022925.GG5675@otheros>
References: <2457136.iz2mu7y0Mc@voltaire>
 <20151231110712.GD30632@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20151231110712.GD30632@otheros>
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

On Thu, Dec 31, 2015 at 12:07:12PM +0100, Linus Lüssing wrote:
> * Suggestion: Change "If the OGMv2 sequence number is not newer or equal
>   compared to the last received OGMV2 (from any neighbor for this
>   originator) and if the throughput is not better, drop the OGMv2"
>   to:
>   "[...] (from the currently selected router for this originator) [...]"
> 
>   (-> is another sequence number check here redundant?
>       see "Age check above"? maybe some merging+reordering here?)

Another issue I just noticed with the according sentence we have
in the spec right now:

Bad news never travells:

We would ignore updates from our selected router if the path
throughput got worse - even if it's a new sequence number.

* Add a branch: If seqno is new + from currently selected router:
  -> accept (even if path throughput is lower than with the previous seqno)
