Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 28 Jan 2010 08:09:57 +0800
References: <20100123174616.GA4795@Sellars>
	<201001261516.39057.lindner_marek@yahoo.de>
	<20100127001049.GA15002@Linus-Debian>
In-Reply-To: <20100127001049.GA15002@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201001280809.58159.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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


Hi,

> nope, does not seem to work, still the same issue
> I also tried it on my laptop here with the patch installed 
> and it is a very similar call trace, although here it is 
> send_vis_packets instead of vis_quit in the call trace.

you should take the stack trace with a grain of salt. Stack tracing such an 
issue is a quite tricky thing, hence can not be fully trusted. Since the skb 
changes the code runs in interrupt context which probably introduced this bug. 
All previous warnings of this kind were related to holding a lock while 
sending packets. My patch unlocked the problematic orig_hash - maybe that was 
not enough ? By adding retrun statements at the beginning of the vis send 
function you might be able to get down to the problem.

Regards,
Marek
