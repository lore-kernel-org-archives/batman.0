Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 27 Mar 2012 12:58:57 +0300
References: <201203261241.32890.lindner_marek@yahoo.de>
	<4F70E2EF.4060009@nixbits.net>
In-Reply-To: <4F70E2EF.4060009@nixbits.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201203271258.57514.lindner_marek@yahoo.de>
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

On Tuesday, March 27, 2012 00:43:11 HeXiLeD wrote:
> I have been trying to apply the patch which tries to fix the openwrt
> scripts in regards having batman-adv to bring up all it's attached 
> interfaces but something seems not to be working.

Seems to be same problem we already discussed in the IRC channel.


> $ patch -p2 < batman-adv_load-module-when-needed.patch 99-batman-adv

That is not the way to apply a patch. Omit the last argument.


> $ patch -p1< batman-adv_load-module-when-needed.patch
> can't find file to patch at input line 3

Wrong path.


> $ patch -p1< batman-adv_load-module-when-needed.patch 
> can't find file to patch at input line 3

Wrong path.


You have to find the correct package path and don't supply too many arguments 
to make it work.

Regards,
Marek
