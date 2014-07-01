Return-Path: <onelektra@gmx.net>
Date: Tue, 1 Jul 2014 11:21:42 +0200
From: elektra <onelektra@gmx.net>
Message-Id: <20140701112142.3c8ab7cd16f81b51da706026@gmx.net>
In-Reply-To: <1543341.WcWe2c7VXj@lappi>
References: <1543341.WcWe2c7VXj@lappi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] Fwd: Re:  increasing BATADV_FRAG_MAX_FRAGMENTS
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

Hi –

> > > During an experiment it was found, that
> > > BATADV_FRAG_MAX_FRAGMENTS=16 allows ~72 clients to be connected to
> > > one single access point.
> > would you mind sharing some details regarding the experiments you
> > performed ?  The reason for this question is that there is no 72
> > client limit we know of (unless fragmentation was disabled).

you are very likely looking in the wrong direction. The number of clients allowed to connect to an AP is configurable and 72 is already way beyond what I would consider useful in real life – if your clients are actually supposed to be able to communicate unicast traffic.

Since you are probably using OpenWRT for your tests, look at the configuration parameter maxassoc: http://wiki.openwrt.org/doc/uci/wireless

I don't know the default that OpenWRT uses if you don't set it explicitly. But there is a default limit set somewhere (take a look at hostapd.conf) and you might have discovered that by pushing it to the limit. It might as well be the limitation of your WiFi driver / hardware, though.

Cheers,
Elektra








-- 
Viral meme of radical freedom 
 
The fact that you talk in your head doesn't mean that you think. 
 
The best way to lose control over yourself is trying to control yourself. 
 
Most people experience themselves as a voice in their head, telling them 
 who they are, what they think and what they have to do. 
 
http://en.wikipedia.org/wiki/Meme 
