Return-Path: <linus.luessing@web.de>
Date: Tue, 19 Apr 2011 15:29:35 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110419132935.GA20312@Sellars>
References: <BANLkTin=6SArq_5+n7SMRHfX2p-RGgsomA@mail.gmail.com>
	<BANLkTikBcWdW==dP8BG4Ud5HjxyQ0z0n3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BANLkTikBcWdW==dP8BG4Ud5HjxyQ0z0n3A@mail.gmail.com>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] batman-adv vis_data
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tue, Apr 19, 2011 at 09:46:10AM +0200, Gioacchino Mazzurco wrote:
> moreover the two node have two interfaces used by batman-adv but only
> one is displayed!
> 
> 2011/4/19 Gioacchino Mazzurco <gmazzurco89@gmail.com>:
> > Hi!
> >
> > In Pisa we are switching to batman-adv for our mesh, we use the
> > version packaged in openwrt.
> >
> > But it seems that the output of vd is not conform to specification in
> > this page  http://www.open-mesh.org/wiki/batman-adv/VisAdv
> >
> > especially the box representing a node is painted only for the node
> > where you call 'batctl vd dot'
> >
> > here you can see what is happening
> > http://eigenlab.org/batman-adv_status.php to simplify visualization i
> > am generating it with 'batctl vd dot -H'
> >
> 

Hi Gioacchino,

As far as I know the format for the batman-adv vis output has not
been changed on purpose and the wiki page should reflect the current
specification. So you might possibly have found a bug.

So guessing from the link, you are testing this with two nodes
(with two interfaces as you said) with perfect link qualities and
the issue already comes up, correct?

It would be great if you could provide the following additional
data from this two node setup:
- The raw vis output from /sys/kernel/debug/batman_adv/bat0/vis_data
- The originator table of the two nodes from
  /sys/kernel/debug/batman_adv/bat0/originators

Cheers, Linus
