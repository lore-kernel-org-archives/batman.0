Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 9 Mar 2012 17:42:56 +0800
References: <4F4F6D18.3070403@ninux.org> <20120309085636.GA9018@pandem0nium>
	<CANjd3nd5+8n2frV_FVLbONyAj4An8Rcq=mOu-pVk-3nzp8Kk_w@mail.gmail.com>
In-Reply-To: <CANjd3nd5+8n2frV_FVLbONyAj4An8Rcq=mOu-pVk-3nzp8Kk_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Message-Id: <201203091742.56498.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh] Battlemesh v5 tests
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
To: b.a.t.m.a.n@lists.open-mesh.org, Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>

On Friday, March 09, 2012 17:17:47 Benjamin Henrion wrote:
> > Maybe "algorithm" is a big word for a little feature like that. The
> > bonding and interface alternating basically work in two steps:
> > 
> >  1) detect that a neighbor is reachable via two different links
> >  2) use the two different links for various manipulations (bonding,
> > interface alternation)
> 
> Hoping over the same frequency should be made costly.
> 
> Do you add a cost if the packet comes from the same wireless interface?

Since this question keeps coming up and also seems to be the reason for the 
confusion, let me make it clear once more: There is no special protocol 
treatment in any way. No added cost, no protocol change, no magic commandline 
switches, etc. It simply is not necessary! 

This concept is so plain simple that everybody keeps wondering what we are 
hiding. You are looking for something that is not there.

Cheers,
Marek


PS: Admittedly, it took us several attempts to make it that simple. :)
