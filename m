Return-Path: <max@principal.rfc2324.org>
Date: Tue, 23 Jan 2018 22:56:25 +0100
From: Maximilian Wilhelm <max@rfc2324.org>
Message-ID: <20180123215625.GD27702@principal.rfc2324.org>
References: <6d1b250c047fb4cd3aac72d9e921ed33428fdaf5.1516648598.git.mschiffer@universe-factory.net>
 <2357913.Ue9Sgfg8BR@sven-edge>
 <9411aa2d-e39f-718e-9c99-40be6a0143f8@universe-factory.net>
 <b5dbfebb-0d14-e1e2-5e8f-3bdc35b664b9@universe-factory.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5dbfebb-0d14-e1e2-5e8f-3bdc35b664b9@universe-factory.net>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Sven Eckelmann <sven@narfation.org>, Maximilian Wilhelm <max@sdn.clinic>, Mephisto <mephisto@mephis.to>, Felix Kaechele <felix@kaechele.ca>

Anno domini 2018 Matthias Schiffer scripsit:

Hi,

> On 01/22/2018 10:18 PM, Matthias Schiffer wrote:
> > On 01/22/2018 09:52 PM, Sven Eckelmann wrote:
> >> On Montag, 22. Januar 2018 20:24:50 CET Matthias Schiffer wrote:
> >>> skb_postpull_rcsum() is necessary after eth_type_trans() to adjust the
> >>> skb checksum, otherwise log spam of the form "bat0: hw csum failure" will
> >>> result when packets with CHECKSUM_COMPLETE are received (at least in some
> >>> setups, e.g. when stacking batman-adv on top of VXLAN).
> >>
> >> Would be nice to have a better explanation here.
> >>
> >> The comment previously assumed that skb_pull_rcsum would be enough. But the 
> >> problem here is that the skb_pull_rcsum only pulls the batman-adv headers. The 
> >> actual pull of the ethernet header (with skb_pull_inline) happens inside 
> >> eth_type_trans. Or did I miss anything?
> > 
> > This is correct, eth_type_trans() contains a simple skb_pull(), so the csum
> > must be adjusted afterwards (grepping the kernel for eth_type_trans will
> > find a lot of this). I can send a v2 with a better commit message later.
> > 
> >>
> >> [...]
> >>> I don't know what the exact circumstances are that trigger the log spam,
> >>> but it seems this was broken forever (I could also reproduce the issue with
> >>> our compat-14 legacy branch)... so please ask David to queue this up for
> >>> stable :)
> >>
> >> Yes, this is broken since earliest commits. The most relevant commit in 
> >> batman-adv is:
> >>
> >> Fixes: fe28a94c01e1 ("batman-adv: receive packets directly using skbs")
> >>
> >> But I would propose to use following in the kernel tree:
> >>
> >> Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
> >>
> >> The 4.15 release will be soon(tm) and Simon is currently on vacation. So we 
> >> will most likely postpone the submission to David until Simon found a way out 
> >> of the snow and after 4.15 is released...
> >>
> >> But it would be nice when some people could test the patch [1] (together with 
> >> vxlan?) on batman-adv or batman-adv-legacy. And please provide a 
> >> "Tested-by: Full Name <email@example.org>" [2] reply when it works.
> >>
> >> Thanks,> 	Sven
> > 
> > I've tested this on Kernel 4.14.14 (everything working correctly now) and
> > 4.4.110 (here, there are still checksum errors; it seems on older kernels,
> > the checksum handling in VXLAN is broken too? Still debugging this...)
> 
> I've found the issue of this other checksum problem: batman-adv
> fragmentation code doesn't handle the checksum on reassembly at all. I
> think the best option here is to simply set ip_summed to CHECKSUM_NONE on
> reassembly, I will send another patch for that.
> 
> The IP fragmentation code does more fancy things when all fragments have
> CHECKSUM_COMPLETE, adding up the checksums of the fragments under certain
> circumstances. This only works because IP fragments are guaranteed to be
> split at even byte offsets (multiples of 8, actually); as far as I can
> tell, batman-adv allows odd fragment sizes, making it impossible to add up
> the 16bit checksums in the general case.

And

  Tested-By: Maximilian Wilhelm <max@sdn.clinic>

to the fix for fragmentation.c, too.

Disclaimer: As MTUs are calculated accordingly in our backbone
fragmentation of VXLAN packets isn't an issue and we did not see these
messages before. I can confirm, that I still don't see any now,
meaning the log spam from the previous fix is still fixed and no new
issues have arisen as of now.

Thanks a lot! <3

Best
Max
-- 
"Does is bother me, that people hurt others, because they are to weak to face the truth? Yeah. Sorry 'bout that."
 -- Thirteen, House M.D.
