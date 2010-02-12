Return-Path: <x@muc.ccc.de>
Message-ID: <4B759F9E.6090303@muc.ccc.de>
Date: Fri, 12 Feb 2010 19:36:14 +0100
From: x@muc.ccc.de
MIME-Version: 1.0
References: <4B6F288E.8050406@muc.ccc.de>
	<20100211023909.GB6493@Linus-Debian>	<4B740D82.3030101@muc.ccc.de>
	<201002121909.52617.lindner_marek@yahoo.de>
In-Reply-To: <201002121909.52617.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 0.2 on openwrt
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

hi!

Marek Lindner wrote:
> You can try only recompiling the module. Not sure whether it will work or not.
> Otherwise we have to fallback to the old-style (printk) debugging.  :-)

ok, tried that, the resulting module actually grew by 32B, but still just addresses, no names, sorry...

(a short excerpt:
Function entered at [<c0023890>] from [<c0030234>]
Function entered at [<c00301f0>] from [<c013c348>]
 r6:00004305 r5:c7001240 r4:c7001240
Function entered at [<c013c2c0>] from [<c013c60c>]
 r7:c71db000 r6:c7d47380 r5:c7001240 r4:c71db000
in case the full output might still help, just drop me a note)

iirc it wasn't easy to reproduce the setup - so if i can help by applying a patch, compile, and test, please just tell me what to do :)

regards,

	Chris
