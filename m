Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 29 Jun 2015 06:42:46 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150629044246.GD2527@odroid>
References: <1434893777-17618-1-git-send-email-linus.luessing@c0d3.blue>
 <2472003.5ybaWVxMcq@voltaire> <20150628035913.GB2398@odroid>
 <5065799.yHsM5BUa9O@voltaire> <20150629025248.GC2527@odroid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150629025248.GC2527@odroid>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/1] batman-adv: Always flood IGMP/MLD
 reports
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Mon, Jun 29, 2015 at 04:52:48AM +0200, Linus Lüssing wrote:
> The alternative to bumping the version number would be to introduce
> another flag into the mcast tvlv and keep counters and lists similar
> to the num_disabled or want_* ones. So maybe about 80 more lines of
> code and additional state and complexity to maintain.

Another alternative I just had to think about would be to register
both a v1 and v2 TVLV container while only registering a handler
for v2. That'd add just two or four extra lines of code with the same
result. The disadvantage would be a few bytes extra overhead for
dragging a v1 TVLV in the OGMs along.

Actually, I think I'd kinda like that as it has a reasonable
benefit-to-cost ratio. What do others think?

(And maybe such legacy multicast v1 TVLV could then safely be
obsoleted/removed in four years or after evaluating whether someone
still needs it.)
