Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 19 Apr 2015 19:49:00 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150419174900.GG2396@odroid>
References: <1429298961-13250-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1429298961-13250-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Use kernel-like folder
	structure
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Fri, Apr 17, 2015 at 09:29:21PM +0200, Sven Eckelmann wrote:
> The person submitting the patches to the Networking maintainer has to take each
> patch and move files around and add some files to make it work in the actual
> kernel tree. Having all files included and already  in the correct kernel tree
> layout should make this a lot easier.

I like the idea. Was moving patches between in- and
out-of-kernel-tree batman-adv a few times, too and that'd
spare an sed call in the future :).
