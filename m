Return-Path: <gmazzurco89@gmail.com>
Sender: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Message-ID: <500AFACD.7070207@eigenlab.org>
Date: Sat, 21 Jul 2012 20:54:05 +0200
From: Gioacchino Mazzurco <gio@eigenlab.org>
MIME-Version: 1.0
References: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
In-Reply-To: <CAHD-aqJUX0LxRfxrqJL4-oc7+QxLRdfiHikY40FvafL3pgEUyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman majareta? I can batctl ping but not ping
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

Same bug today in ninux pisa after a node was turned off the entire
network became crazy for 2 hours, to solve i had to restart a lot of
nodes... :|

On 07/02/12 15:30, Guido Iribarren wrote:
> (which roughly translates as "batman gone nuts?")
> Hey great devs!
> we've been having a particular issue in deltalibre and quintanalibre
> (local WCN) with batman-adv, but so far we haven't found a precise way
> to reproduce it.
> The symptom is that (after some reboots or physical displacements?)
> one batman-adv host becomes unreachable on layer3, although it is seen
> on originators table, and can be batctl ping'ed or batctl tracerout'ed
> with no problem whatsoever.
> 
> Even more, it not unreachable from the whole network, but instead from
> just a few other nodes. So, let's say that the nearer nodes can layer3
> ping it , but some others farther away cannot (although i can't assure
> it depends on the hop distance)
> All of them can batctl ping it (layer2)
> A hard reboot of all the nodes solves it, connectivity is restored in
> all directions.
> 
> Thing is, I've just came across it again, and managed to do some tests
> to aid in description / debugging
> As an aid in understanding network topology,
> I'm attaching the wonderful output of "batctl vd dot |grep -v TT" for
> your viewing delight
> 
> problem node is ana
> it can be reached from ruth and hquilla (direct neighbours)
> but arping behaves erratically from colmena or charly
> and normal ping (v4 or v6) doesn't receive any reply at all when run
> from colmena or charly
> 
> I used arping, with and without -b , and seemed like i could narrow
> the problem down to incoming broadcast packet handling, but further
> tests just left me more puzzled!
> 
> all nodes are tl-mr3220 running openwrt trunk r31316 with batman-adv
> 2012.2.0 , driver ath9k
> secondary interfaces named _wlan1 are all tl-wn722n which uses driver ath9k_htc
> nodes are around 100meters (+/-50mts) apart from each other
> 
> this behaviour has been observed (but not reported) in dissimilar
> setups, using ubnt bullet2 mixed with mr3220, running r29936 with
> batman-adv 2011.4.0 , with nodes 1 or 2km apart from each other.
> 
> Tests are the combined crude output of batctl td and arping, so to
> make this email ease on the eye, i'm publishing them elsewhere:
> http://pastebin.com/6PPwN3PS
> 
> The live openwrt configuration can be analysed in detail at
> https://bitbucket.org/guidoi/deltalibre-configs/src
> (it's a free, open network after all! :D )
> in particular:
> ana -> https://bitbucket.org/guidoi/deltalibre-configs/src/6de4ce970fe2/mac/54_E6_FC_BE_26_12
> hquilla -> https://bitbucket.org/guidoi/deltalibre-configs/src/6de4ce970fe2/mac/54_E6_FC_BE_28_34
> colmena -> https://bitbucket.org/guidoi/deltalibre-configs/src/6de4ce970fe2/mac/54_E6_FC_BE_29_D2
> 
> Thanks a lot for the attention,
> Hope that you are having fun, and that I'm not spoiling it :)
> 
> Cheers!
> 
> Gui
