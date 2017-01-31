Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 31 Jan 2017 21:39:59 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170131203959.GA3899@otheros>
References: <20170129051428.12179-1-linus.luessing@c0d3.blue>
 <1710363.lgBWTzDvpW@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1710363.lgBWTzDvpW@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: decrease maximum fragment
	size
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

On Tue, Jan 31, 2017 at 12:07:24PM +0100, Sven Eckelmann wrote:
> On Sonntag, 29. Januar 2017 06:14:28 CET Linus Lüssing wrote:
> [...]
> > However, currently "Fragmentation v2" does not support re-fragmentation.
> > Which means that once a packet is split into two packets of 1400 + x
> > bytes for instance and the next hop provides an interface with an even
> > smaller MTU of 1280 bytes, then the larger fragment is lost.
> [...]
> 
> Beside this change, did you try to make the fragments more equally sized?
> Here is just some really ugly and untested pseudo code:

Have thought about it initially but pushed it asided when I
noticed it would only help regarding the initial issue for the
unicast packets but not potentially large TTs.

But generally, I like the idea of making fragments more equally
sized :-).
