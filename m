Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 31 Mar 2016 18:53:24 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160331165324.GC2989@otheros>
References: <56F5AF2F.6060904@t-online.de> <34764958.y3lWsCmXTL@prime>
 <20160330135842.GA19985@r2d2.s.lihas.de> <3605600.IEJkB4EzUh@prime>
 <20160331153512.GA2989@otheros> <20160331154931.GE5258@prodigo.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160331154931.GE5258@prodigo.lan>
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

On Thu, Mar 31, 2016 at 11:49:31PM +0800, Antonio Quartulli wrote:
> On Thu, Mar 31, 2016 at 05:35:13PM +0200, Linus Lüssing wrote:
> > On Thu, Mar 31, 2016 at 02:11:19PM +0200, Simon Wunderlich wrote:
> > - can still break some setups if bridges on remote devices are involved
> >   (for instance bridge between ethernet and adhoc, like Adrian
> >   pointed out)
> 
> in this case the user can still manually change the flag through sysfs no ?

Hm, depends. The owner of that new device with the bridge
cannot necessarilly change the config on the batman-adv node as
that can be a totally different device with another owner.

Additionally the broken setups might be difficult to debug or even
notice.
