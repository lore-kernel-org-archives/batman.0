Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 20 Nov 2012 16:45:07 +0800
References: <CAG_HyLz9B9r=u5jSw8xy+4rfG9anB6vqK+ggMGSmRossMCx4CQ@mail.gmail.com>
In-Reply-To: <CAG_HyLz9B9r=u5jSw8xy+4rfG9anB6vqK+ggMGSmRossMCx4CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201211201645.07506.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman over 802.15.4 .
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

On Tuesday, November 20, 2012 12:25:34 Randy Graham wrote:
> I tried configuring these interfaces using 'batctl' but it complains
> that they are an unsupported type.
> 'iwconfig' reports these interfaces as having 'no wireless extensions'
> which I suspect is the issue.

The batman-adv kernel module checks for interface compatibility and only if an 
interface is suitable the corresponding /sys/class/net/$iface/batman-adv 
subfolder is created. It is that folder batctl tries to find in order to 
enable batman-adv on the given interface.

Cheers,
Marek
