Return-Path: <max@principal.rfc2324.org>
Date: Tue, 23 Jan 2018 15:25:19 +0100
From: Maximilian Wilhelm <max@rfc2324.org>
Message-ID: <20180123142519.GC27702@principal.rfc2324.org>
References: <6d1b250c047fb4cd3aac72d9e921ed33428fdaf5.1516648598.git.mschiffer@universe-factory.net>
 <2357913.Ue9Sgfg8BR@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2357913.Ue9Sgfg8BR@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix packet checksum in
 receive path
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Matthias Schiffer <mschiffer@universe-factory.net>, Maximilian Wilhelm <max@sdn.clinic>, Felix Kaechele <felix@kaechele.ca>, Mephisto <mephisto@mephis.to>

Anno domini 2018 Sven Eckelmann scripsit:

> On Montag, 22. Januar 2018 20:24:50 CET Matthias Schiffer wrote:
[...]
> > I don't know what the exact circumstances are that trigger the log spam,
> > but it seems this was broken forever (I could also reproduce the issue with
> > our compat-14 legacy branch)... so please ask David to queue this up for
> > stable :)
> 
> Yes, this is broken since earliest commits. The most relevant commit in 
> batman-adv is:
> 
> Fixes: fe28a94c01e1 ("batman-adv: receive packets directly using skbs")
> 
> But I would propose to use following in the kernel tree:
> 
> Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
> 
> The 4.15 release will be soon(tm) and Simon is currently on vacation. So we 
> will most likely postpone the submission to David until Simon found a way out 
> of the snow and after 4.15 is released...
> 
> But it would be nice when some people could test the patch [1] (together with 
> vxlan?) on batman-adv or batman-adv-legacy. And please provide a 
> "Tested-by: Full Name <email@example.org>" [2] reply when it works.

I took a Debian Kernel package (4.14.13-1~bpo9+1), applied the patch
and deployed the package on a gateway running BATMAN over VTEPs. The
log messages from previous kernels don't show up anymore <3.

Tested-by: Maximilian Wilhelm <max@sdn.clinic>

Thanks!

Best
Max
-- 
"I have to admit I've always suspected that MTBWTF would be a more useful
 metric of real-world performance."
 -- Valdis Kletnieks on NANOG
