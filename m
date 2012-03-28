Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 28 Mar 2012 14:36:57 +0300
References: <201203261241.32890.lindner_marek@yahoo.de>
	<201203271258.57514.lindner_marek@yahoo.de>
	<4F72E60C.2010300@nixbits.net>
In-Reply-To: <4F72E60C.2010300@nixbits.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201203281436.57795.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv load module patch
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
To: HeXileD@nixbits.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wednesday, March 28, 2012 13:21:00 HeXiLeD wrote:
> After the patch i compiled and used the builds.
> I tried one build from source and another made with the image builder
> 
> At boot; batman-adv still does not load both interfaces, only 1. (wlan0)
> In other to load both: batman-adv restart must be executed.

Did you verify that the patched script actually is on your router ? A quick 
peek into the installed shell scripts should eliminate this doubt.

Regards,
Marek
